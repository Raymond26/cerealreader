package controllers;

import play.mvc.*;
import play.libs.Json;
import models.*;

public class MemberController extends Controller {

    public static Result getReads(Long id) {
        return ok(Json.toJson(RMember.finderMember.byId(id).haveRead));
    }
}
