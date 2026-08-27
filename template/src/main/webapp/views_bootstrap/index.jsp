<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang Chủ - Lập Trình Web HCMUTE</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .hero-section {
            background: linear-gradient(135deg, #0d6efd 0%, #0b5ed7 100%);
            color: white;
            padding: 50px 0;
            margin-bottom: 30px;
            border-radius: 0 0 20px 20px;
        }
        .feature-card {
            border: none;
            border-radius: 12px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-code-slash text-primary me-2"></i>HCMUTE - Servlet MVC
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door me-1"></i>Trang Chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/category/list"><i class="bi bi-tags me-1"></i>Quản Lý Danh Mục (CRUD)</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="dropdown">
                            <button class="btn btn-outline-light dropdown-toggle d-flex align-items-center" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle fs-5 me-2 text-warning"></i>
                                <span>${sessionScope.user.fullName}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow">
                                <li><span class="dropdown-item-text text-muted small">Tài khoản: <strong>${sessionScope.user.username}</strong></span></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category/list"><i class="bi bi-folder-check me-2"></i>Quản lý danh mục</a></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất (Logout)</a></li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Đăng Nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Banner -->
<div class="hero-section text-center shadow-sm">
    <div class="container">
        <h1 class="display-5 fw-bold mb-3">Bài Tập Servlet JDBC - Kiến Trúc MVC</h1>
        <p class="lead mb-4 opacity-75">
            Thực hành Login với Cookie & Session và CRUD Category hoàn chỉnh với MS SQL Server
        </p>
    </div>
</div>

<!-- Main Content -->
<div class="container my-4">
    <div class="row g-4">
        <!-- Card 1: Auth Info -->
        <div class="col-md-6">
            <div class="card feature-card h-100 p-4">
                <div class="d-flex align-items-center mb-3">
                    <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-3 me-3">
                        <i class="bi bi-person-badge fs-2"></i>
                    </div>
                    <div>
                        <h4 class="card-title fw-bold mb-1">Trạng Thái Đăng Nhập</h4>
                        <p class="text-muted small mb-0">Quản lý phiên với Session & Cookie</p>
                    </div>
                </div>
                <div class="card-body px-0">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="alert alert-success d-flex align-items-center">
                                <i class="bi bi-check-circle-fill me-2 fs-4"></i>
                                <div>
                                    Bạn đã đăng nhập thành công với phiên làm việc <strong>HttpSession</strong>!<br>
                                    Họ tên: <strong>${sessionScope.user.fullName}</strong> (${sessionScope.user.username})
                                </div>
                            </div>
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                                    <i class="bi bi-box-arrow-right me-1"></i>Đăng Xuất
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-warning d-flex align-items-center">
                                <i class="bi bi-info-circle-fill me-2 fs-4"></i>
                                <div>
                                    Bạn chưa đăng nhập. Bạn có thể sử dụng chức năng "Remember me" (Cookie) khi đăng nhập.
                                </div>
                            </div>
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                                    <i class="bi bi-box-arrow-in-right me-1"></i>Đi đến trang Đăng Nhập
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Card 2: CRUD Category -->
        <div class="col-md-6">
            <div class="card feature-card h-100 p-4">
                <div class="d-flex align-items-center mb-3">
                    <div class="p-3 bg-success bg-opacity-10 text-success rounded-3 me-3">
                        <i class="bi bi-grid-3x3-gap-fill fs-2"></i>
                    </div>
                    <div>
                        <h4 class="card-title fw-bold mb-1">Quản Lý Danh Mục (CRUD)</h4>
                        <p class="text-muted small mb-0">Hướng dẫn 14_HD_Servlet_JDBC_CRUD</p>
                    </div>
                </div>
                <div class="card-body px-0">
                    <p class="card-text text-secondary">
                        Thực hiện đầy đủ các chức năng: Xem danh sách, Thêm danh mục mới, Sửa thông tin, Xóa danh mục và Tải lên / Hiển thị hình ảnh icon.
                    </p>
                    <div class="d-flex gap-2 mt-3">
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-success">
                            <i class="bi bi-list-ul me-1"></i>Xem Danh Sách
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-outline-success">
                            <i class="bi bi-plus-circle me-1"></i>Thêm Danh Mục
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
