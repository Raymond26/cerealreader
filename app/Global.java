import play.Application;
import play.GlobalSettings;
import play.Logger;

import models.*;
import utils.*;

public class Global extends GlobalSettings{
    public void onStart(Application application) {
        Logger.debug("Custom onStart - Raymond");
        if(Book.finderBook.all().size() < 1) {
            LoadTestData.load();
        }
    }
}
