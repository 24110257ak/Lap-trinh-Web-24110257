package vn.iotstar.util;

import java.io.File;

public class Constant {

    public static final String DIR = "D:/upload";
    public static final String CATEGORY_UPLOAD_DIR = DIR + "/category";
    public static final String COOKIE_REMEMBER = "username";
    public static final String SESSION_USERNAME = "user";

    static {
        File dir = new File(CATEGORY_UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }
}
