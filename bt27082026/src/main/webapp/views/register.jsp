<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - Koha Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .card-register { border-radius: 16px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); max-width: 520px; width: 100%; background: #fff; }
        .btn-register { background: #0d6efd; color: #fff; border-radius: 8px; font-weight: 600; padding: 10px; }
        .btn-register:hover { background: #0b5ed7; color: #fff; }
    </style>
</head>
<body>
    <div class="card card-register p-4 p-md-5">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-primary"><i class="fa-solid fa-user-plus me-2"></i>Đăng Ký Tài Khoản</h3>
            <p class="text-muted small">Mã xác thực OTP sẽ được gửi về Email để kích hoạt tài khoản của bạn.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên đăng nhập (Username) <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                    <input type="text" name="username" class="form-control" required placeholder="Nhập username">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
                    <input type="text" name="fullname" class="form-control" required placeholder="Nhập họ và tên">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Email nhận mã OTP <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                    <input type="email" name="email" class="form-control" required placeholder="name@example.com">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Số điện thoại</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                    <input type="text" name="phone" class="form-control" placeholder="0901234567">
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                        <input type="password" name="password" class="form-control" required placeholder="••••••••">
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-shield"></i></span>
                        <input type="password" name="confirmPassword" class="form-control" required placeholder="••••••••">
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-register w-100 mt-3">
                <i class="fa-solid fa-paper-plane me-1"></i> Đăng Ký & Nhận Mã OTP
            </button>
        </form>

        <div class="text-center mt-4">
            <span class="text-muted">Đã có tài khoản?</span> 
            <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-decoration-none">Đăng nhập</a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
