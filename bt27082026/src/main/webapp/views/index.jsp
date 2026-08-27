<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Dự Án bt27082026</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h1>Hệ Thống Quản Lý Web - JPA 3.0 & Servlet 6.0</h1>
    <hr>
    
    <c:choose>
        <c:when test="${not empty sessionScope.user or not empty sessionScope.account}">
            <c:set var="u" value="${not empty sessionScope.user ? sessionScope.user : sessionScope.account}"/>
            <h3>Xin chào: <span style="color: #007bff;">${u.fullName}</span> (${u.username})</h3>
            <p>Vai trò: <b>${u.roleid == 1 ? 'Quản trị viên (Admin)' : 'Người dùng (User)'}</b></p>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/categories" style="font-weight: bold;">Quản lý danh mục (CRUD Category JPA)</a></li>
                <li><a href="${pageContext.request.contextPath}/logout" style="color: red;">Đăng xuất (Logout)</a></li>
            </ul>
        </c:when>
        <c:otherwise>
            <p style="color: #6c757d;">Bạn chưa đăng nhập vào hệ thống.</p>
            <a href="${pageContext.request.contextPath}/login" style="display: inline-block; padding: 8px 16px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px;">Đăng Nhập Ngay</a>
        </c:otherwise>
    </c:choose>
</body>
</html>
