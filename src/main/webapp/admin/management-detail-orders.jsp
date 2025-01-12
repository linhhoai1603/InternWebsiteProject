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
    <h2 class="mb-4 text-center">Chi Tiết Đơn Hàng - Mã Đơn Hàng: 111</h2>

    <!-- Thông tin đơn hàng -->
    <div class="row mb-4">
        <div class="col-md-6">
            <p><strong>Mã Đơn Hàng:</strong> 111</p>
            <p><strong>Thời Gian Đặt:</strong> 2024-12-06 10:30</p>
            <p><strong>Trạng Thái Đơn Hàng:</strong> Đang giao hàng</p>
            <p><strong>Tổng Giá Trị:</strong> 1,200,000 VNĐ</p>
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
            <th>Kích thước</th>
            <th>Loại</th>
            <th>Số Lượng</th>
            <th>Giá Tiền</th>
            <th>Tổng Giá</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>Vải kaki</td>
            <td>Màu da</td>
            <td>400x400</td>
            <td>Kaki</td>
            <td>2</td>
            <td>600,000 VNĐ</td>
            <td>1,200,000 VNĐ</td>
        </tr>
        <tr>
            <td>1</td>
            <td>Vải kaki</td>
            <td>Màu da</td>
            <td>400x400</td>
            <td>Kaki</td>
            <td>2</td>
            <td>600,000 VNĐ</td>
            <td>1,200,000 VNĐ</td>
        </tr>
        <tr>
            <td>1</td>
            <td>Vải kaki</td>
            <td>Màu da</td>
            <td>400x400</td>
            <td>Kaki</td>
            <td>2</td>
            <td>600,000 VNĐ</td>
            <td>1,200,000 VNĐ</td>
        </tr>
        </tbody>
    </table>

    <!-- Tổng giá trị đơn hàng -->
    <div class="row">
        <div class="col-md-12 text-end">
            <h5><strong>Tổng giá trị đơn hàng: 2,200,000 VNĐ</strong></h5>
        </div>
    </div>
    <!-- Nút quay lại -->
    <div class="row">
        <div class="col-md-12 text-center mt-4">
            <a href="management-orders.jsp" class="btn btn-secondary">Quay lại danh sách đơn hàng</a>
        </div>
    </div>
</div>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
