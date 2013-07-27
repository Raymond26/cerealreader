package controllers;

import org.joda.time.DateTime;
import play.mvc.*;
import play.libs.Json;
import models.*;

public class MemberController extends Controller {

    public static Long memberId = 61L;

    public static Result getReads() {
        return ok(Json.toJson(RMember.finderMember.byId(memberId).haveRead));
    }

    public static Result addCurrentBook() {
        Long isbn = Long.parseLong(request().getQueryString("isbn"));
        Read read = new Read(Book.getByIsbn(isbn), DateTime.now());
        read.save();
        RMember.finderMember.byId(memberId).addCurrentReading(read);
        return ok("book successfully added");
    }

    public static Result getCurrentlyReading() {
        return ok(Json.toJson(RMember.finderMember.byId(memberId).currentlyReading));
    }

    public static Result setCurrentThoughts(Long id) {
        Read read = Read.findRead.byId(id);
        read.currentThoughts = request().getQueryString("currentThoughts");
        read.save();
        return ok("current thoughts saved");
    }

    public static Result finishedReading(Long id) {
        Read read = Read.findRead.byId(id);
        read.finishDate = DateTime.now();
        read.save();
        return ok("book finishing details saved");
    }

    public static Result getFinishedReading() {
        return ok(Json.toJson(RMember.finderMember.byId(memberId).haveRead));
    }
}
