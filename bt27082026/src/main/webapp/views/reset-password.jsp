<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - Koha Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .card-reset { border-radius: 16px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); max-width: 480px; width: 100%; background: #fff; }
        .otp-input { letter-spacing: 8px; font-size: 24px; font-weight: bold; text-align: center; border-radius: 8px; border: 2px solid #0d6efd; }
    </style>
</head>
<body>
    <div class="card card-reset p-4 p-md-5">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-success"><i class="fa-solid fa-lock-open me-2"></i>Đặt Lại Mật Khẩu</h3>
            <p class="text-muted small">Nhập mã OTP vừa nhận qua email và mật khẩu mới cho tài khoản.</p>
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

        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <input type="hidden" name="account" value="${account}">

            <div class="mb-3">
                <label class="form-label fw-semibold">Mã OTP (6 chữ số): <span class="text-danger">*</span></label>
                <input type="text" name="otp" maxlength="6" class="form-control otp-input py-2" required placeholder="••••••" autofocus autocomplete="off">
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu mới: <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" name="newPassword" class="form-control" required placeholder="Nhập mật khẩu mới">
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold">Xác nhận mật khẩu mới: <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-shield"></i></span>
                    <input type="password" name="confirmPassword" class="form-control" required placeholder="Nhập lại mật khẩu mới">
                </div>
            </div>

            <button type="submit" class="btn btn-success w-100 py-2 fw-semibold mb-3">
                <i class="fa-solid fa-floppy-disk me-1"></i> Cập Nhật Mật Khẩu
            </button>
        </form>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/login" class="text-secondary text-decoration-none small">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại trang Đăng nhập
            </a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
