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
        Book b6 = new Book(98L, "playboy");
        Book b7 = new Book(987L, "programming for dummies");
        Book b8 = new Book(9876L, "maxim issue 24");
        b1.save();
        b2.save();
        b3.save();
        b4.save();
        b5.save();
        b6.save();
        b7.save();
        b8.save();

        RMember m1 = new RMember("ray123","ray@gmail.com","lsdkfj");
        m1.id = 1L;
        RMember m2 = new RMember("bookworm","bookworm@gmail.com","sldkfj");
        m2.id = 2L;
        m1.save();
        m2.save();

        CurrentRead r1 = new CurrentRead(b1, "its ok");
        CurrentRead r2 = new CurrentRead(b2, "this book fuckin sucks");
        CurrentRead r3 = new CurrentRead(b3, "holy shit!!!! aesome");
        m1.addCurrentReading(r1);
        m1.addCurrentReading(r2);
        m1.addCurrentReading(r3);

        FinishedRead f1 = new FinishedRead(b4);
        FinishedRead f2 = new FinishedRead(b5);
        m1.addFinishedReading(f1);
        m1.addFinishedReading(f2);

    }
}
