<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản Lý Người Dùng</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management-users.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .custom-table {
            background-color: #f9f9f9; /* Màu nền tổng thể của bảng */
        }
        .custom-table th {
            background-color: #2c8b73; /* Màu nền của header */
            color: #f1faee; /* Màu chữ của header */
        }
        .custom-table tbody tr:nth-child(odd) {
            background-color: #e6f7f8; /* Màu cho các dòng lẻ */
        }
        .custom-table tbody tr:nth-child(even) {
            background-color: #ffffff; /* Màu cho các dòng chẵn */
        }
        .custom-table tbody tr:hover {
            background-color: #c7ecee; /* Màu nền khi hover */
        }
        h2 {
            color: #2c8b73;
        }
        /* CSS cho dòng bị khóa */
        .disabled-row {
            background-color: #e0e0e0; /* Màu nền xám nhạt */
            color: #6c757d; /* Màu chữ xám */
        }

        /* CSS cho các nút bị disabled */
        /* CSS cho các nút bình thường (không bị disabled) */
        .btn {
            cursor: pointer;
        }
        /* CSS cho các nút bị disabled */
        /* Màu nền khi hover trên nút */
        .btn:hover {
            background-color: #5a6268;
        }

    </style>
</head>
<body>
<%@include file="menu-admin.jsp"%>
<c:if test="${requestScope.accounts == null}">
    <script>
        window.location.href = "admin-manager-users?method=getAllUsers";
    </script>
</c:if>
<c:set var="message" value="${not empty requestScope.message ? requestScope.message : ''}" />
<!-- Hiển thị thông báo nếu có lỗi -->
<c:if test="${not empty message}">
    <script type="text/javascript">
        Swal.fire({
            icon: 'message',
            title: 'Thông báo',
            text: "${message}"
        });
    </script>
</c:if>
<div class="container-fluid mt-4">
    <h2 class="center-text mb-4">Danh Sách Người Dùng</h2>
    <div class="row">
        <!-- Form Tìm kiếm Người dùng -->
        <div class="col-md-7">
            <a href="admin-manager-users" class="btn btn-warning">Xem danh sách người dùng</a>
        </div>
        <div class="col-md-5 my-3">
            <form action="admin-manager-users" method="post" class="d-flex">
                <input name="name" id="searchUser" type="text" class="form-control me-1" placeholder="Nhập tên người dùng" required>
                <input type="hidden" name="method" value="searchUser">
                <button type="submit" class="btn btn-primary">
                    Tìm kiếm<i class="fa-solid fa-search"></i>
                </button>
            </form>
        </div>
    </div>

    <!-- Bảng thông tin người dùng -->
    <table class="table custom-table">
        <thead>
        <tr>
            <th>Mã Người Dùng</th>
            <th>Họ Tên</th>
            <th>Email</th>
            <th>SĐT</th>
            <th>Địa Chỉ</th>
            <th>Số Lượng Đơn Hàng</th>
            <th>Số Tiền Đã Mua (VNĐ)</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="account" items="${requestScope.accounts}">
            <tr class="${account.locked >= 1 ? 'table-secondary text-muted disabled-row' : ''}">
                <td>${account.user.id}</td>
                <td>${account.user.fullName}</td>
                <td>${account.user.email}</td>
                <td>${account.user.numberPhone}</td>
                <td>${account.user.address.street} / ${account.user.address.commune} / ${account.user.address.province} / ${account.user.address.city}</td>
                <td>${account.user.orderCount}</td>
                <td class="price">${account.user.totalSpent}</td>
                <td>
                    <!-- Form Lock (chỉ hiển thị nếu user chưa bị khóa) -->
                    <c:if test="${account.locked == 0}">
                        <form action="admin-manager-users" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn khóa người dùng này?')">
                            <input type="hidden" name="user_id" value="${account.user.id}">
                            <input type="hidden" name="method" value="lockUser">
                            <button type="submit" class="btn btn-danger">
                                Lock
                            </button>
                        </form>
                    </c:if>

                    <!-- Form Lock (chỉ hiển thị nếu user chưa bị khóa) -->
                    <c:if test="${account.locked == 1}">
                        <form action="admin-manager-users" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn mở khóa người dùng này?')">
                            <input type="hidden" name="user_id" value="${account.user.id}">
                            <input type="hidden" name="method" value="unlockUser">
                            <button type="submit" class="btn btn-primary">
                                UnLock
                            </button>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="text-center">
        <a class="btn btn-primary" href="admin/dashboard.jsp">Quay lại</a>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Hàm định dạng số tiền thành tiền Việt
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
        }

        // Định dạng giá gốc
        document.querySelectorAll(".price").forEach(el => {
            const originalPrice = el.textContent.trim().replace("VND", "").replace(/,/g, "");
            if (originalPrice) {
                el.textContent = formatCurrency(parseFloat(originalPrice));
            }
        });
    });
</script>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
