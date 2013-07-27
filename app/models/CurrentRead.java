package models;

import javax.persistence.*;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.joda.time.DateTime;
import play.db.ebean.Model;

@Entity
public class CurrentRead extends Read {

    public CurrentRead(Book book) {
        this.book = book;
        this.startDate = DateTime.now();
    }

    public CurrentRead(DesiredRead desiredRead) {
        this.book = desiredRead.book;
        this.startDate = DateTime.now();
        this.currentThoughts = desiredRead.currentThoughts;
        this.rmember = desiredRead.rmember;
    }

    public CurrentRead(Book book, DateTime startDate) {
        this.book = book;
        this.startDate = startDate;
    }

    /* For updating currently reading */
    public CurrentRead(Book book, DateTime startDate, String currentThoughts) {
        this.book = book;
        this.startDate = startDate;
        this.currentThoughts = currentThoughts;
    }

    public static Finder<Long,CurrentRead> findCurrentRead = new Finder(
            Long.class, CurrentRead.class
    );

}
