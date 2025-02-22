<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/8/2024
  Time: 10:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi Tiết Người Dùng</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>
<div class="container-fluid mt-4">
    <h2 class="center-text mb-4">Chi Tiết Đơn Hàng Người Dùng</h2>

    <!-- Bảng hiển thị đơn hàng -->
    <table class="table custom-table">
        <thead>
        <tr>
            <th>Mã Đơn Hàng</th>
            <th>Thời Gian Đặt</th>
            <th>Mã Voucher</th>
            <th>Phương Thức Thanh Toán</th>
            <th>Số Lượng</th>
            <th>Trạng Thái Thanh Toán</th>
            <th>Thời Gian Thanh Toán</th>
            <th>Trạng Thái Đơn Hàng</th>
            <th>Giá Cuối</th>
        </tr>
        </thead>
        <tbody>
        <!-- Đơn hàng 1 -->
        <tr>
            <td>O001</td>
            <td>2024-12-01 14:30:00</td>
            <td>V001</td>
            <td>Online</td>
            <td>2</td>
            <td>Đã thanh toán</td>
            <td>2024-12-01 15:00:00</td>
            <td>Hoàn thành</td>
            <td>1,500,000 VNĐ</td>
        </tr>
        <!-- Đơn hàng 2 -->
        <tr>
            <td>O002</td>
            <td>2024-11-25 10:15:00</td>
            <td>Không áp dụng</td>
            <td>Tiền mặt</td>
            <td>1</td>
            <td>Chưa thanh toán</td>
            <td>Không xác định</td>
            <td>Chờ xử lý</td>
            <td>700,000 VNĐ</td>
        </tr>
        <!-- Đơn hàng 3 -->
        <tr>
            <td>O003</td>
            <td>2024-10-20 18:45:00</td>
            <td>V003</td>
            <td>Online</td>
            <td>3</td>
            <td>Đã thanh toán</td>
            <td>2024-10-20 19:00:00</td>
            <td>Hoàn thành</td>
            <td>2,200,000 VNĐ</td>
        </tr>
        </tbody>
    </table>

    <div class="text-center">
        <a class="btn btn-primary" href="management-users.jsp">Quay lại</a>
    </div>
</div>
<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>

