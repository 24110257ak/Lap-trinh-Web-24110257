<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Koha Web Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .product-card {
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #eef0f3;
            background: #fff;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
        }
        .product-img-wrap {
            height: 200px;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }
        .product-img-wrap img {
            max-height: 180px;
            max-width: 90%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .product-card:hover .product-img-wrap img {
            transform: scale(1.05);
        }
        .badge-new {
            position: absolute;
            top: 10px;
            left: 10px;
            background: #dc3545;
            color: #fff;
            font-size: 11px;
            padding: 4px 8px;
            border-radius: 6px;
            font-weight: 600;
        }
        .hero-banner {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: #fff;
            border-radius: 16px;
            padding: 45px 30px;
            margin-bottom: 35px;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Header Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-2">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary fs-4" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-store me-2"></i>Koha Store
            </a>
            <button class="navbar-toggler" type="button" data-bs-dismiss="collapse" data-bs-target="#navContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active fw-semibold" href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house me-1"></i> Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/product"><i class="fa-solid fa-layer-group me-1"></i> Tất cả sản phẩm</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fa-solid fa-list-check me-1"></i> Quản trị Admin
                        </a>
                        <ul class="dropdown-menu shadow">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-box me-2"></i> Quản lý Sản phẩm (Products)</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-tags me-2"></i> Quản lý Danh mục (Categories)</a></li>
                        </ul>
                    </li>
                </ul>

                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-white fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fa-solid fa-circle-user me-1 text-info"></i> Xin chào, ${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <li><span class="dropdown-item-text text-muted small">Quyền: ${sessionScope.user.roleid == 1 ? 'Quản trị viên' : 'Khách hàng'}</span></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item me-2">
                                <a class="btn btn-outline-light btn-sm px-3" href="${pageContext.request.contextPath}/login"><i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-primary btn-sm px-3" href="${pageContext.request.contextPath}/register"><i class="fa-solid fa-user-plus me-1"></i> Đăng ký (OTP)</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <!-- Hero Banner -->
        <div class="hero-banner shadow">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-6 fw-bold mb-3">Chào mừng bạn đến với Koha Web Store</h1>
                    <p class="lead mb-4">Hệ thống Lập trình Web Jakarta EE 10, Servlet 6.0 & JPA 3.0 Hibernate 6.6. Khám phá 10 sản phẩm công nghệ mới nhất bên dưới!</p>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-warning btn-lg fw-bold text-dark px-4 shadow-sm">
                        <i class="fa-solid fa-bag-shopping me-2"></i> Xem toàn bộ sản phẩm (Phân trang 6sp/trang)
                    </a>
                </div>
                <div class="col-lg-4 text-center d-none d-lg-block">
                    <i class="fa-solid fa-laptop-code fa-7x opacity-75"></i>
                </div>
            </div>
        </div>

        <!-- Section: Top 10 Sản Phẩm Mới Nhất -->
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
            <div>
                <h3 class="fw-bold text-dark mb-0">
                    <i class="fa-solid fa-fire text-danger me-2"></i>10 Sản Phẩm Mới Nhất
                </h3>
                <small class="text-muted">Được cập nhật tự động từ hệ quản trị CSDL qua JPA</small>
            </div>
            <a href="${pageContext.request.contextPath}/product" class="text-primary fw-semibold text-decoration-none">
                Xem tất cả <i class="fa-solid fa-arrow-right ms-1"></i>
            </a>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-3 mb-5">
            <c:forEach items="${topProducts}" var="p">
                <div class="col">
                    <div class="product-card shadow-sm">
                        <div class="product-img-wrap">
                            <span class="badge-new">Mới</span>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
                                <c:choose>
                                    <c:when test="${not empty p.images and p.images.startsWith('http')}">
                                        <img src="${p.images}" alt="${p.productName}">
                                    </c:when>
                                    <c:when test="${not empty p.images}">
                                        <img src="${pageContext.request.contextPath}/image?fname=${p.images}" alt="${p.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/image?fname=default.file" alt="Default">
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                        <div class="p-3 d-flex flex-column flex-grow-1 justify-content-between">
                            <div>
                                <span class="badge bg-light text-secondary border mb-1">${p.category.categoryname}</span>
                                <h6 class="card-title fw-bold text-dark mb-2 text-truncate" title="${p.productName}">
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-dark text-decoration-none">
                                        ${p.productName}
                                    </a>
                                </h6>
                            </div>
                            <div>
                                <div class="text-danger fw-bold fs-6 mb-2">
                                    <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                </div>
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-outline-primary btn-sm w-100 fw-semibold">
                                    <i class="fa-solid fa-eye me-1"></i> Chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Section: Danh Mục Nổi Bật -->
        <div class="card border-0 shadow-sm p-4 rounded-4 mb-4">
            <h4 class="fw-bold mb-3"><i class="fa-solid fa-tags text-primary me-2"></i>Khám Phá Theo Danh Mục</h4>
            <div class="row row-cols-2 row-cols-md-4 g-3">
                <c:forEach items="${listCategory}" var="c">
                    <div class="col">
                        <a href="${pageContext.request.contextPath}/product?categoryId=${c.categoryId}" class="card text-center text-decoration-none p-3 border-0 bg-light h-100 shadow-sm hover-shadow">
                            <i class="fa-solid fa-folder-open text-primary fa-2x mb-2"></i>
                            <h6 class="fw-semibold text-dark mb-0">${c.categoryname}</h6>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>

    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-1 fw-semibold">Bài tập Thực hành Lập trình Web - Nhóm Koha (24110257ak)</p>
            <p class="text-muted small mb-0">Đại học Sư phạm Kỹ thuật TP.HCM (HCMUTE) - Công nghệ Jakarta Servlet 6.0 & JPA 3.0</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
