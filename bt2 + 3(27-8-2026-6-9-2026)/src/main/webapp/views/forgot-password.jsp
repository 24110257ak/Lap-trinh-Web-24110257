<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - JPA 3.0</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Quên Mật Khẩu</h2>

    <c:if test="${not empty error}">
        <p style="color: red; font-weight: bold;">${error}</p>
    </c:if>

    <p>Nhập Tên đăng nhập hoặc Email đã đăng ký để nhận mã xác thực OTP đặt lại mật khẩu:</p>

    <form action="<c:url value="/forgot-password"/>" method="post">
        <table>
            <tr>
                <td><label for="account">Tài khoản hoặc Email:</label></td>
                <td><input type="text" id="account" name="account" value="${account}" required style="padding: 5px; width: 250px;"></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <br>
                    <input type="submit" value="Gửi Mã OTP Xác Nhận" style="padding: 6px 20px; font-weight: bold;">
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
