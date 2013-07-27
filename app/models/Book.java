package models;

import javax.persistence.*;

import org.codehaus.jackson.annotate.JsonIgnore;
import play.db.ebean.Model;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Book extends Model {

    @Id
    public Long id;

    public Long isbn;

    public String title;

    public Book() {}

    public Book(Long isbn, String title) {
        this.isbn = isbn;
        this.title = title;
    }

    @OneToMany(mappedBy = "book")
    @JsonIgnore
    public List<Read> usersHaveRead = new ArrayList<Read>();

    public static Finder<Long,Book> finderBook = new Finder(Long.class,Book.class);

}
