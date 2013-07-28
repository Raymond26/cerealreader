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

    public String username;

    @Constraints.Email
    @JsonIgnore
    public String emailAddress;

    @JsonIgnore
    public String facebookToken;

    public RMember() {}

    public RMember(String username, String emailAddress, String facebookToken) {
        this.username = username;
        this.emailAddress = emailAddress;
        this.facebookToken = facebookToken;
    }

    @OneToMany(mappedBy = "rmember")
    @JsonIgnore
    public List<FinishedRead> finishedReading = new ArrayList<FinishedRead>();

    @OneToMany(mappedBy = "rmember")
    @JsonIgnore
    public List<CurrentRead> currentlyReading = new ArrayList<CurrentRead>();

    @OneToMany(mappedBy = "rmember")
    @JsonIgnore
    public List<DesiredRead> desiredReading = new ArrayList<DesiredRead>();

    public static Finder<Long,RMember> finderMember = new Finder(
            Long.class, RMember.class
    );

    public void addCurrentReading(CurrentRead currentRead) {
        currentRead.rmember = this;
        currentRead.save();
    }

    public void addFinishedReading(FinishedRead finishedRead) {
        finishedRead.rmember = this;
        finishedRead.save();
    }

}
