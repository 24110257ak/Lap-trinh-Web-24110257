<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tất Cả Sản Phẩm - Phân Trang 6sp/trang - Koha Store</title>
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
            box-shadow: 0 12px 25px rgba(0,0,0,0.08);
        }
        .product-img-wrap {
            height: 220px;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .product-img-wrap img {
            max-height: 190px;
            max-width: 90%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .product-card:hover .product-img-wrap img {
            transform: scale(1.05);
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
                        <a class="nav-link active fw-semibold" href="${pageContext.request.contextPath}/product"><i class="fa-solid fa-layer-group me-1"></i> Tất cả sản phẩm</a>
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
        <!-- Breadcrumb & Title -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Danh sách sản phẩm</li>
            </ol>
        </nav>

        <div class="row">
            <!-- Sidebar Lọc Danh Mục -->
            <div class="col-lg-3 mb-4">
                <div class="card border-0 shadow-sm rounded-4 p-3 mb-3">
                    <h5 class="fw-bold mb-3"><i class="fa-solid fa-filter text-primary me-2"></i>Danh Mục</h5>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/product" class="list-group-item list-group-item-action ${empty selectedCategoryId ? 'active fw-bold' : ''}">
                            <i class="fa-solid fa-border-all me-2"></i>Tất cả danh mục
                        </a>
                        <c:forEach items="${listCategory}" var="c">
                            <a href="${pageContext.request.contextPath}/product?categoryId=${c.categoryId}" 
                               class="list-group-item list-group-item-action ${selectedCategoryId == c.categoryId ? 'active fw-bold' : ''}">
                                <i class="fa-solid fa-angle-right me-2"></i>${c.categoryname}
                            </a>
                        </c:forEach>
                    </div>
                </div>

                <!-- Ô tìm kiếm -->
                <div class="card border-0 shadow-sm rounded-4 p-3">
                    <h6 class="fw-bold mb-2"><i class="fa-solid fa-magnifying-glass me-2"></i>Tìm kiếm nhanh</h6>
                    <form action="${pageContext.request.contextPath}/product" method="get">
                        <div class="input-group">
                            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tên sản phẩm...">
                            <button class="btn btn-primary" type="submit"><i class="fa-solid fa-search"></i></button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Cột Danh Sách Sản Phẩm (Phân trang 6 sp/trang) -->
            <div class="col-lg-9">
                <div class="d-flex justify-content-between align-items-center mb-3 bg-white p-3 rounded-3 shadow-sm">
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Danh Sách Sản Phẩm</h4>
                        <small class="text-muted">Đang hiển thị <strong>${listProduct.size()}</strong> / Tổng số <strong>${totalProducts}</strong> sản phẩm (6 sản phẩm / trang)</small>
                    </div>
                    <span class="badge bg-primary fs-6">Trang ${currentPage} / ${totalPages}</span>
                </div>

                <c:if test="${empty listProduct}">
                    <div class="alert alert-warning text-center py-4 rounded-4 shadow-sm">
                        <i class="fa-solid fa-box-open fa-3x mb-3 text-warning"></i>
                        <h5>Không tìm thấy sản phẩm nào!</h5>
                        <p class="mb-0 text-muted">Vui lòng chọn danh mục khác hoặc quay lại <a href="${pageContext.request.contextPath}/product">tất cả sản phẩm</a>.</p>
                    </div>
                </c:if>

                <!-- Grid 6 sản phẩm: 2 hàng x 3 cột -->
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-3 mb-4">
                    <c:forEach items="${listProduct}" var="p">
                        <div class="col">
                            <div class="product-card shadow-sm">
                                <div class="product-img-wrap">
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
                                        <div class="text-danger fw-bold fs-5 mb-2">
                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                        </div>
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-outline-primary btn-sm w-100 fw-semibold">
                                            <i class="fa-solid fa-circle-info me-1"></i> Xem Chi Tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Phân Trang Pagination 6sp/trang -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center shadow-sm">
                            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage - 1}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}">
                                    <i class="fa-solid fa-chevron-left"></i> Trước
                                </a>
                            </li>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active fw-bold' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/product?page=${i}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage + 1}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}">
                                    Sau <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-1 fw-semibold">Bài tập Thực hành Lập trình Web - Nhóm Koha (24110257ak)</p>
            <p class="text-muted small mb-0">Phân trang 6 sản phẩm/trang tại URL /product - Jakarta Servlet 6.0 & JPA 3.0</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
