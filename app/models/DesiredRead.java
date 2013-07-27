package models;

import javax.persistence.*;

import org.joda.time.DateTime;

@Entity
public class DesiredRead extends Read {

    //startDate is the date the item was added to wish list
    //startDate will automatically change upon adding to currentReads

    public DesiredRead(Book book) {
        this.book = book;
        this.startDate = DateTime.now();
    }

    public static Finder<Long,DesiredRead> findDesiredRead = new Finder(
            Long.class, DesiredRead.class
    );

}
