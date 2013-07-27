package models;

import play.db.ebean.*;
import play.data.validation.*;
import play.data.format.*;

import java.util.List;
import java.util.ArrayList;
import javax.persistence.*;

@Entity
public class RMember extends Model {

    @Id
    public Long id;

    @Constraints.Email
    public String emailAddress;

    public String facebookToken;

    public RMember() {}

    public RMember(String emailAddress, String facebookToken) {
        this.emailAddress = emailAddress;

    }

    @OneToMany(mappedBy = "rmember")
    public List<Read> haveRead = new ArrayList<Read>();

    public static Finder<Long,RMember> finderMember = new Finder(
            Long.class, RMember.class
    );

}
