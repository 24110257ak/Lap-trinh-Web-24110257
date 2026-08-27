<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm Mới Danh Mục - Add Category</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .form-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            background: #fff;
            max-width: 600px;
            margin: 0 auto;
        }
        .preview-box {
            width: 120px;
            height: 120px;
            border: 2px dashed #ced4da;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
            overflow: hidden;
            margin-top: 10px;
        }
        .preview-box img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
            display: none;
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/category/list">Quản Lý Danh Mục</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Content -->
<div class="container my-5">
    <div class="form-card p-4 p-md-5">
        <div class="d-flex align-items-center mb-4">
            <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-3 me-3">
                <i class="bi bi-folder-plus fs-3"></i>
            </div>
            <div>
                <h3 class="fw-bold mb-1">Thêm Danh Mục Mới</h3>
                <p class="text-muted mb-0">Nhập thông tin và chọn ảnh đại diện danh mục</p>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
            <div class="mb-4">
                <label for="name" class="form-label fw-semibold">Tên Danh Mục: <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="name" name="name" 
                       placeholder="Ví dụ: Điện thoại, Laptop, Quần Áo..." required autofocus>
            </div>

            <div class="mb-4">
                <label for="icon" class="form-label fw-semibold">Ảnh Đại Diện (Icon / Avatar):</label>
                <input class="form-control" type="file" id="icon" name="icon" accept="image/*" onchange="previewImage(this);">
                <div class="form-text">Hỗ trợ các định dạng ảnh JPG, PNG, WEBP, GIF.</div>
                
                <div class="preview-box mt-2" id="previewContainer">
                    <i class="bi bi-image fs-1 text-muted" id="previewPlaceholder"></i>
                    <img id="imagePreview" alt="Xem trước ảnh">
                </div>
            </div>

            <div class="d-flex gap-2 justify-content-end mt-4">
                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary px-4">
                    <i class="bi bi-x-circle me-1"></i>Hủy bỏ
                </a>
                <button type="submit" class="btn btn-primary px-4 fw-semibold">
                    <i class="bi bi-check2-circle me-1"></i>Lưu Danh Mục
                </button>
            </div>
        </form>
    </div>
</div>

<script>
function previewImage(input) {
    const preview = document.getElementById('imagePreview');
    const placeholder = document.getElementById('previewPlaceholder');
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            preview.src = e.target.result;
            preview.style.display = 'block';
            placeholder.style.display = 'none';
        }
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
