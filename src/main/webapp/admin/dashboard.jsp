<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard - Quản Lý Hệ Thống</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
    <!-- Thêm Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<%@include file="menu-admin.jsp"%>
<c:if test="${empty sessionScope.numberOfUsers || sessionScope.numberOfUsers == 0}">
    <script>
        window.location.href = 'dashboard';
    </script>
</c:if>

<div class="container-fluid mt-4">
    <h1 class="center-text mb-4 text-center" style="color: #2c8b73">Bảng Điều Khiển</h1>
    <!-- Thông tin tổng quan -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Số Lượng Người Dùng</h5>
                    <p class="card-text">${requestScope.numberOfUsers} người dùng</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Số Lượng Voucher</h5>
                    <p class="card-text">${requestScope.numberOfVouchers} voucher</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Doanh Thu Tổng</h5>
                    <fmt:formatNumber value="${requestScope.totalRevenue}" type="currency" currencySymbol="VNĐ" />
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Số Lượng Đơn Hàng</h5>
                    <p class="card-text">${requestScope.numberOfOrders} đơn hàng</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Biểu đồ thống kê (Sử dụng Chart.js) -->
    <div class="row mb-4">
        <div class="col-md-12">
            <h4>Biểu đồ Doanh Thu Theo Tháng</h4>
            <!-- Biểu đồ doanh thu theo tháng -->
            <canvas id="revenueChart" height="200"></canvas> <!-- Chiều cao biểu đồ nhỏ lại -->
        </div>
    </div>

    <!-- Bảng danh sách đơn hàng -->
    <table class="table table-bordered table-striped custom-table">
        <thead>
        <tr>
            <th>Mã Đơn Hàng</th>
            <th>Thời Gian Đặt</th>
            <th>Mã Người Dùng</th>
            <th>Mã Giảm Giá</th>
            <th>Phương Thức Thanh Toán</th>
            <th>Trạng Thái Thanh Toán</th>
            <th>Trạng Thái Đơn Hàng</th>
            <th>Tổng Giá Trị</th>
            <th>Giá Sau Giảm</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <!-- Đơn hàng 1 -->
        <tr>
            <td>ORD001</td>
            <td>2024-12-06 10:30</td>
            <td>1101</td>
            <td>VOUCHER123</td>
            <td>Chuyển khoản</td>
            <td>Đã thanh toán</td>
            <td>Đang xử lý</td>
            <td>500.000 VNĐ</td>
            <td>450.000 VNĐ</td>
            <td><a class="btn btn-info" href="management-detail-orders.jsp">Xem chi tiết</a></td>
        </tr>
        <!-- Đơn hàng 2 -->
        <tr>
            <td>ORD002</td>
            <td>2024-12-06 11:00</td>
            <td>1102</td>
            <td>NULL</td>
            <td>Tiền mặt</td>
            <td>Chưa thanh toán</td>
            <td>Đang giao hàng</td>
            <td>1.200.000 VNĐ</td>
            <td>1.200.000 VNĐ</td>
            <td><a class="btn btn-info" href="management-detail-orders.jsp">Xem chi tiết</a></td>
        </tr>
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
                data: [1000000, 1500000, 1200000, 1800000, 2000000, 2200000, 2100000, 2500000, 2300000, 2800000, 2900000, 3100000],  // Dữ liệu doanh thu theo từng tháng
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
