<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa danh mục</title>
</head>
<body>
    <h2>Chỉnh sửa danh mục</h2>
    <c:url value="/admin/category/edit" var="edit"></c:url>
    <form role="form" action="${edit}" method="post" enctype="multipart/form-data">
        <input name="id" value="${category.id}" hidden="">
        <div class="form-group">
            <label>Tên danh sách:</label> 
            <input type="text" class="form-control" value="${category.name}" name="name" required />
        </div>
        <br/>
        <div class="form-group">
            <c:url value="/image?fname=${category.icon}" var="imgUrl"></c:url>
            <img class="img-responsive" width="100px" src="${imgUrl}" alt="">
            <br/>
            <label>Ảnh đại diện</label> 
            <input type="file" name="icon" value="${category.icon}" />
        </div>
        <br/>
        <button type="submit" class="btn btn-default">Edit</button>
        <button type="reset" class="btn btn-primary">Reset</button>
    </form>
    <br/>
    <a href="${pageContext.request.contextPath}/admin/category/list">Quay lại danh sách</a>
</body>
</html>