<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - Koha Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .card-forgot { border-radius: 16px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); max-width: 460px; width: 100%; background: #fff; }
    </style>
</head>
<body>
    <div class="card card-forgot p-4 p-md-5">
        <div class="text-center mb-4">
            <div class="mb-3">
                <i class="fa-solid fa-key text-warning fa-3x"></i>
            </div>
            <h3 class="fw-bold text-dark">Quên Mật Khẩu?</h3>
            <p class="text-muted small">Vui lòng nhập Tên đăng nhập hoặc Email bạn đã đăng ký để nhận mã xác thực OTP đặt lại mật khẩu.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="mb-4">
                <label class="form-label fw-semibold">Tên đăng nhập hoặc Email:</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-user-shield"></i></span>
                    <input type="text" name="account" value="${account}" class="form-control" required placeholder="Nhập username hoặc email">
                </div>
            </div>

            <button type="submit" class="btn btn-warning w-100 py-2 fw-semibold text-dark mb-3">
                <i class="fa-solid fa-paper-plane me-1"></i> Gửi Mã OTP Qua Email
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
