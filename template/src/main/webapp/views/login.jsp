<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h2>Form Đăng Nhập</h2>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        UserName: <input type="text" name="username" value="${not empty rememberUsername ? rememberUsername : ''}"><br/><br/>
        Password: <input type="password" name="password"><br/><br/>
        <input type="checkbox" name="remember" value="on" ${rememberChecked ? 'checked' : ''}> Ghi nhớ đăng nhập (Cookie)<br/><br/>
        <input type="submit" value="Login">
    </form>
    <p>(Tài khoản mẫu: admin / 123 | user1 / 123456 | trungnh / 123)</p>
    <a href="${pageContext.request.contextPath}/home">Về trang chủ</a>
</body>
</html>