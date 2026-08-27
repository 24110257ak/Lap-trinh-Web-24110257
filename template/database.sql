-- Tao Database ltweb neu chua co
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ltweb')
BEGIN
    CREATE DATABASE ltweb;
END
GO

USE ltweb;
GO

-- 1. Tao bang users neu chua co
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'users')
BEGIN
    CREATE TABLE users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username NVARCHAR(50) NOT NULL UNIQUE,
        password NVARCHAR(255) NOT NULL,
        fullname NVARCHAR(100) NOT NULL
    );

    INSERT INTO users (username, password, fullname) VALUES 
    (N'admin', N'123', N'Quản Trị Viên'),
    (N'user1', N'123456', N'Nguyễn Văn A'),
    (N'trungnh', N'123', N'ThS. Nguyễn Hữu Trung');
END
GO

-- 2. Tao bang Category theo chuan 14_HD_Servlet_JDBC_CRUD
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Category')
BEGIN
    CREATE TABLE Category (
        cate_id INT IDENTITY(1,1) PRIMARY KEY,
        cate_name NVARCHAR(255) NOT NULL,
        icons NVARCHAR(255) NULL
    );

    INSERT INTO Category (cate_name, icons) VALUES 
    (N'Quần Áo Nam', N'category/sample_nam.jpg'),
    (N'Quần Áo Nữ', N'category/sample_nu.jpg'),
    (N'Giày Dép Thời Trang', N'category/sample_giay.jpg'),
    (N'Phụ Kiện Điện Tử', N'category/sample_phukien.jpg');
END
GO
