<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục - JPA</title>
</head>
<body>
    <h2>Quản lý danh mục (JPA 3.0 & Hibernate 6.6)</h2>
    <a href="<c:url value="/admin/category/add"/>">Add Category (Thêm danh mục mới)</a> | 
    <a href="<c:url value="/home"/>">Trang chủ</a><br>
    <hr>

    <!-- Tìm kiếm danh mục -->
    <form action="<c:url value="/admin/categories"/>" method="get">
        <label>Tìm kiếm:</label>
        <input type="text" name="keyword" value="${not empty keyword ? keyword : ''}" placeholder="Nhập tên danh mục...">
        <input type="submit" value="Tìm">
    </form>
    <br>

    <table border="1" width="100%" cellpadding="8" cellspacing="0">
        <thead>
            <tr bgcolor="#f2f2f2">
                <th>STT</th>
                <th>Images</th>
                <th>Category name</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listcate}" var="cate" varStatus="STT">
                <tr>
                    <td align="center">${STT.index + 1}</td>
                    <c:choose>
                        <c:when test="${not empty cate.images and (cate.images.startsWith('http://') or cate.images.startsWith('https://'))}">
                            <c:url value="${cate.images}" var="imgUrl"></c:url>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                        </c:otherwise>
                    </c:choose>
                    <td align="center">
                        <img height="100" width="140" src="${imgUrl}" alt="${cate.categoryname}" style="object-fit: contain;" />
                    </td>
                    <td><b>${cate.categoryname}</b></td>
                    <td align="center">
                        <c:if test="${cate.status == 1}">
                            <span style="color: green; font-weight: bold;">Hoạt động</span>
                        </c:if>
                        <c:if test="${cate.status != 1}">
                            <span style="color: red; font-weight: bold;">Khóa</span>
                        </c:if>
                    </td>
                    <td align="center">
                        <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>">Sửa</a>
                        | 
                        <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
