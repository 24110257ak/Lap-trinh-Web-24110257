<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu mới - JPA 3.0</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Đặt Lại Mật Khẩu Mới</h2>

    <c:if test="${not empty sessionScope.message}">
        <p style="color: blue; font-weight: bold;">${sessionScope.message}</p>
        <c:remove var="message" scope="session"/>
    </c:if>

    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">${error}</p>
    </c:if>

    <p>Nhập mã OTP vừa nhận qua email và nhập mật khẩu mới cho tài khoản:</p>

    <form action="<c:url value="/reset-password"/>" method="post">
        <input type="hidden" name="account" value="${account}">
        <table>
            <tr>
                <td><label for="otp">Mã xác thực OTP (6 số):</label></td>
                <td><input type="text" id="otp" name="otp" maxlength="6" required autofocus placeholder="Ví dụ: 123456" style="padding: 5px; width: 180px; font-weight: bold; letter-spacing: 2px;"></td>
            </tr>
            <tr>
                <td><label for="newPassword">Mật khẩu mới:</label></td>
                <td><input type="password" id="newPassword" name="newPassword" required style="padding: 5px; width: 220px;"></td>
            </tr>
            <tr>
                <td><label for="confirmPassword">Xác nhận mật khẩu mới:</label></td>
                <td><input type="password" id="confirmPassword" name="confirmPassword" required style="padding: 5px; width: 220px;"></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <br>
                    <input type="submit" value="Cập Nhật Mật Khẩu" style="padding: 6px 20px; font-weight: bold;">
                </td>
            </tr>
        </table>
    </form>
    <br>
    <div>
        <a href="<c:url value="/login"/>">Quay lại trang Đăng nhập</a> | 
        <a href="<c:url value="/home"/>">Về trang chủ</a>
    </div>
</body>
</html>
