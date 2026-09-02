<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Sản Phẩm #${product.productId} - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .preview-img { max-height: 120px; border-radius: 8px; border: 1px solid #ced4da; padding: 4px; background: #fff; }
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
            </div>
        </div>
    </nav>

    <div class="container my-4" style="max-width: 800px;">
        <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 bg-white">
            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                <h3 class="fw-bold text-primary mb-0"><i class="fa-solid fa-pen-to-square me-2"></i>Cập Nhật Sản Phẩm #${product.productId}</h3>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                </a>
            </div>

            <!-- Form upload Multipart cập nhật sản phẩm -->
            <form action="${pageContext.request.contextPath}/admin/product/update" method="post" enctype="multipart/form-data">
                <input type="hidden" name="productId" value="${product.productId}">

                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label fw-semibold">Tên sản phẩm: <span class="text-danger">*</span></label>
                        <input type="text" name="productName" value="${product.productName}" class="form-control" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Danh mục: <span class="text-danger">*</span></label>
                        <select name="categoryId" class="form-select" required>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.categoryId}" ${product.category.categoryId == c.categoryId ? 'selected' : ''}>
                                    ${c.categoryname}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Đơn giá (VNĐ): <span class="text-danger">*</span></label>
                        <input type="number" name="price" value="${product.price}" class="form-control" min="0" step="1000" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Số lượng tồn kho: <span class="text-danger">*</span></label>
                        <input type="number" name="quantity" value="${product.quantity}" class="form-control" min="0" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Trạng thái:</label>
                        <select name="status" class="form-select">
                            <option value="1" ${product.status == 1 ? 'selected' : ''}>Đang kinh doanh</option>
                            <option value="0" ${product.status == 0 ? 'selected' : ''}>Ngừng kinh doanh</option>
                        </select>
                    </div>

                    <!-- Upload ảnh mới hoặc đổi ảnh -->
                    <div class="col-12 border p-3 rounded-3 bg-light">
                        <label class="form-label fw-bold text-dark"><i class="fa-solid fa-image text-primary me-1"></i> Hình ảnh sản phẩm:</label>
                        <div class="d-flex align-items-center mb-3">
                            <span class="text-muted me-3">Ảnh hiện tại:</span>
                            <c:choose>
                                <c:when test="${not empty product.images and product.images.startsWith('http')}">
                                    <img src="${product.images}" class="preview-img" alt="${product.productName}">
                                </c:when>
                                <c:when test="${not empty product.images}">
                                    <img src="${pageContext.request.contextPath}/image?fname=${product.images}" class="preview-img" alt="${product.productName}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/image?fname=default.file" class="preview-img" alt="Default">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <label class="form-label small fw-semibold">Chọn file ảnh mới để thay thế (Upload Multipart):</label>
                        <input type="file" name="imageFile" class="form-control mb-2" accept="image/*">
                        <small class="text-muted d-block mb-1">Hoặc thay đổi bằng link ảnh trực tuyến mới:</small>
                        <input type="url" name="imageLink" value="${product.images.startsWith('http') ? product.images : ''}" class="form-control" placeholder="https://example.com/image.jpg">
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-semibold">Mô tả chi tiết sản phẩm:</label>
                        <textarea name="description" class="form-control" rows="4">${product.description}</textarea>
                    </div>

                    <div class="col-12 mt-4 text-end">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary px-4 me-2">Hủy bỏ</a>
                        <button type="submit" class="btn btn-primary px-4 fw-semibold">
                            <i class="fa-solid fa-save me-1"></i> Lưu Cập Nhật
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
