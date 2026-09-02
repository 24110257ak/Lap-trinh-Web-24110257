<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm: ${product.productName} - Koha Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .product-detail-img {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 380px;
        }
        .product-detail-img img {
            max-height: 340px;
            max-width: 100%;
            object-fit: contain;
        }
        .related-card {
            transition: transform 0.2s;
            border-radius: 10px;
            background: #fff;
        }
        .related-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.08);
        }
    </style>
</head>
<body class="bg-light">

    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-2">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary fs-4" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-store me-2"></i>Koha Store
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house me-1"></i> Trang chủ</a>
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
                                    <i class="fa-solid fa-circle-user me-1 text-info"></i> ${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <li><span class="dropdown-item-text text-muted small">Quyền: ${sessionScope.user.roleid == 1 ? 'Admin' : 'User'}</span></li>
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
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product" class="text-decoration-none">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
            </ol>
        </nav>

        <!-- Product Detail Box -->
        <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 mb-5 bg-white">
            <div class="row g-5 align-items-center">
                <!-- Cột trái: Ảnh sản phẩm -->
                <div class="col-lg-5">
                    <div class="product-detail-img shadow-sm border">
                        <c:choose>
                            <c:when test="${not empty product.images and product.images.startsWith('http')}">
                                <img src="${product.images}" alt="${product.productName}">
                            </c:when>
                            <c:when test="${not empty product.images}">
                                <img src="${pageContext.request.contextPath}/image?fname=${product.images}" alt="${product.productName}">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/image?fname=default.file" alt="Default">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Cột phải: Thông tin sản phẩm -->
                <div class="col-lg-7">
                    <div class="mb-2">
                        <span class="badge bg-primary px-3 py-2 fs-6">
                            <i class="fa-solid fa-tag me-1"></i> ${product.category.categoryname}
                        </span>
                        <c:choose>
                            <c:when test="${product.status == 1}">
                                <span class="badge bg-success-subtle text-success border border-success px-3 py-2 ms-2">
                                    <i class="fa-solid fa-circle-check me-1"></i> Đang kinh doanh
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger-subtle text-danger border border-danger px-3 py-2 ms-2">
                                    <i class="fa-solid fa-circle-xmark me-1"></i> Tạm ngừng bán
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h2 class="fw-bold text-dark mb-3">${product.productName}</h2>

                    <div class="d-flex align-items-baseline mb-4">
                        <span class="text-danger fw-bold display-6 me-3">
                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> đ
                        </span>
                        <span class="text-muted text-decoration-line-through fs-5">
                            <fmt:formatNumber value="${product.price * 1.15}" pattern="#,###"/> đ
                        </span>
                    </div>

                    <div class="p-3 bg-light rounded-3 mb-4">
                        <div class="row g-2 small">
                            <div class="col-6"><strong>Mã sản phẩm (ID):</strong> #${product.productId}</div>
                            <div class="col-6"><strong>Số lượng tồn kho:</strong> <span class="badge bg-secondary">${product.quantity} sản phẩm</span></div>
                            <div class="col-6"><strong>Bảo hành:</strong> 12 Tháng chính hãng</div>
                            <div class="col-6"><strong>Giao hàng:</strong> Miễn phí toàn quốc</div>
                        </div>
                    </div>

                    <h5 class="fw-bold mb-2">Mô tả sản phẩm:</h5>
                    <p class="text-secondary mb-4 leading-relaxed" style="white-space: pre-line;">
                        ${product.description}
                    </p>

                    <div class="d-flex flex-wrap gap-2 mt-4">
                        <button class="btn btn-danger btn-lg fw-bold px-4">
                            <i class="fa-solid fa-cart-shopping me-2"></i> Mua Ngay
                        </button>
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary btn-lg fw-semibold px-4">
                            <i class="fa-solid fa-arrow-left me-2"></i> Quay Lại Danh Sách
                        </a>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-lg fw-semibold px-4">
                            <i class="fa-solid fa-house me-2"></i> Về Trang Chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Section: Sản phẩm liên quan cùng danh mục -->
        <c:if test="${not empty relatedProducts and relatedProducts.size() > 1}">
            <div class="mb-5">
                <h4 class="fw-bold text-dark mb-3"><i class="fa-solid fa-boxes-stacked text-primary me-2"></i>Sản Phẩm Cùng Danh Mục</h4>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
                    <c:forEach items="${relatedProducts}" var="rp">
                        <c:if test="${rp.productId != product.productId}">
                            <div class="col">
                                <div class="card related-card h-100 border shadow-sm p-2 text-center">
                                    <div style="height: 150px; display: flex; align-items: center; justify-content: center;">
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${rp.productId}">
                                            <c:choose>
                                                <c:when test="${not empty rp.images and rp.images.startsWith('http')}">
                                                    <img src="${rp.images}" style="max-height: 130px; max-width: 90%; object-fit: contain;">
                                                </c:when>
                                                <c:when test="${not empty rp.images}">
                                                    <img src="${pageContext.request.contextPath}/image?fname=${rp.images}" style="max-height: 130px; max-width: 90%; object-fit: contain;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/image?fname=default.file" style="max-height: 130px; max-width: 90%; object-fit: contain;">
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </div>
                                    <div class="card-body p-2">
                                        <h6 class="card-title text-truncate fw-semibold mb-1">
                                            <a href="${pageContext.request.contextPath}/product/detail?id=${rp.productId}" class="text-dark text-decoration-none">
                                                ${rp.productName}
                                            </a>
                                        </h6>
                                        <div class="text-danger fw-bold mb-2">
                                            <fmt:formatNumber value="${rp.price}" pattern="#,###"/> đ
                                        </div>
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${rp.productId}" class="btn btn-sm btn-outline-primary w-100">
                                            Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>

    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-1 fw-semibold">Bài tập Thực hành Lập trình Web - Nhóm Koha (24110257ak)</p>
            <p class="text-muted small mb-0">Xem chi tiết 01 sản phẩm - Jakarta Servlet 6.0 & JPA 3.0</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
