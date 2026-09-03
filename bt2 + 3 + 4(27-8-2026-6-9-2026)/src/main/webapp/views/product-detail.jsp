<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm - ${product.productName}</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 20px;">
    <h2>Chi tiết sản phẩm</h2>
    <div>
        <a href="<c:url value="/home"/>">Trang chủ</a> | 
        <a href="<c:url value="/product"/>">Tất cả sản phẩm</a> | 
        <a href="<c:url value="/admin/products"/>">Quản lý sản phẩm</a> | 
        <a href="<c:url value="/admin/categories"/>">Quản lý danh mục</a>
    </div>
    <hr>

    <c:choose>
        <c:when test="${not empty product.images and (product.images.startsWith('http://') or product.images.startsWith('https://'))}">
            <c:url value="${product.images}" var="imgUrl"></c:url>
        </c:when>
        <c:otherwise>
            <c:url value="/image?fname=${product.images}" var="imgUrl"></c:url>
        </c:otherwise>
    </c:choose>

    <table border="0" cellpadding="15" cellspacing="0">
        <tr valign="top">
            <!-- Cột hình ảnh lớn -->
            <td width="320" align="center" style="border: 1px solid #ddd; background-color: #fafafa;">
                <img width="300" height="300" src="${imgUrl}" alt="${product.productName}" style="object-fit: contain;" />
            </td>

            <!-- Cột thông tin chi tiết -->
            <td style="padding-left: 25px;">
                <h2 style="margin-top: 0; color: #222;">${product.productName}</h2>
                <p><b>Mã sản phẩm:</b> #${product.productId}</p>
                <p><b>Danh mục:</b> <a href="<c:url value='/product?categoryId=${product.category.categoryId}'/>">${product.category.categoryname}</a></p>
                <p>
                    <b>Đơn giá:</b> 
                    <span style="color: red; font-size: 24px; font-weight: bold;">
                        <fmt:formatNumber value="${product.price}" pattern="#,###"/> đ
                    </span>
                </p>
                <p><b>Số lượng tồn kho:</b> ${product.quantity} sản phẩm</p>
                <p>
                    <b>Trạng thái:</b> 
                    <c:choose>
                        <c:when test="${product.status == 1}">
                            <span style="color: green; font-weight: bold;">Đang kinh doanh</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color: red; font-weight: bold;">Tạm ngừng bán</span>
                        </c:otherwise>
                    </c:choose>
                </p>
                <p><b>Mô tả sản phẩm:</b></p>
                <div style="background-color: #f9f9f9; border-left: 4px solid #007bff; padding: 12px 15px; max-width: 600px; line-height: 1.6;">
                    ${product.description}
                </div>
                <br>
                <a href="<c:url value="/product"/>" style="font-size: 15px; font-weight: bold;">&laquo; Quay lại danh sách sản phẩm</a> | 
                <a href="<c:url value="/home"/>" style="font-size: 15px;">Trang chủ</a>
            </td>
        </tr>
    </table>

    <br><br>
    <!-- Sản phẩm cùng danh mục -->
    <c:if test="${not empty relatedProducts and relatedProducts.size() > 1}">
        <h3>Sản phẩm cùng danh mục: ${product.category.categoryname}</h3>
        <table border="1" width="100%" cellpadding="8" cellspacing="0">
            <thead>
                <tr bgcolor="#f2f2f2">
                    <th width="50">STT</th>
                    <th width="100">Images</th>
                    <th>Tên sản phẩm</th>
                    <th width="140">Đơn giá</th>
                    <th width="120">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="stt" value="1" />
                <c:forEach items="${relatedProducts}" var="rp">
                    <c:if test="${rp.productId != product.productId}">
                        <tr>
                            <td align="center">${stt}</td>
                            <c:choose>
                                <c:when test="${not empty rp.images and (rp.images.startsWith('http://') or rp.images.startsWith('https://'))}">
                                    <c:url value="${rp.images}" var="rpImg"></c:url>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${rp.images}" var="rpImg"></c:url>
                                </c:otherwise>
                            </c:choose>
                            <td align="center">
                                <img height="60" width="80" src="${rpImg}" alt="${rp.productName}" style="object-fit: contain;" />
                            </td>
                            <td>
                                <a href="<c:url value='/product/detail?id=${rp.productId}'/>">
                                    <b>${rp.productName}</b>
                                </a>
                            </td>
                            <td align="right" style="color: red; font-weight: bold;">
                                <fmt:formatNumber value="${rp.price}" pattern="#,###"/> đ
                            </td>
                            <td align="center">
                                <a href="<c:url value='/product/detail?id=${rp.productId}'/>">Xem chi tiết</a>
                            </td>
                        </tr>
                        <c:set var="stt" value="${stt + 1}" />
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <br><hr>
    <a href="<c:url value="/home"/>">Quay lại trang chủ</a>
</body>
</html>
