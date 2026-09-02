<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>
</head>
<body>
    <h2>Thêm danh mục mới (JPA 3.0 & Servlet 6.0)</h2>
    <form action="<c:url value="/admin/category/insert"/>" method="post" enctype="multipart/form-data">
        <label for="categoryname">Category name (Tên danh mục):</label><br>
        <input type="text" id="categoryname" name="categoryname" required style="width: 320px; padding: 5px;"><br><br>

        <label for="images">Link images (Nhập liên kết ảnh):</label><br>
        <input type="text" id="images" name="images" placeholder="https://..." style="width: 320px; padding: 5px;"><br><br>

        <label for="images1">Upload images (Tải ảnh từ máy):</label><br>
        <input type="file" id="images1" name="images1"><br><br>

        <label>Status (Trạng thái):</label><br>
        <input type="radio" id="ston" name="status" value="1" checked>
        <label for="ston">Hoạt động</label>
        &nbsp;&nbsp;
        <input type="radio" id="stoff" name="status" value="0">
        <label for="stoff">Khóa</label><br><br>

        <input type="submit" value="Insert" style="padding: 6px 16px;">
        <input type="reset" value="Reset" style="padding: 6px 16px;">
    </form>
    <br>
    <a href="<c:url value="/admin/categories"/>">Quay lại danh sách</a>
</body>
</html>
