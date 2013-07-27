package models;

import org.codehaus.jackson.annotate.JsonIgnore;
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
        this.facebookToken = facebookToken;
    }

    @OneToMany(mappedBy = "rmember")
    @JsonIgnore
    public List<Read> haveRead = new ArrayList<Read>();

    @OneToMany(mappedBy = "rmember")
    @JsonIgnore
    public List<Read> currentlyReading = new ArrayList<Read>();

    public static Finder<Long,RMember> finderMember = new Finder(
            Long.class, RMember.class
    );

    public void addCurrentReading(Read read) {
        /* Auto updates currentlyReading */
        /*read.rmember = this;
        read.save();*/
        this.currentlyReading.add(read);
        this.save();
    }

    /*public void finishReading(Read read) {
        read.cu
    }*/

}
