package controllers;

import org.codehaus.jackson.node.ObjectNode;
import org.joda.time.DateTime;

import play.mvc.*;
import play.libs.Json;
import models.*;

public class MemberController extends Controller {

    public static Result getUserProfile(Long id) {
        ObjectNode result = Json.newObject();
        RMember member = RMember.finderMember.byId(id);
        result.put("currentReading", Json.toJson(member.currentlyReading));
        result.put("finishedReading", Json.toJson(member.finishedReading));
        result.put("user", Json.toJson(member));
        return ok(result);
    }

    public static Result desiredToCurrentBook(Long id) {
        DesiredRead desiredRead = DesiredRead.findDesiredRead.byId(id);
        CurrentRead currentRead = new CurrentRead(desiredRead);
        currentRead.save();
        desiredRead.delete();
        return ok("desired to current success");
    }

    public static Result getDesiredReads(Long memberId) {
        return ok(Json.toJson(RMember.finderMember.byId(memberId).desiredReading));
    }

    public static Result getCurrentlyReading(Long memberId) {
        return ok(Json.toJson(RMember.finderMember.byId(memberId).currentlyReading));
    }

    public static Result setCurrentThoughts(Long id) {
        CurrentRead currentRead = CurrentRead.findCurrentRead.byId(id);
        currentRead.currentThoughts = request().getQueryString("currentThoughts");
        currentRead.save();
        return ok("current thoughts saved");
    }

    public static Result finishedReading(Long id) {
        CurrentRead currentRead = CurrentRead.findCurrentRead.byId(id);
        FinishedRead finishedRead = new FinishedRead(currentRead);
        finishedRead.save();
        currentRead.delete();
        return ok("book finishing details saved");
    }

    public static Result getFinishedReading(Long memberId) {
        return ok(Json.toJson(RMember.finderMember.byId(memberId).finishedReading));
    }

    public static Result getFriendsOf(Long memberId) {
        return ok(Json.toJson(RMember.finderMember.byId(memberId).myFriends));
    }

    public static Result addFriend(Long memberId, Long newFriendId) {
        RMember newFriend = RMember.finderMember.ref(newFriendId);
        RMember me = RMember.finderMember.byId(memberId);
        me.myFriends.add(newFriend);
        me.saveManyToManyAssociations("myFriends");
        return ok("added friend");
    }
}
