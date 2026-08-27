-- Script Database cho Bài tập bt27082026 (JPA 3.0 & Servlet 6.0)
-- 1. Tạo Database bt27082026 nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'bt27082026')
BEGIN
    CREATE DATABASE bt27082026;
END
GO

USE bt27082026;
GO

-- 2. Tạo bảng users (phục vụ Tiêu chí 1: Login với Cookie & Session bằng JPA)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'users')
BEGIN
    CREATE TABLE users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username NVARCHAR(50) NOT NULL UNIQUE,
        password NVARCHAR(255) NOT NULL,
        fullname NVARCHAR(100) NOT NULL,
        email NVARCHAR(150) NULL,
        phone NVARCHAR(20) NULL,
        roleid INT DEFAULT 2
    );

    INSERT INTO users (username, password, fullname, email, phone, roleid) VALUES 
    (N'admin', N'123', N'Quản Trị Viên', N'admin@iotstar.vn', N'0908888999', 1),
    (N'user1', N'123456', N'Nguyễn Văn A', N'vana@gmail.com', N'0912345678', 2),
    (N'trungnh', N'123', N'ThS. Nguyễn Hữu Trung', N'trungnh@hcmute.edu.vn', N'0908617108', 1);
END
GO

-- 3. Tạo bảng categories (phục vụ Tiêu chí 2: CRUD Category JPA)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'categories')
BEGIN
    CREATE TABLE categories (
        CategoryId INT IDENTITY(1,1) PRIMARY KEY,
        CategoryName NVARCHAR(255) NOT NULL,
        Images NVARCHAR(500) NULL,
        Status INT DEFAULT 1
    );

    INSERT INTO categories (CategoryName, Images, Status) VALUES 
    (N'Điện Thoại & Di Động', N'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-600x600.jpg', 1),
    (N'Laptop & Máy Tính Bảng', N'https://cdn.tgdd.vn/Products/Images/44/313333/macbook-air-13-m3-gray-thumb-600x600.jpg', 1),
    (N'Phụ Kiện Công Nghệ', N'https://cdn.tgdd.vn/Products/Images/54/236016/tai-nghe-bluetooth-airpods-2-apple-thumb-600x600.jpg', 1),
    (N'Thiết Bị Gia Dụng', N'https://cdn.tgdd.vn/Products/Images/1982/222213/robot-hut-bui-xiaomi-vacuum-mop-2-pro-thumb-600x600.jpg', 0);
END
GO
