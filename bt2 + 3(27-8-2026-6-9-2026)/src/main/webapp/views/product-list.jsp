<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm - Phân trang 6sp/trang</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 20px;">
    <h2>Tất cả sản phẩm (Phân trang 6sp/trang)</h2>
    <div>
        <a href="<c:url value="/home"/>">Trang chủ</a> | 
        <a href="<c:url value="/product"/>"><b>Tất cả sản phẩm</b></a> | 
        <a href="<c:url value="/admin/products"/>">Quản lý sản phẩm</a> | 
        <a href="<c:url value="/admin/categories"/>">Quản lý danh mục</a>
    </div>
    <hr>

    <!-- Lọc theo danh mục -->
    <div>
        <b>Lọc theo danh mục:</b>
        <a href="<c:url value="/product"/>" style="${empty selectedCategoryId ? 'font-weight: bold; color: red;' : ''}">Tất cả</a>
        <c:forEach items="${listCategory}" var="c">
            &nbsp;|&nbsp;
            <a href="<c:url value="/product?categoryId=${c.categoryId}"/>" style="${selectedCategoryId == c.categoryId ? 'font-weight: bold; color: red;' : ''}">
                ${c.categoryname}
            </a>
        </c:forEach>
    </div>
    <br>

    <!-- Tìm kiếm -->
    <form action="<c:url value="/product"/>" method="get">
        <label>Tìm kiếm sản phẩm:</label>
        <input type="text" name="keyword" value="${not empty keyword ? keyword : ''}" placeholder="Nhập tên sản phẩm...">
        <input type="submit" value="Tìm">
        <c:if test="${not empty keyword or not empty selectedCategoryId}">
            <a href="<c:url value="/product"/>">Xóa bộ lọc</a>
        </c:if>
    </form>
    <br>

    <p>
        Hiển thị: <b>${listProduct.size()}</b> / Tổng số: <b>${totalProducts}</b> sản phẩm. 
        (Trang <b>${currentPage}</b> / <b>${totalPages}</b>)
    </p>

    <table border="1" width="100%" cellpadding="8" cellspacing="0">
        <thead>
            <tr bgcolor="#f2f2f2">
                <th width="50">STT</th>
                <th width="120">Images</th>
                <th>Tên sản phẩm</th>
                <th width="180">Danh mục</th>
                <th width="140">Đơn giá</th>
                <th width="120">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listProduct}" var="p" varStatus="STT">
                <tr>
                    <td align="center">${(currentPage - 1) * 6 + STT.index + 1}</td>
                    <c:choose>
                        <c:when test="${not empty p.images and (p.images.startsWith('http://') or p.images.startsWith('https://'))}">
                            <c:url value="${p.images}" var="imgUrl"></c:url>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${p.images}" var="imgUrl"></c:url>
                        </c:otherwise>
                    </c:choose>
                    <td align="center">
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>">
                            <img height="80" width="100" src="${imgUrl}" alt="${p.productName}" style="object-fit: contain;" />
                        </a>
                    </td>
                    <td>
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" style="text-decoration: none; color: #0066cc;">
                            <b>${p.productName}</b>
                        </a>
                    </td>
                    <td>${p.category.categoryname}</td>
                    <td align="right" style="color: red; font-weight: bold;">
                        <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                    </td>
                    <td align="center">
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>">Xem chi tiết</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty listProduct}">
                <tr>
                    <td colspan="6" align="center">Không tìm thấy sản phẩm nào phù hợp.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
    <br>

    <!-- Phân trang 6 sản phẩm / trang -->
    <c:if test="${totalPages > 1}">
        <div style="text-align: center; margin: 20px 0; font-size: 16px;">
            <b>Trang: </b>
            <c:if test="${currentPage > 1}">
                <a href="<c:url value="/product?page=${currentPage - 1}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}"/>">
                    [ &lt;&lt; Trước ]
                </a>
                &nbsp;
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${currentPage == i}">
                        <span style="background-color: #007bff; color: white; padding: 4px 10px; font-weight: bold; border-radius: 3px;">
                            ${i}
                        </span>
                        &nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value="/product?page=${i}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}"/>" style="padding: 4px 8px; text-decoration: none; border: 1px solid #ccc;">
                            ${i}
                        </a>
                        &nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="<c:url value="/product?page=${currentPage + 1}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}"/>">
                    [ Sau &gt;&gt; ]
                </a>
            </c:if>
        </div>
    </c:if>

    <hr>
    <a href="<c:url value="/home"/>">Quay lại trang chủ</a>
</body>
</html>
