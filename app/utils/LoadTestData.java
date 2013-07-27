package utils;

import models.*;
import org.joda.time.DateTime;

public class LoadTestData {
    public static void load() {
        Book b1 = new Book(123L,"da book");
        Book b2 = new Book(1234L,"shitty book");
        Book b3 = new Book(12345L,"awesome book");
        Book b4 = new Book(123456L, "solutions manual");
        Book b5 = new Book(12L, "comic book");

        b1.save();
        b2.save();
        b3.save();
        b4.save();
        b5.save();

        RMember m1 = new RMember("ray@gmail.com","lsdkfj");
        m1.save();

        CurrentRead r1 = new CurrentRead(b1, DateTime.now(), "its ok");
        CurrentRead r2 = new CurrentRead(b2, DateTime.now(), "this book fuckin sucks");

        m1.addCurrentReading(r1);
        m1.addCurrentReading(r2);
    }
}
