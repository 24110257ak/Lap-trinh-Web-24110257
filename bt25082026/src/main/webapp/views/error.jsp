<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lỗi Đăng Nhập</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2 style="color: red;">Đăng nhập thất bại!</h2>
    <p>
        <c:choose>
            <c:when test="${not empty error}">${error}</c:when>
            <c:otherwise>Sai tài khoản hoặc mật khẩu, hoặc trang không tồn tại.</c:otherwise>
        </c:choose>
    </p>
    <br/>
    <a href="${pageContext.request.contextPath}/login" 
       style="display:inline-block; padding:8px 16px; background:#dc3545; color:#fff; text-decoration:none; border-radius:4px;">
       Thử lại (Login)
    </a>
    <a href="${pageContext.request.contextPath}/home" style="margin-left: 10px;">Về trang chủ</a>
</body>
</html>