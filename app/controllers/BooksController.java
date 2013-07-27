package controllers;

import play.mvc.*;
import play.libs.Json;

import org.codehaus.jackson.node.ObjectNode;

import models.*;

public class BooksController extends Controller {
    public static Result getBooks() {
        return ok(Json.toJson(Book.finderBook.all()));
    }

    public static Result getRecommendations() {
        ObjectNode result = Json.newObject();
        return ok(result);
    }
}
