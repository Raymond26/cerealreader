package models;

public enum FeedObjectType {

    CURRENT_BOOK (" is now reading "),
    FINISHED_BOOK (" just finished "),
    FOLLOWED (" started following ")
    ;

    public final String message;

    FeedObjectType(String message) {
        this.message = message;
    }

}