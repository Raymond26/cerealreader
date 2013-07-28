package models;

import javax.persistence.*;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.joda.time.DateTime;
import play.db.ebean.Model;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Book extends Model {

    @Id
    public Long id;

    public String isbn;

    public String title;

    public String authors;

    @Column(columnDefinition = "TEXT")
    public String description;

    /* Historic ISBNs if after 2007 */
    public String isbn_10;

    public Integer pageCount;

    public Integer averageRating;

    public Integer ratingsCount;

    public String publisher;

    public DateTime publishedDate;

    public String thumbnail;

    public Book() {}

    public Book(String isbn, String title) {
        this.isbn = isbn;
        this.title = title;
    }

    @OneToMany(mappedBy = "book")
    @JsonIgnore
    public List<FinishedRead> finishedReads = new ArrayList<FinishedRead>();

    @OneToMany(mappedBy = "book")
    @JsonIgnore
    public List<CurrentRead> currentReads = new ArrayList<CurrentRead>();

    public static Finder<Long,Book> finderBook = new Finder(Long.class,Book.class);

    public static Book getByIsbn(String isbn) {
        return finderBook.where().eq("isbn", isbn).findUnique();
    }

    public static Boolean existsIsbn(String isbn) {
        return (finderBook.where().eq("isbn", isbn).findRowCount() > 0);
    }

}
