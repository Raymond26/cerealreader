package models;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.joda.time.DateTime;
import play.db.ebean.Model;

import javax.persistence.*;

@Entity
public class Read extends Model {

    @Id
    public Long id;

    @ManyToOne
    @JsonIgnore
    public RMember rmember;

    public DateTime startDate;

    public DateTime finishDate;

    public Integer rating;

    public String review;

    public String currentThoughts;

    @ManyToOne
    public Book book;

    public Read() {}

    public Read(Book book, DateTime startDate) {
        this.book = book;
        this.startDate = startDate;
    }

    /* For updating currently reading */
    public Read(Book book, DateTime startDate, String currentThoughts) {
        this.book = book;
        this.startDate = startDate;
        this.currentThoughts = currentThoughts;
    }

    public static Finder<Long,Read> findRead = new Finder(
            Long.class, Read.class
    );
}
