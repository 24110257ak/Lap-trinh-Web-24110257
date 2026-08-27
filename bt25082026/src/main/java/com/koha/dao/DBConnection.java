package com.koha.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // Kết nối SQL Server qua JDBC
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=ltweb;encrypt=true;trustServerCertificate=true;";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "123";

    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        Connection conn = getConnection();
        if (conn != null) {
            System.out.println("=== KẾT NỐI SQL SERVER THÀNH CÔNG RỰC RỠ! ===");
        } else {
            System.out.println("=== KẾT NỐI THẤT BẠI ===");
        }
    }
}
