package models;

import play.db.ebean.Model;
import javax.persistence.*;
import java.util.Set;

public class FeedObject extends Model {

    @Id
    public Long id;

    @ManyToOne
    public RMember associatedMember;

    public FeedObjectType type;

    public String message;

    /* Book action */
    public FeedObject(FeedObjectType type, RMember member, Book book) {
        this.type = type;
        this.associatedMember = member;
        this.message = member.username + type.message + book.title;
    }
}
