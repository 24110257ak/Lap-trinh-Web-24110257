<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Koha Web Store</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 20px;">
    <h2>Koha Web Store (JPA 3.0 & Servlet 6.0)</h2>
    <div>
        <a href="<c:url value="/home"/>"><b>Trang chủ</b></a> | 
        <a href="<c:url value="/product"/>">Tất cả sản phẩm (Phân trang 6sp/trang)</a> | 
        <a href="<c:url value="/admin/products"/>">Quản lý sản phẩm</a> | 
        <a href="<c:url value="/admin/categories"/>">Quản lý danh mục</a> | 
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                Xin chào, <b>${sessionScope.user.fullName}</b> 
                (<c:choose><c:when test="${sessionScope.user.roleid == 1}">Admin</c:when><c:otherwise>Khách hàng</c:otherwise></c:choose>) | 
                <a href="<c:url value="/logout"/>">Đăng xuất</a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value="/login"/>">Đăng nhập</a> | 
                <a href="<c:url value="/register"/>">Đăng ký (OTP)</a>
            </c:otherwise>
        </c:choose>
    </div>
    <hr>

    <!-- 10 Sản phẩm mới nhất -->
    <h3>🔥 10 Sản phẩm mới nhất</h3>
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
            <c:forEach items="${topProducts}" var="p" varStatus="STT">
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
        </tbody>
    </table>
    <br>

    <!-- Danh mục sản phẩm -->
    <h3>📂 Khám phá theo danh mục</h3>
    <ul>
        <c:forEach items="${listCategory}" var="c">
            <li>
                <a href="<c:url value='/product?categoryId=${c.categoryId}'/>">
                    <b>${c.categoryname}</b>
                </a>
            </li>
        </c:forEach>
    </ul>

    <hr>
    <p style="color: #666; font-size: 13px;">Bài tập Lập trình Web - Koha (24110257ak) - ĐH Sư Phạm Kỹ Thuật TP.HCM</p>
</body>
</html>
