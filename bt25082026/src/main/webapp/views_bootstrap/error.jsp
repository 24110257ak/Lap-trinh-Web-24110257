<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông Báo Lỗi</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .error-card {
            max-width: 480px;
            width: 100%;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            text-align: center;
            padding: 40px 30px;
        }
    </style>
</head>
<body>

<div class="error-card">
    <div class="mb-3 text-danger">
        <i class="bi bi-exclamation-circle-fill" style="font-size: 4rem;"></i>
    </div>
    <h3 class="fw-bold text-dark mb-2">Đã Xảy Ra Lỗi!</h3>
    <p class="text-secondary mb-4">
        <c:choose>
            <c:when test="${not empty error}">${error}</c:when>
            <c:otherwise>Không tìm thấy trang hoặc thông tin xác thực không hợp lệ.</c:otherwise>
        </c:choose>
    </p>
    <div class="d-flex justify-content-center gap-2">
        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary px-4">
            <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập lại
        </a>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary px-4">
            <i class="bi bi-house me-1"></i>Trang chủ
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
