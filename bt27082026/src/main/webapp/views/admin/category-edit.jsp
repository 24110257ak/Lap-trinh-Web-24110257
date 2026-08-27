<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa danh mục</title>
</head>
<body>
    <h2>Chỉnh sửa danh mục (JPA 3.0 & Hibernate 6.6)</h2>
    <form action="<c:url value="/admin/category/update"/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="categoryid" value="${cate.categoryId}">

        <label for="categoryname">Category name (Tên danh mục):</label><br>
        <input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" required style="width: 320px; padding: 5px;"><br><br>

        <label for="images">Link images (Nhập liên kết ảnh):</label><br>
        <input type="text" id="images" name="images" value="${cate.images}" style="width: 320px; padding: 5px;"><br><br>

        <label>Ảnh hiện tại:</label><br>
        <c:choose>
            <c:when test="${not empty cate.images and (cate.images.startsWith('http://') or cate.images.startsWith('https://'))}">
                <c:url value="${cate.images}" var="imgUrl"></c:url>
            </c:when>
            <c:otherwise>
                <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
            </c:otherwise>
        </c:choose>
        <img height="100" width="140" src="${imgUrl}" alt="${cate.categoryname}" style="object-fit: contain; border: 1px solid #ccc; padding: 3px;" /><br><br>

        <label for="images1">Upload images (Tải ảnh mới nếu muốn thay đổi):</label><br>
        <input type="file" id="images1" name="images1"><br><br>

        <label>Status (Trạng thái):</label><br>
        <input type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}>
        <label for="ston">Hoạt động</label>
        &nbsp;&nbsp;
        <input type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
        <label for="stoff">Khóa</label><br><br>

        <input type="submit" value="Update" style="padding: 6px 16px;">
        <input type="reset" value="Reset" style="padding: 6px 16px;">
    </form>
    <br>
    <a href="<c:url value="/admin/categories"/>">Quay lại danh sách</a>
</body>
</html>
