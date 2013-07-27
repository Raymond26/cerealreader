package controllers;

import play.mvc.*;
import play.libs.Json;

import models.*;

public class BooksController extends Controller {
    public static Result getBooks() {
        return ok(Json.toJson(Book.finderBook.all()));
    }
}
