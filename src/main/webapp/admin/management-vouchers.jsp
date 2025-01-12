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
            <th>Hóa Đơn Từ</th>
            <th>Cập Nhập</th>
            <th>Hủy Bỏ</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="voucher" items="${requestScope.vouchers}">
            <tr>
                <form action="${pageContext.request.contextPath}/admin/manager-voucher?method=update" method="post">
                    <input type="hidden" name="voucher_id" value="${voucher.idVoucher}">
                <td>${voucher.code}</td>
                <td><input type="number" name="amount" class="form-control" value="${voucher.discountAmount}" required></td>
                <td><input type="number" name="voucher_condition" class="form-control" value="${voucher.conditionAmount}" required></td>
                <td>
                    <button type="submit" class="btn btn-warning">Lưu thay đổi</button>
                </td>
                </form>
                <td>
                    <form action="${pageContext.request.contextPath}/admin/manager-voucher?method=delete" method="post">
                        <input type="hidden" name="voucher_id" value="${voucher.idVoucher}">
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </form>

                </td>

            </tr>
        </c:forEach>
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
                <form action="${pageContext.request.contextPath}/admin/manager-voucher?method=add" method="post">
                    <!-- Số Tiền -->
                    <div class="mb-3">
                        <label for="voucherAmount" class="form-label">Số Tiền</label>
                        <input type="number" class="form-control" id="voucherAmount" name="amount" required>
                    </div>

                    <!-- Điều Kiện Sử Dụng -->
                    <div class="mb-3">
                        <label for="voucherCondition" class="form-label">Điều Kiện Sử Dụng</label>
                        <input type="number" class="form-control" id="voucherCondition" name="condition" rows="3" required>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Thêm Voucher</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
