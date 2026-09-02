<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản - JPA 3.0</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Đăng Ký Tài Khoản (Kích hoạt bằng OTP qua Email)</h2>

    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">${error}</p>
    </c:if>

    <p><i>* Sau khi đăng ký, hệ thống sẽ gửi mã xác thực OTP 6 số qua email (hoặc in ra console) để kích hoạt tài khoản.</i></p>

    <form action="<c:url value="/register"/>" method="post">
        <table>
            <tr>
                <td><label for="username">Tên đăng nhập (Username):</label></td>
                <td><input type="text" id="username" name="username" required style="padding: 5px; width: 240px;"></td>
            </tr>
            <tr>
                <td><label for="fullname">Họ và tên:</label></td>
                <td><input type="text" id="fullname" name="fullname" required style="padding: 5px; width: 240px;"></td>
            </tr>
            <tr>
                <td><label for="email">Email nhận OTP:</label></td>
                <td><input type="email" id="email" name="email" required placeholder="name@example.com" style="padding: 5px; width: 240px;"></td>
            </tr>
            <tr>
                <td><label for="phone">Số điện thoại:</label></td>
                <td><input type="text" id="phone" name="phone" style="padding: 5px; width: 240px;"></td>
            </tr>
            <tr>
                <td><label for="password">Mật khẩu:</label></td>
                <td><input type="password" id="password" name="password" required style="padding: 5px; width: 240px;"></td>
            </tr>
            <tr>
                <td><label for="confirmPassword">Xác nhận mật khẩu:</label></td>
                <td><input type="password" id="confirmPassword" name="confirmPassword" required style="padding: 5px; width: 240px;"></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <br>
                    <input type="submit" value="Đăng Ký & Nhận OTP" style="padding: 6px 20px; font-weight: bold;">
                </td>
            </tr>
        </table>
    </form>
    <br>
    <div>
        Đã có tài khoản? <a href="<c:url value="/login"/>">Đăng nhập ngay</a> | 
        <a href="<c:url value="/home"/>">Về trang chủ</a>
    </div>
</body>
</html>
