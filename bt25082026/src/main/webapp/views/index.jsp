<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ</title>
</head>
<body>
    <h1>Trang Chủ Project</h1>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <h3>Xin chào: ${sessionScope.user.fullName} (${sessionScope.user.username})</h3>
            <p><a href="${pageContext.request.contextPath}/admin/category/list">Quản lý danh mục</a></p>
            <p><a href="${pageContext.request.contextPath}/logout">Đăng xuất (Logout)</a></p>
        </c:when>
        <c:otherwise>
            <p>Bạn chưa đăng nhập.</p>
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </c:otherwise>
    </c:choose>
</body>
</html>