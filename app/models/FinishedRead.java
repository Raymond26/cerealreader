package models;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.joda.time.DateTime;
import play.db.ebean.Model;

import javax.persistence.*;

@Entity
public class FinishedRead extends Read {

    public DateTime finishDate;

    public FinishedRead(CurrentRead currentRead) {
        this.book = currentRead.book;
        this.startDate = currentRead.startDate;
        this.finishDate = DateTime.now();
        this.currentThoughts = currentRead.currentThoughts;
        this.rmember = currentRead.rmember;
    }

    public FinishedRead(Book book) {
        this.book = book;
        this.finishDate = DateTime.now();
    }

    public FinishedRead(Long memberId, Book book) {
        this.book = book;
        this.finishDate = DateTime.now();
        this.rmember = RMember.finderMember.ref(memberId);
    }

    public static Finder<Long,FinishedRead> findFinishedRead = new Finder(
            Long.class, FinishedRead.class
    );
}
