<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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
                <h3 class="fw-bold text-primary mb-0"><i class="fa-solid fa-plus-circle me-2"></i>Thêm Sản Phẩm Mới</h3>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                </a>
            </div>

            <!-- Form upload Multipart theo giáo trình 10_UploadFile_servlet_jakarta.pdf -->
            <form action="${pageContext.request.contextPath}/admin/product/insert" method="post" enctype="multipart/form-data">
                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label fw-semibold">Tên sản phẩm: <span class="text-danger">*</span></label>
                        <input type="text" name="productName" class="form-control" required placeholder="Nhập tên sản phẩm...">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Danh mục: <span class="text-danger">*</span></label>
                        <select name="categoryId" class="form-select" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.categoryId}">${c.categoryname}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Đơn giá (VNĐ): <span class="text-danger">*</span></label>
                        <input type="number" name="price" class="form-control" min="0" step="1000" required placeholder="Ví dụ: 15000000">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Số lượng tồn kho: <span class="text-danger">*</span></label>
                        <input type="number" name="quantity" class="form-control" min="0" value="10" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Trạng thái:</label>
                        <select name="status" class="form-select">
                            <option value="1" selected>Đang kinh doanh</option>
                            <option value="0">Ngừng kinh doanh</option>
                        </select>
                    </div>

                    <!-- Upload ảnh qua Multipart -->
                    <div class="col-12 border p-3 rounded-3 bg-light">
                        <label class="form-label fw-bold text-dark"><i class="fa-solid fa-image text-primary me-1"></i> Hình ảnh sản phẩm (Upload Multipart):</label>
                        <input type="file" name="imageFile" class="form-control mb-2" accept="image/*">
                        <small class="text-muted d-block mb-2">Hoặc dán đường link ảnh trực tuyến (nếu không tải file từ máy tính):</small>
                        <input type="url" name="imageLink" class="form-control" placeholder="https://example.com/image.jpg">
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-semibold">Mô tả chi tiết sản phẩm:</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Nhập thông số, tính năng nổi bật của sản phẩm..."></textarea>
                    </div>

                    <div class="col-12 mt-4 text-end">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary px-4 me-2">Hủy bỏ</a>
                        <button type="submit" class="btn btn-primary px-4 fw-semibold">
                            <i class="fa-solid fa-save me-1"></i> Lưu Sản Phẩm
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
