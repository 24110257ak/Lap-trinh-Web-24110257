package com.koha.util;

import java.io.File;

public class Constant {
    // Thư mục lưu trữ ảnh upload
    public static final String DIR = "D:/upload";
    public static final String CATEGORY_UPLOAD_DIR = DIR + "/category";

    static {
        File dir = new File(CATEGORY_UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }
}
