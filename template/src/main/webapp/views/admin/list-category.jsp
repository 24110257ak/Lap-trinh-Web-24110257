<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục</title>
</head>
<body>
    <h2>Quản lý danh mục</h2>
    <p><a href="${pageContext.request.contextPath}/admin/category/add">Thêm danh mục mới</a> | <a href="${pageContext.request.contextPath}/home">Trang chủ</a></p>

    <!-- Tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/category/list" method="get">
        Tìm kiếm: <input type="text" name="keyword" value="${not empty keyword ? keyword : ''}">
        <input type="submit" value="Tìm">
    </form>
    <br/>

    <!-- Bảng danh mục y hệt slide 30 -->
    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
            <tr>
                <th>STT</th>
                <th>Hình ảnh</th>
                <th>Tên danh mục</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${cateList}" var="cate" varStatus="STT">
                <tr class="odd gradeX">
                    <td>${STT.index + 1}</td>
                    <c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
                    <td><img height="150" width="200" src="${imgUrl}" alt="${cate.name}" /></td>
                    <td>${cate.name}</td>
                    <td>
                        <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" class="center">Sửa</a>
                        | <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" class="center" onclick="return confirm('Bạn chắc chắn muốn xóa?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>