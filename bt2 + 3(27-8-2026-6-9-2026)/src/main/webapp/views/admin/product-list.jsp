<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm - JPA</title>
</head>
<body>
    <h2>Quản lý sản phẩm (JPA 3.0 & Hibernate 6.6)</h2>
    <a href="<c:url value="/admin/product/add"/>">Add Product (Thêm sản phẩm mới)</a> | 
    <a href="<c:url value="/admin/categories"/>">Quản lý danh mục</a> | 
    <a href="<c:url value="/home"/>">Trang chủ</a><br>
    <hr>

    <!-- Thông báo kết quả -->
    <c:if test="${not empty sessionScope.message}">
        <p style="color: green; font-weight: bold;">${sessionScope.message}</p>
        <c:remove var="message" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <p style="color: red; font-weight: bold;">${sessionScope.error}</p>
        <c:remove var="error" scope="session"/>
    </c:if>

    <!-- Tìm kiếm sản phẩm -->
    <form action="<c:url value="/admin/products"/>" method="get">
        <label>Tìm kiếm:</label>
        <input type="text" name="keyword" value="${not empty keyword ? keyword : ''}" placeholder="Nhập tên sản phẩm...">
        <input type="submit" value="Tìm">
        <c:if test="${not empty keyword}">
            <a href="<c:url value="/admin/products"/>">Hủy tìm</a>
        </c:if>
    </form>
    <br>

    <table border="1" width="100%" cellpadding="8" cellspacing="0">
        <thead>
            <tr bgcolor="#f2f2f2">
                <th width="50">STT</th>
                <th width="120">Images</th>
                <th>Product name</th>
                <th>Category</th>
                <th width="120">Price</th>
                <th width="70">Quantity</th>
                <th width="100">Status</th>
                <th width="140">Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${productList}" var="p" varStatus="STT">
                <tr>
                    <td align="center">${STT.index + 1}</td>
                    <c:choose>
                        <c:when test="${not empty p.images and (p.images.startsWith('http://') or p.images.startsWith('https://'))}">
                            <c:url value="${p.images}" var="imgUrl"></c:url>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${p.images}" var="imgUrl"></c:url>
                        </c:otherwise>
                    </c:choose>
                    <td align="center">
                        <img height="80" width="100" src="${imgUrl}" alt="${p.productName}" style="object-fit: contain;" />
                    </td>
                    <td>
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" target="_blank">
                            <b>${p.productName}</b>
                        </a>
                    </td>
                    <td>${p.category.categoryname}</td>
                    <td align="right" style="color: red; font-weight: bold;">
                        <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                    </td>
                    <td align="center">${p.quantity}</td>
                    <td align="center">
                        <c:if test="${p.status == 1}">
                            <span style="color: green; font-weight: bold;">Hoạt động</span>
                        </c:if>
                        <c:if test="${p.status != 1}">
                            <span style="color: red; font-weight: bold;">Khóa</span>
                        </c:if>
                    </td>
                    <td align="center">
                        <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>">Sửa</a>
                        | 
                        <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty productList}">
                <tr>
                    <td colspan="8" align="center">Không có sản phẩm nào trong hệ thống.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>
