<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực mã OTP - Koha Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .card-otp { border-radius: 16px; border: none; box-shadow: 0 15px 35px rgba(0,0,0,0.15); max-width: 460px; width: 100%; background: #fff; }
        .otp-input { letter-spacing: 12px; font-size: 28px; font-weight: bold; text-align: center; border-radius: 10px; border: 2px solid #0d6efd; color: #0d6efd; }
    </style>
</head>
<body>
    <div class="card card-otp p-4 p-md-5">
        <div class="text-center mb-4">
            <div class="mb-3">
                <i class="fa-solid fa-envelope-circle-check text-primary fa-3x"></i>
            </div>
            <h3 class="fw-bold text-dark">Xác Thực Mã OTP</h3>
            <p class="text-muted small">
                Mã xác thực 6 chữ số đã được gửi qua email. 
                <br><span class="text-primary fw-semibold">(Hoặc kiểm tra ngay cửa sổ Console)</span>
            </p>
        </div>

        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-info alert-dismissible fade show py-2" role="alert">
                <i class="fa-solid fa-circle-info me-2"></i>${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <input type="hidden" name="username" value="${username}">

            <div class="mb-4">
                <label class="form-label fw-semibold text-center w-100">Nhập mã OTP 6 chữ số:</label>
                <input type="text" name="otp" maxlength="6" class="form-control otp-input py-2" required placeholder="••••••" autofocus autocomplete="off">
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
                <i class="fa-solid fa-check-circle me-1"></i> Xác Nhận Kích Hoạt
            </button>
        </form>

        <div class="text-center mt-3">
            <span class="text-muted small">Chưa nhận được mã?</span> 
            <a href="${pageContext.request.contextPath}/resend-otp?username=${username}" class="fw-semibold text-decoration-none small">Gửi lại mã OTP</a>
        </div>
        <div class="text-center mt-2">
            <a href="${pageContext.request.contextPath}/login" class="text-secondary text-decoration-none small"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại trang Đăng nhập</a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
