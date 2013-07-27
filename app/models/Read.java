package models;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.joda.time.DateTime;
import play.db.ebean.Model;

import javax.persistence.*;

@Entity
public class Read extends Model {

    @Id
    public Long id;

    public DateTime startDate;

    public String currentThoughts;

    @ManyToOne
    @JsonIgnore
    public RMember rmember;

    @ManyToOne
    public Book book;

    public Read() {}

    public static Finder<Long,Read> findRead = new Finder(
            Long.class, Read.class
    );
}
