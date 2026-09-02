<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm (Products CRUD) - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .table-img { width: 60px; height: 60px; object-fit: contain; background: #f8f9fa; border-radius: 8px; border: 1px solid #dee2e6; }
    </style>
</head>
<body class="bg-light">

    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-2">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary fs-4" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-store me-2"></i>Koha Store Admin
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house me-1"></i> Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active fw-bold" href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-box me-1"></i> Quản lý Sản Phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-tags me-1"></i> Quản lý Danh Mục</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="btn btn-outline-danger btn-sm" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <!-- Title & Action Bar -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 bg-white p-3 rounded-4 shadow-sm">
            <div>
                <h3 class="fw-bold mb-1 text-primary"><i class="fa-solid fa-boxes-stacked me-2"></i>Quản Lý Sản Phẩm (CRUD Products)</h3>
                <span class="text-muted small">Mối quan hệ 1 - n với Category | JPA 3.0 & Jakarta Servlet 6.0</span>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-success fw-semibold">
                    <i class="fa-solid fa-plus-circle me-1"></i> Thêm Sản Phẩm Mới
                </a>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-eye me-1"></i> Xem Trang Khách Hàng
                </a>
            </div>
        </div>

        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i>${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i>${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <!-- Search Bar -->
        <div class="card border-0 shadow-sm p-3 mb-4 rounded-3">
            <form action="${pageContext.request.contextPath}/admin/products" method="get" class="row g-2 align-items-center">
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-magnifying-glass"></i></span>
                        <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo tên sản phẩm...">
                    </div>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary fw-semibold"><i class="fa-solid fa-search me-1"></i> Tìm kiếm</button>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary ms-1">Làm mới</a>
                </div>
            </form>
        </div>

        <!-- Products Table -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th class="text-center" style="width: 70px;">ID</th>
                            <th class="text-center" style="width: 90px;">Hình Ảnh</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Danh Mục</th>
                            <th>Đơn Giá</th>
                            <th class="text-center">Số Lượng</th>
                            <th class="text-center">Trạng Thái</th>
                            <th class="text-center" style="width: 160px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="p">
                            <tr>
                                <td class="text-center fw-bold">#${p.productId}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty p.images and p.images.startsWith('http')}">
                                            <img src="${p.images}" class="table-img" alt="${p.productName}">
                                        </c:when>
                                        <c:when test="${not empty p.images}">
                                            <img src="${pageContext.request.contextPath}/image?fname=${p.images}" class="table-img" alt="${p.productName}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/image?fname=default.file" class="table-img" alt="Default">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="fw-bold text-dark">${p.productName}</span>
                                </td>
                                <td>
                                    <span class="badge bg-info-subtle text-info-emphasis border border-info px-2 py-1">
                                        ${p.category.categoryname}
                                    </span>
                                </td>
                                <td class="fw-bold text-danger">
                                    <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-secondary">${p.quantity}</span>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${p.status == 1}">
                                            <span class="badge bg-success">Đang bán</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Ngừng bán</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" target="_blank" class="btn btn-sm btn-outline-info me-1" title="Xem thử">
                                        <i class="fa-solid fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.productId}" class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.productId}" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm #' + ${p.productId} + ' không?');" 
                                       class="btn btn-sm btn-outline-danger" title="Xóa">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty productList}">
                            <tr>
                                <td colspan="8" class="text-center py-4 text-muted">
                                    <i class="fa-solid fa-box-open fa-2x mb-2 d-block"></i> Chưa có sản phẩm nào trong hệ thống.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
