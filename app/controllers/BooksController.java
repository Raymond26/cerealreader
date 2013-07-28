package controllers;

import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;

import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import play.Play;
import play.mvc.*;
import play.libs.Json;
import play.libs.WS;
import play.libs.F.Function;
import play.libs.F.Promise;
import play.Logger;

import org.codehaus.jackson.node.ObjectNode;
import org.codehaus.jackson.JsonNode;

import models.*;

public class BooksController extends Controller {

    final static String google_api = Play.application().configuration().getString("googlebooks.volumes");
    final static String google_api_key = Play.application().configuration().getString("googlebooks.apikey");
    final static DateTimeFormatter format = DateTimeFormat.forPattern("yyyy-MM-dd");

    public static Result getBooks() {
        return ok(Json.toJson(Book.finderBook.all()));
    }

    public static Result getRecommendations() {
        ObjectNode result = Json.newObject();
        return ok(result);
    }

    public static Result loadBookFromGoogle(final String isbn) {
        if(Book.existsIsbn(isbn)) return ok("didn't load");
        return async(
            WS.url(google_api).setQueryParameter("q",isbn).setQueryParameter("key", google_api_key).get().map(
                    new Function<WS.Response, Result>() {
                        public Result apply(WS.Response response) {
                            JsonNode json = response.asJson();
                            if(json.findPath("totalItems").getIntValue() > 0) {
                                JsonNode volumeInfo = json.findPath("items").get(0).findPath("volumeInfo");

                                Book book = new Book();
                                book.title = volumeInfo.findPath("title").getTextValue();
                                book.authors = volumeInfo.findPath("authors").get(0).getTextValue();
                                book.isbn = isbn;
                                book.publisher = volumeInfo.findPath("publisher").getTextValue();
                                book.publishedDate = format.parseDateTime(volumeInfo.findPath("publishedDate").getTextValue());
                                book.description = volumeInfo.findPath("description").getTextValue();
                                book.pageCount = volumeInfo.findPath("pageCount").getIntValue();
                                book.averageRating = volumeInfo.findPath("averageRating").getIntValue();
                                book.ratingsCount = volumeInfo.findPath("ratingsCount").getIntValue();
                                book.thumbnail = volumeInfo.findPath("imageLinks").findPath("thumbnail").getTextValue();

                                book.save();
                            }
                            return ok("received response");
                        }
                    }
            )
        );
    }

    public static Result getSuggestionsISBN(final String isbn) {
        return async(
        WS.url(google_api).setQueryParameter("q",isbn).get().map(
            new Function<WS.Response, Result>() {
                public Result apply(WS.Response response) {
                    JsonNode json = response.asJson();
                    List<Book> suggestions = new ArrayList<Book>();
                    if(json.findPath("totalItems").getIntValue() > 1) {
                        for(int i = 1; i < json.findPath("totalItems").getIntValue(); i++) {
                            JsonNode volumeInfo = json.findPath("items").get(i).findPath("volumeInfo");

                            Book book = new Book();
                            book.title = volumeInfo.findPath("title").getTextValue();
                            book.authors = volumeInfo.findPath("authors").get(0).getTextValue();
                            book.publisher = volumeInfo.findPath("publisher").getTextValue();
                            book.publishedDate = format.parseDateTime(volumeInfo.findPath("publishedDate").getTextValue());
                            JsonNode isbnNode = volumeInfo.findPath("industryIdentifiers");
                            List<String> isbnList = isbnNode.findValuesAsText("identifier");
                            String isbn13 = "";
                            String isbn10 = "";
                            /* If theres an isbn13, use it as the main isbn and use isbn_10 for the isbn10.
                                else isbn_10 is the main isbn.
                             */
                            for(String isbnStr : isbnList) {
                                if(isbnStr.length() == 13) isbn13 = isbnStr;
                                if(isbnStr.length() == 10) isbn10 = isbnStr;
                            }
                            if(isbn13.length() == 13) {
                                book.isbn = isbn13;
                                if(isbn10.length() == 10) {
                                    book.isbn_10 = isbn10;
                                }
                            } else {
                                book.isbn = isbn10;
                            }

                            if(volumeInfo.findPath("description") != null) {
                                book.description = volumeInfo.findPath("description").getTextValue();
                            }
                            book.pageCount = volumeInfo.findPath("pageCount").getIntValue();
                            book.averageRating = volumeInfo.findPath("averageRating").getIntValue();
                            book.ratingsCount = volumeInfo.findPath("ratingsCount").getIntValue();
                            book.thumbnail = volumeInfo.findPath("imageLinks").findPath("thumbnail").getTextValue();

                            book.save();
                            suggestions.add(book);
                        }
                    }
                    return ok(Json.toJson(suggestions));
                }
            }
        )
        );
    }

    public static void setISBN(Book book, JsonNode isbnNode) {
        List<String> isbnList = isbnNode.findValuesAsText("identifier");
        String isbn13 = "";
        String isbn10 = "";
        for(String isbnStr : isbnList) {
            if(isbnStr.length() == 13) isbn13 = isbnStr;
            if(isbnStr.length() == 10) isbn10 = isbnStr;
        }
        if(isbn13.length() == 13) {
            book.isbn = isbn13;
            if(isbn10.length() == 10) {
                book.isbn_10 = isbn10;
            }
        } else {
            book.isbn = isbn10;
        }
    }

    public static Result getUserFeed(final Long memberId, final Integer page) {
        final List<FinishedRead> finishedReading = RMember.finderMember.byId(memberId).finishedReading;
        final List<Book> recommendations = new ArrayList<Book>();
        final Set<Book> friendsActivity = new HashSet<Book>();
        final List<Book> topRated = Book.finderBook.where().orderBy("average_rating desc").findPagingList(25).getPage(0).getList();
        Logger.debug("topRated size = " + topRated.size());

        List<Promise<? extends WS.Response>> webServiceCalls = new ArrayList<Promise<? extends WS.Response>>();

        for(int i = (page*3)-2; i <= finishedReading.size() && i <= page*3; i++) {
                String title = finishedReading.get(i-1).book.title.replaceAll(" ","+");

                Promise<WS.Response> googleResponse = WS.url(google_api).setQueryParameter("q",title).setQueryParameter("key", google_api_key).get();
                webServiceCalls.add(googleResponse);
        }

        List<RMember> friends = RMember.finderMember.byId(memberId).myFriends;
        Set<Book> friendsBooks = new HashSet<Book>();
        for(RMember friend : friends) {
            for(FinishedRead finishedRead : friend.finishedReading) {
                friendsActivity.add(finishedRead.book);
            }
        }

        Promise<List<WS.Response>> results = Promise.sequence(webServiceCalls);
        return async(results.map(new Function<List<WS.Response>, Result>() {
            public Result apply(List<WS.Response> responses) {
                for(WS.Response response : responses) {
                    JsonNode json = response.asJson();
                    Integer max = json.findPath("totalItems").getIntValue();
                    if(max > 4) max = 4;
                    for(int j = 0; j < max; j++) {
                        JsonNode volumeInfo = json.findPath("items").get(j).findPath("volumeInfo");

                        Book book = new Book();
                        setISBN(book,volumeInfo.findPath("industryIdentifiers"));
                        if(Book.existsIsbn(book.isbn)) {
                            Book found = Book.getByIsbn(book.isbn);
                            recommendations.add(found);
                            continue;
                        }
                        book.title = volumeInfo.findPath("title").getTextValue();
                        try { book.authors = volumeInfo.findPath("authors").get(0).getTextValue(); } catch (Exception ex) {}
                        try { book.publisher = volumeInfo.findPath("publisher").getTextValue(); } catch (Exception ex) {}
                        try {
                            book.publishedDate = format.parseDateTime(volumeInfo.findPath("publishedDate").getTextValue());
                        } catch (IllegalArgumentException ex) {
                            Logger.debug("getUserFeed - " + ex.getMessage());
                        }
                        try { book.description = volumeInfo.findPath("description").getTextValue(); } catch (Exception ex) {}
                        try { book.pageCount = volumeInfo.findPath("pageCount").getIntValue(); } catch (Exception ex) {}
                        try { book.averageRating = volumeInfo.findPath("averageRating").getIntValue(); } catch (Exception ex) {}
                        try { book.ratingsCount = volumeInfo.findPath("ratingsCount").getIntValue(); } catch (Exception ex) {}
                        try { book.thumbnail = volumeInfo.findPath("imageLinks").findPath("thumbnail").getTextValue(); } catch (Exception ex) {}

                        book.save();
                        recommendations.add(book);
                    }
                }
                Logger.debug("" + recommendations.size());
                ObjectNode result = Json.newObject();
                result.put("recommendations", Json.toJson(recommendations));
                result.put("friendsActivity", Json.toJson(friendsActivity));
                result.put("topRated", Json.toJson(topRated));
                return ok(result);
            }
        }));
    }

    public static Result getFriendsBooks(Long memberId) {
        List<RMember> friends = RMember.finderMember.byId(memberId).myFriends;
        Set<Book> friendsBooks = new HashSet<Book>();
        for(RMember friend : friends) {
            for(FinishedRead finishedRead : friend.finishedReading) {
                friendsBooks.add(finishedRead.book);
            }
        }
        return ok(Json.toJson(friendsBooks));
    }
}
