<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác thực mã OTP - Kích hoạt tài khoản</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Xác Thực Mã OTP Kích Hoạt Tài Khoản</h2>

    <c:if test="${not empty sessionScope.message}">
        <p style="color: blue; font-weight: bold;">${sessionScope.message}</p>
        <c:remove var="message" scope="session"/>
    </c:if>

    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">${error}</p>
    </c:if>

    <p>Vui lòng nhập mã xác thực OTP 6 số đã được gửi qua email (hoặc kiểm tra trên màn hình Console server):</p>

    <form action="<c:url value="/verify-otp"/>" method="post">
        <input type="hidden" name="username" value="${username}">
        <table>
            <tr>
                <td><label for="otp">Mã OTP (6 chữ số):</label></td>
                <td>
                    <input type="text" id="otp" name="otp" maxlength="6" required autofocus placeholder="Ví dụ: 123456" style="padding: 6px; width: 180px; font-size: 16px; font-weight: bold; letter-spacing: 2px;">
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <br>
                    <input type="submit" value="Kích Hoạt Tài Khoản" style="padding: 6px 20px; font-weight: bold;">
                </td>
            </tr>
        </table>
    </form>
    <br>

    <div>
        Chưa nhận được mã? <a href="<c:url value="/resend-otp?username=${username}"/>">Gửi lại mã OTP</a> | 
        <a href="<c:url value="/login"/>">Quay lại trang Đăng nhập</a>
    </div>
</body>
</html>
