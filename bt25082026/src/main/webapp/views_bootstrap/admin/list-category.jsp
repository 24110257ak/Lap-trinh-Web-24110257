<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh Sách Danh Mục - Category Management</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            background: #fff;
        }
        .category-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-code-slash text-primary me-2"></i>HCMUTE - Servlet MVC
        </a>
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door me-1"></i>Trang Chủ</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/category/list"><i class="bi bi-tags me-1"></i>Quản Lý Danh Mục</a></li>
            </ul>
            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="navbar-text text-white me-3">
                            <i class="bi bi-person-circle text-warning me-1"></i>${sessionScope.user.fullName}
                        </span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                            <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<!-- Page Content -->
<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold mb-1"><i class="bi bi-folder2-open text-primary me-2"></i>Quản Lý Danh Mục (Category)</h2>
            <p class="text-muted mb-0">Thực hiện CRUD Category theo tài liệu hướng dẫn Servlet JDBC</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary shadow-sm">
                <i class="bi bi-plus-lg me-1"></i>Thêm Danh Mục Mới
            </a>
        </div>
    </div>

    <!-- Filter & Search Bar -->
    <div class="main-card p-4 mb-4">
        <form action="${pageContext.request.contextPath}/admin/category/list" method="get" class="row g-3 align-items-center">
            <div class="col-md-9">
                <div class="input-group">
                    <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" name="keyword" class="form-control" 
                           placeholder="Nhập tên danh mục cần tìm kiếm..." 
                           value="${not empty keyword ? keyword : ''}">
                </div>
            </div>
            <div class="col-md-3 d-flex gap-2">
                <button type="submit" class="btn btn-dark w-100"><i class="bi bi-funnel me-1"></i>Tìm Kiếm</button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary">Xóa Lọc</a>
                </c:if>
            </div>
        </form>
    </div>

    <!-- Category Table -->
    <div class="main-card p-4">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th style="width: 70px;" class="text-center">STT</th>
                        <th style="width: 90px;" class="text-center">Mã ID</th>
                        <th style="width: 120px;" class="text-center">Hình Ảnh</th>
                        <th>Tên Danh Mục</th>
                        <th style="width: 180px;" class="text-center">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty cateList}">
                            <c:forEach items="${cateList}" var="cate" varStatus="STT">
                                <tr>
                                    <td class="text-center fw-semibold text-secondary">${STT.index + 1}</td>
                                    <td class="text-center"><span class="badge bg-secondary">#${cate.id}</span></td>
                                    <td class="text-center">
                                        <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
                                        <img src="${imgUrl}" alt="${cate.name}" class="category-img shadow-sm"
                                             onerror="this.onerror=null;this.src='https://placehold.co/70x70?text=No+Image';">
                                    </td>
                                    <td>
                                        <span class="fw-bold text-dark fs-6">${cate.name}</span>
                                        <c:if test="${not empty cate.icon}">
                                            <div class="small text-muted font-monospace">${cate.icon}</div>
                                        </c:if>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}" 
                                           class="btn btn-warning btn-sm me-1" title="Chỉnh sửa">
                                            <i class="bi bi-pencil-square"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" 
                                           class="btn btn-danger btn-sm" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục [${cate.name}] không?');" 
                                           title="Xóa danh mục">
                                            <i class="bi bi-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    Không có danh mục nào phù hợp.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
