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

    public DateTime finishDate;

    public Integer rating;

    public String review;

    @ManyToOne
    public Book book;


}
