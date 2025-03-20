<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Dashboard - Quản Lý Hệ Thống</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
    <!-- Thêm Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>
<%@include file="menu-admin.jsp"%>

<div class="container-fluid mt-4">
    <h1 class="center-text mb-4 text-center" style="color: #2c8b73"><fmt:message key="dashboard_title"/></h1>
    <!-- Thông tin tổng quan -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><fmt:message key="user_count_title"/></h5>
                    <p class="card-text">${requestScope.numberOfUsers} <fmt:message key="user_count_suffix"/></p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><fmt:message key="voucher_count_title"/></h5>
                    <p class="card-text">${requestScope.numberOfVouchers} <fmt:message key="voucher_count_suffix"/></p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><fmt:message key="total_revenue_title"/></h5>
                    <fmt:formatNumber value="${requestScope.totalRevenue}" type="currency" currencySymbol="VNĐ" />
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><fmt:message key="order_count_title"/></h5>
                    <p class="card-text">${requestScope.numberOfOrders} <fmt:message key="order_count_suffix"/></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Biểu đồ thống kê (Sử dụng Chart.js) -->
    <div class="row mb-4">
        <div class="col-md-12">
            <h4><fmt:message key="revenue_chart_title"/></h4>
            <!-- Biểu đồ doanh thu theo tháng -->
            <canvas id="revenueChart" height="200"></canvas> <!-- Chiều cao biểu đồ nhỏ lại -->
        </div>
    </div>

    <!-- Bảng danh sách đơn hàng -->
    <table class="table table-bordered table-striped custom-table">
        <thead>
        <tr>
            <th><fmt:message key="order_table_order_id"/></th>
            <th><fmt:message key="order_table_order_time"/></th>
            <th><fmt:message key="order_table_user_id"/></th>
            <th><fmt:message key="order_table_voucher_id"/></th>
            <th><fmt:message key="order_table_order_status"/></th>
            <th><fmt:message key="order_table_total_price"/></th>
            <th><fmt:message key="order_table_last_price"/></th>
            <th><fmt:message key="order_table_action"/></th>
        </tr>
        </thead>
        <tbody>
        <!-- Đơn hàng 1 -->
        <c:forEach var="order" items="${requestScope.tenNewOrders}">
            <tr>
                <td>${order.id}</td>
                <td>${order.timeOrdered}</td>
                <td>${order.user.id}</td>
                <td>${order.voucher.idVoucher}</td>
                <td>${order.status}</td>
                <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="VNĐ" /></td>
                <td><fmt:formatNumber value="${order.lastPrice}" type="currency" currencySymbol="VNĐ" /></td>
                <td><a class="btn btn-info" href="management-detail-orders.jsp"><fmt:message key="order_table_view_details"/></a></td>
            </tr>
        </c:forEach>

        <!-- Các đơn hàng khác -->
        </tbody>
    </table>
</div>

<!-- Script để cấu hình và hiển thị biểu đồ -->
<script>
    // Biểu đồ doanh thu
    var revenueCtx = document.getElementById('revenueChart').getContext('2d');
    var revenueChart = new Chart(revenueCtx, {
        type: 'bar',  // Biểu đồ cột
        data: {
            labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],  // Các tháng
            datasets: [{
                label: 'Doanh Thu (VNĐ)',
                data: [
                    <c:forEach var="month" items="${requestScope.revenueByMonths}" varStatus="status">
                    ${month}<c:if test="${!status.last}">, </c:if>
                    </c:forEach>
                ],  // Dữ liệu doanh thu theo từng tháng
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
