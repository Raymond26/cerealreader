package controllers;

import models.*;
import play.mvc.*;

public class ReadsController extends Controller {

    public static Result addDesiredBook(Long memberId) {
        String isbn = request().getQueryString("isbn");
        DesiredRead desiredRead = new DesiredRead(Book.getByIsbn(isbn));
        desiredRead.save();
        return ok("book successfully added to desired");
    }

    public static Result addCurrentBook(Long memberId) {
        String isbn = request().getQueryString("isbn");
        CurrentRead read = new CurrentRead(Book.getByIsbn(isbn));
        RMember.finderMember.byId(memberId).addCurrentReading(read);
        return ok("book successfully added");
    }

    public static Result addFinishedBook(Long memberId) {
        String isbn = request().getQueryString("isbn");
        FinishedRead read = new FinishedRead(memberId, Book.getByIsbn(isbn));
        read.save();
        return ok("book successfully added to finished");
    }
}
