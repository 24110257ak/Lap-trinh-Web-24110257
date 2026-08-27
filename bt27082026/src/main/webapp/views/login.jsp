<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - JPA 3.0</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Đăng Nhập Hệ Thống (JPA 3.0 & Servlet 6.0)</h2>
    
    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">${error}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <table>
            <tr>
                <td><label for="username">Tài khoản (Username):</label></td>
                <td><input type="text" id="username" name="username" value="${not empty rememberUsername ? rememberUsername : ''}" required style="padding: 5px; width: 220px;"></td>
            </tr>
            <tr>
                <td><label for="password">Mật khẩu (Password):</label></td>
                <td><input type="password" id="password" name="password" required style="padding: 5px; width: 220px;"></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="checkbox" id="remember" name="remember" value="on" ${rememberChecked ? 'checked' : ''}>
                    <label for="remember">Ghi nhớ tài khoản (Cookie)</label>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <br>
                    <input type="submit" value="Đăng Nhập" style="padding: 6px 20px; font-weight: bold;">
                </td>
            </tr>
        </table>
    </form>
    
    <br>
    <div style="background-color: #f8f9fa; border-left: 4px solid #007bff; padding: 10px 15px; width: 350px;">
        <b>Tài khoản mẫu đăng nhập:</b><br>
        • Quản trị viên: <code>admin</code> / <code>123</code> (Role Admin)<br>
        • Giảng viên: <code>trungnh</code> / <code>123</code> (Role Admin)<br>
        • Người dùng: <code>user1</code> / <code>123456</code> (Role User)
    </div>
    <br>
    <a href="${pageContext.request.contextPath}/home">Về trang chủ</a>
</body>
</html>
