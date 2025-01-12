<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản Lý Voucher</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>
<div class="container-fluid mt-4 text-center">
    <h2 class="center-text mb-4">Danh Sách Voucher</h2>

    <!-- Nút thêm voucher mở Modal -->
    <div class="text-right mb-3 float-end me-3">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addVoucherModal">Thêm Voucher</button>
    </div>

    <!-- Bảng thông tin voucher -->
    <table class="table custom-table">
        <thead>
        <tr>
            <th>Mã Voucher</th>
            <th>Số Tiền</th>
            <th>Điều Kiện Sử Dụng</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <!-- Ví dụ voucher 1 -->
        <form action="update-voucher" method="post">
            <!-- Mã Voucher (hidden để không sửa được) -->
            <input type="hidden" name="voucher_id" value="V001">
            <tr>
                <td>111</td>
                <td><input type="number" name="amount" class="form-control" value="500000" required></td>
                <td><input type="text" name="voucher_condition" class="form-control" value="Đơn hàng từ 1,000,000 VNĐ" required></td>
                <td>
                    <button type="submit" class="btn btn-warning">Lưu thay đổi</button>
                    <a class="btn btn-danger" href="delete-voucher" onclick="return confirm('Bạn có chắc chắn muốn xóa voucher này?')">Xóa</a>
                </td>
            </tr>
        </form>
        </tbody>
    </table>
</div>

<!-- Modal Thêm Voucher -->
<div class="modal fade" id="addVoucherModal" tabindex="-1" aria-labelledby="addVoucherModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addVoucherModalLabel">Thêm Voucher Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form Thêm Voucher -->
                <form action="add-voucher-process.jsp" method="post" enctype="multipart/form-data">
                    <!-- Mã Voucher -->
                    <div class="mb-3">
                        <label for="voucherCode" class="form-label">Mã Voucher</label>
                        <input type="text" class="form-control" id="voucherCode" name="voucherCode" required>
                    </div>

                    <!-- Số Tiền -->
                    <div class="mb-3">
                        <label for="voucherAmount" class="form-label">Số Tiền</label>
                        <input type="number" class="form-control" id="voucherAmount" name="voucherAmount" required>
                    </div>

                    <!-- Điều Kiện Sử Dụng -->
                    <div class="mb-3">
                        <label for="voucherCondition" class="form-label">Điều Kiện Sử Dụng</label>
                        <textarea class="form-control" id="voucherCondition" name="voucherCondition" rows="3" required></textarea>
                    </div>

                    <!-- Nút Gửi -->
                    <div class="text-center">
                        <a href="#" type="submit" class="btn btn-primary">Thêm Voucher</a>
                        <a href="#" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
