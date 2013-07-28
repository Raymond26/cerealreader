package models;

import org.codehaus.jackson.annotate.JsonIgnore;
import play.db.ebean.*;
import play.data.validation.*;
import play.data.format.*;

import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
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

    @ManyToMany(mappedBy = "friendsOf")
    @JsonIgnore
    public Set<RMember> myFriends = new HashSet<RMember>();


    @ManyToMany()
    @JsonIgnore
    @JoinTable(
            name="friends",
            joinColumns = {@JoinColumn(name="rmember_my", referencedColumnName = "id")},
            inverseJoinColumns={@JoinColumn(name="rmember_of", referencedColumnName = "id")}
    )
    public Set<RMember> friendsOf = new HashSet<RMember>();

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
