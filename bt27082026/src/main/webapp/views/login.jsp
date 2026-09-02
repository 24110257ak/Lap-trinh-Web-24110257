<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Koha Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .card-login { border-radius: 16px; border: none; box-shadow: 0 15px 35px rgba(0,0,0,0.15); max-width: 450px; width: 100%; background: #fff; }
    </style>
</head>
<body>
    <div class="card card-login p-4 p-md-5">
        <div class="text-center mb-4">
            <div class="mb-3">
                <i class="fa-solid fa-store text-primary fa-3x"></i>
            </div>
            <h3 class="fw-bold text-dark">Koha Web Store</h3>
            <p class="text-muted small">Đăng nhập hệ thống (JPA 3.0 & Jakarta Servlet 6.0)</p>
        </div>

        <c:if test="${not empty sessionScope.success_msg}">
            <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i>${sessionScope.success_msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="success_msg" scope="session"/>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                <c:if test="${not empty unverifiedUsername}">
                    <div class="mt-2">
                        <a href="${pageContext.request.contextPath}/verify-otp?username=${unverifiedUsername}" class="btn btn-sm btn-outline-danger fw-semibold">
                            <i class="fa-solid fa-key me-1"></i> Nhập OTP Kích Hoạt Ngay
                        </a>
                    </div>
                </c:if>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tài khoản (Username):</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                    <input type="text" name="username" value="${not empty rememberUsername ? rememberUsername : ''}" required class="form-control" placeholder="Nhập username">
                </div>
            </div>

            <div class="mb-3">
                <div class="d-flex justify-content-between">
                    <label class="form-label fw-semibold">Mật khẩu:</label>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="small text-decoration-none">Quên mật khẩu?</a>
                </div>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" name="password" required class="form-control" placeholder="••••••••">
                </div>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" id="remember" name="remember" value="on" ${rememberChecked ? 'checked' : ''} class="form-check-input">
                <label for="remember" class="form-check-label text-muted small">Ghi nhớ đăng nhập (Cookie 7 ngày)</label>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
                <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng Nhập
            </button>
        </form>

        <div class="text-center mb-3">
            <span class="text-muted small">Chưa có tài khoản?</span> 
            <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-decoration-none small">Đăng ký mới ngay</a>
        </div>

        <div class="card bg-light border-0 p-3 rounded-3 small">
            <div class="fw-semibold text-primary mb-1"><i class="fa-solid fa-circle-info me-1"></i> Tài khoản mẫu:</div>
            <div>• Admin: <code>admin</code> / <code>123</code></div>
            <div>• Giảng viên: <code>trungnh</code> / <code>123</code></div>
            <div>• Khách hàng: <code>user1</code> / <code>123456</code></div>
        </div>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none small">
                <i class="fa-solid fa-house me-1"></i> Về trang chủ
            </a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
