<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi Tiết Đơn Hàng</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>

<div class="container mt-4">
    <h2 class="mb-4 text-center">Chi Tiết Đơn Hàng - Mã Đơn Hàng:${requestScope.order.id}</h2>

    <!-- Thông tin đơn hàng -->
    <div class="row mb-4">
        <div class="col-md-6">
            <p><strong>Mã Đơn Hàng:</strong> ${requestScope.order.id}</p>
            <p><strong>Thời Gian Đặt:</strong> ${requestScope.order.timeOrdered}</p>
            <p><strong>Trạng Thái Đơn Hàng:</strong> ${requestScope.order.status}</p>
            <p><strong>Tổng Giá Trị:</strong> <fmt:formatNumber value="${requestScope.order.lastPrice}" type="number" />₫</p>
        </div>
    </div>

    <!-- Bảng chi tiết đơn hàng -->
    <h4 class="mb-3">Chi Tiết Sản Phẩm trong Đơn Hàng</h4>
    <table class="table table-bordered table-striped custom-table">
        <thead>
        <tr>
            <th>Mã Sản Phẩm</th>
            <th>Tên Sản Phẩm</th>
            <th>Màu sắc</th>
            <th>Loại</th>
            <th>Số Lượng</th>
            <th>Giá Tiền</th>
            <th>Tổng Giá</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="detail" items="${requestScope.order.listOfDetailOrder}">
            <tr>
                <td>${detail.id}</td>
                <td>${detail.style.product.name}</td>
                <td>${detail.style.name}</td>
                <td>${detail.style.product.category.name}</td>
                <td>${detail.quantity}</td>
                <td> <fmt:formatNumber value="${detail.style.product.price.lastPrice}" type="number" />₫</td>
                <td> <fmt:formatNumber value="${detail.totalPrice}" type="number" />₫</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

    <!-- Tổng giá trị đơn hàng -->
    <div class="row">
        <div class="col-md-12 text-end">
            <h5><strong> <fmt:formatNumber value="${requestScope.order.lastPrice}" type="number" />₫</strong></h5>
        </div>
    </div>
    <!-- Nút quay lại -->
    <div class="row">
        <div class="col-md-12 text-center mt-4">
            <a href="${pageContext.request.contextPath}/admin/manager-order" class="btn btn-secondary">Quay lại danh sách đơn hàng</a>
        </div>
    </div>
</div>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
