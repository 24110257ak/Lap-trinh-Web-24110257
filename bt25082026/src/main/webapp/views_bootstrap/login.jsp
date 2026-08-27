<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng Nhập - Hệ Thống Quản Lý</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            background: #fff;
            width: 100%;
            max-width: 440px;
        }
        .login-header {
            background: #0d6efd;
            color: #fff;
            padding: 30px 20px;
            text-align: center;
        }
        .login-body {
            padding: 35px 30px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <h3 class="fw-bold mb-1"><i class="bi bi-shield-lock-fill me-2"></i>ĐĂNG NHẬP</h3>
        <p class="mb-0 text-white-50 fs-6">Hệ thống Demo Servlet - Session & Cookie</p>
    </div>
    <div class="login-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center py-2" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                <div>${error}</div>
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Tên đăng nhập (Username):</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                    <input type="text" class="form-control" id="username" name="username" 
                           placeholder="Nhập tên đăng nhập" 
                           value="${not empty rememberUsername ? rememberUsername : ''}" required autofocus>
                </div>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label fw-semibold">Mật khẩu (Password):</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-key"></i></span>
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Nhập mật khẩu" required>
                </div>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="remember" name="remember" value="on" 
                       ${rememberChecked ? 'checked' : ''}>
                <label class="form-check-label text-secondary" for="remember">
                    Ghi nhớ đăng nhập (Lưu Cookie)
                </label>
            </div>

            <div class="d-grid gap-2 mb-3">
                <button type="submit" class="btn btn-primary py-2 fw-semibold shadow-sm">
                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng Nhập
                </button>
            </div>

            <div class="text-center">
                <a href="${pageContext.request.contextPath}/home" class="text-decoration-none text-secondary">
                    <i class="bi bi-arrow-left"></i> Quay lại trang chủ
                </a>
            </div>
        </form>

        <hr class="my-4 text-secondary opacity-25">

        <div class="card bg-light border-0 rounded-3 p-3">
            <div class="fw-bold text-muted small mb-1"><i class="bi bi-info-circle me-1"></i>Tài khoản dùng thử:</div>
            <div class="small text-secondary">
                • <code>admin</code> / <code>123</code> (Quản trị viên)<br>
                • <code>user1</code> / <code>123456</code> (Người dùng)<br>
                • <code>trungnh</code> / <code>123</code> (Giảng viên)
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
