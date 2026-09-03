<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa sản phẩm</title>
</head>
<body>
    <h2>Chỉnh sửa sản phẩm (JPA 3.0 & Hibernate 6.6)</h2>
    <form action="<c:url value="/admin/product/update"/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productId" value="${product.productId}">

        <label for="productName">Product name (Tên sản phẩm):</label><br>
        <input type="text" id="productName" name="productName" value="${product.productName}" required style="width: 380px; padding: 5px;"><br><br>

        <label for="categoryId">Category (Danh mục):</label><br>
        <select id="categoryId" name="categoryId" required style="width: 250px; padding: 5px;">
            <c:forEach items="${categories}" var="c">
                <option value="${c.categoryId}" ${product.category.categoryId == c.categoryId ? 'selected' : ''}>
                    ${c.categoryname}
                </option>
            </c:forEach>
        </select><br><br>

        <label for="price">Price (Đơn giá VNĐ):</label><br>
        <input type="number" id="price" name="price" value="${product.price}" min="0" step="1000" required style="width: 250px; padding: 5px;"><br><br>

        <label for="quantity">Quantity (Số lượng tồn kho):</label><br>
        <input type="number" id="quantity" name="quantity" value="${product.quantity}" min="0" required style="width: 150px; padding: 5px;"><br><br>

        <label>Ảnh hiện tại:</label><br>
        <c:choose>
            <c:when test="${not empty product.images and (product.images.startsWith('http://') or product.images.startsWith('https://'))}">
                <c:url value="${product.images}" var="imgUrl"></c:url>
            </c:when>
            <c:otherwise>
                <c:url value="/image?fname=${product.images}" var="imgUrl"></c:url>
            </c:otherwise>
        </c:choose>
        <img height="100" width="140" src="${imgUrl}" alt="${product.productName}" style="object-fit: contain; border: 1px solid #ccc; padding: 3px;" /><br><br>

        <label for="imageLink">Link images (Nhập liên kết ảnh online mới nếu có):</label><br>
        <input type="text" id="imageLink" name="imageLink" value="${product.images.startsWith('http') ? product.images : ''}" placeholder="https://..." style="width: 380px; padding: 5px;"><br><br>

        <label for="imageFile">Upload images (Tải ảnh mới từ máy để thay thế):</label><br>
        <input type="file" id="imageFile" name="imageFile"><br><br>

        <label for="description">Description (Mô tả sản phẩm):</label><br>
        <textarea id="description" name="description" rows="4" style="width: 380px; padding: 5px;">${product.description}</textarea><br><br>

        <label>Status (Trạng thái):</label><br>
        <input type="radio" id="ston" name="status" value="1" ${product.status == 1 ? 'checked' : ''}>
        <label for="ston">Hoạt động</label>
        &nbsp;&nbsp;
        <input type="radio" id="stoff" name="status" value="0" ${product.status != 1 ? 'checked' : ''}>
        <label for="stoff">Khóa</label><br><br>

        <input type="submit" value="Update" style="padding: 6px 16px; font-weight: bold;">
        <input type="reset" value="Reset" style="padding: 6px 16px;">
    </form>
    <br>
    <a href="<c:url value="/admin/products"/>">Quay lại danh sách sản phẩm</a>
</body>
</html>
