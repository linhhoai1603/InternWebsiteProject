<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/7/2024
  Time: 5:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi Tiết Vận Chuyển</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>
<div class="container-fluid mt-4">
    <h2 class="text-center mb-4">Chi Tiết Vận Chuyển</h2>

    <!-- Thông tin đơn hàng -->
    <div class="mb-4 text-center">
        <h4 class="text-center">Mã Đơn Hàng: ORD001</h4>
        <p><strong>Ngày Đặt Hàng:</strong> 2024-12-06 10:30</p>
        <p><strong>Trạng Thái Thanh Toán:</strong> Đã Thanh Toán</p>
        <p><strong>Thông Tin Người Đặt:</strong> Nguyễn Văn A - 0123456789</p>
    </div>

    <!-- Thông tin giao hàng -->
    <div class="mb-4 text-center">
        <h5 class="text-center">Thông Tin Giao Hàng</h5>
        <p><strong>Địa Chỉ Giao Hàng:</strong> ${delivery.address.city}, ${delivery.address.province}, ${delivery.address.commune}</p>
        <p><strong>Người Nhận:</strong> ${delivery.full_name}</p>
        <p><strong>SĐT Người Nhận:</strong> ${delivery.phone_number}</p>
        <p><strong>Ghi Chú:</strong> ${delivery.note}</p>
        <p><strong>Phí Vận Chuyển:</strong> ${delivery.delivery_fee} VNĐ</p>
    </div>

    <!-- Trạng thái vận chuyển -->
    <div class="mb-4 text-center">
        <h5 class="text-center">Trạng Thái Vận Chuyển</h5>
        <p><strong>Trạng Thái Hiện Tại:</strong> ${delivery.status}</p>
        <p><strong>Ngày Giờ Giao Hàng Dự Kiến:</strong> ${delivery.delivery_date}</p>
    </div>

    <div class="text-center">
        <a class="btn btn-primary" href="management-deliveries.jsp">Quay lại</a>
    </div>
</div>
<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
