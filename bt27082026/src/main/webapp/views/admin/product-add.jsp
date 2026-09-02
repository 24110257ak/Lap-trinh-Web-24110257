<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm mới</title>
</head>
<body>
    <h2>Thêm sản phẩm mới (JPA 3.0 & Servlet 6.0)</h2>
    <form action="<c:url value="/admin/product/insert"/>" method="post" enctype="multipart/form-data">
        <label for="productName">Product name (Tên sản phẩm):</label><br>
        <input type="text" id="productName" name="productName" required style="width: 380px; padding: 5px;"><br><br>

        <label for="categoryId">Category (Danh mục):</label><br>
        <select id="categoryId" name="categoryId" required style="width: 250px; padding: 5px;">
            <option value="">-- Chọn danh mục --</option>
            <c:forEach items="${categories}" var="c">
                <option value="${c.categoryId}">${c.categoryname}</option>
            </c:forEach>
        </select><br><br>

        <label for="price">Price (Đơn giá VNĐ):</label><br>
        <input type="number" id="price" name="price" min="0" step="1000" required style="width: 250px; padding: 5px;"><br><br>

        <label for="quantity">Quantity (Số lượng tồn kho):</label><br>
        <input type="number" id="quantity" name="quantity" min="0" value="10" required style="width: 150px; padding: 5px;"><br><br>

        <label for="imageLink">Link images (Nhập liên kết ảnh online):</label><br>
        <input type="text" id="imageLink" name="imageLink" placeholder="https://..." style="width: 380px; padding: 5px;"><br><br>

        <label for="imageFile">Upload images (Tải ảnh từ máy - Multipart):</label><br>
        <input type="file" id="imageFile" name="imageFile"><br><br>

        <label for="description">Description (Mô tả sản phẩm):</label><br>
        <textarea id="description" name="description" rows="4" style="width: 380px; padding: 5px;"></textarea><br><br>

        <label>Status (Trạng thái):</label><br>
        <input type="radio" id="ston" name="status" value="1" checked>
        <label for="ston">Hoạt động</label>
        &nbsp;&nbsp;
        <input type="radio" id="stoff" name="status" value="0">
        <label for="stoff">Khóa</label><br><br>

        <input type="submit" value="Insert" style="padding: 6px 16px; font-weight: bold;">
        <input type="reset" value="Reset" style="padding: 6px 16px;">
    </form>
    <br>
    <a href="<c:url value="/admin/products"/>">Quay lại danh sách sản phẩm</a>
</body>
</html>
