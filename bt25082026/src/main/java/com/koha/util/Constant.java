package com.koha.util;

import java.io.File;

public class Constant {
    // Thư mục lưu trữ upload nằm bên trong workspace
    public static final String DIR = System.getProperty("upload.dir", "d:/lap_trinh_web/bt25082026/uploads");
    public static final String CATEGORY_UPLOAD_DIR = DIR + "/category";

    static {
        File dir = new File(CATEGORY_UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }
}
