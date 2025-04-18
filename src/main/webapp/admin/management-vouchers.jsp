<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Quản Lý Voucher</title>
    <%@include file="../includes/link/headLink.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/management.css">
    <style>
        \  .table th, .table td {
            vertical-align: middle;
            font-size: 0.9rem;
        }

        .modal-body .form-label {
            font-weight: bold;
        }

        .form-control, .form-select {
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<%@include file="menu-admin.jsp" %>
<div class="container-fluid mt-4">
    <h2 class="text-center mb-4">Danh Sách Voucher</h2>

    <div class="text-end mb-3">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addVoucherModal">
            <i class="fas fa-plus me-1"></i> Thêm Voucher Mới
        </button>
    </div>

    <!-- Bảng thông tin voucher -->
    <div class="table-responsive">
        <table class="table table-striped table-hover custom-table border">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Mã Code</th>
                <th>Mô tả</th>
                <th>Loại</th>
                <th>Giá trị</th>
                <th>Đơn tối thiểu</th>
                <th>Giảm tối đa</th>
                <th>Ngày BĐ</th>
                <th>Ngày KT</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty requestScope.vouchers}">
                    <c:forEach var="voucher" items="${requestScope.vouchers}">
                        <tr>
                            <td>${voucher.idVoucher}</td>
                            <td><strong>${voucher.code}</strong></td>
                            <td>${voucher.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${voucher.discountType.name() == 'FIXED'}">Tiền cố định</c:when>
                                    <c:when test="${voucher.discountType.name() == 'PERCENTAGE'}">Phần trăm</c:when>
                                    <c:otherwise>${voucher.discountType.name()}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${voucher.discountType.name() == 'FIXED'}">
                                        <fmt:formatNumber value="${voucher.discountValue}" type="currency"
                                                          currencySymbol="" minFractionDigits="0"
                                                          maxFractionDigits="0"/>đ
                                    </c:when>
                                    <c:when test="${voucher.discountType.name() == 'PERCENTAGE'}">
                                        <fmt:formatNumber value="${voucher.discountValue}" type="percent"
                                                          maxFractionDigits="2"/>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td><fmt:formatNumber value="${voucher.minimumSpend}" type="currency" currencySymbol=""
                                                  minFractionDigits="0" maxFractionDigits="0"/>đ
                            </td>
                            <td>
                                <c:if test="${not empty voucher.maxDiscountAmount}">
                                    <fmt:formatNumber value="${voucher.maxDiscountAmount}" type="currency"
                                                      currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ
                                </c:if>
                                <c:if test="${empty voucher.maxDiscountAmount}">-</c:if>
                            </td>
                            <td>
                                <c:if test="${not empty voucher.startDate}"><fmt:formatDate
                                        value="${voucher.startDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></c:if>
                                <c:if test="${empty voucher.startDate}">-</c:if>
                            </td>
                            <td>
                                <c:if test="${not empty voucher.endDate}"><fmt:formatDate
                                        value="${voucher.endDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></c:if>
                                <c:if test="${empty voucher.endDate}">-</c:if>
                            </td>
                            <td>
                                <span class="badge ${voucher.isActive == 1 ? 'bg-success' : 'bg-secondary'}">
                                        ${voucher.isActive == 1 ? 'Kích hoạt' : 'Đã khóa'}
                                </span>
                            </td>
                            <td>
                                <!-- Nút Sửa -->
                                <button type="button" class="btn btn-warning btn-sm me-1"
                                        data-bs-toggle="modal" data-bs-target="#editVoucherModal"
                                        data-id="${voucher.idVoucher}"
                                        data-code="${voucher.code}"
                                        data-description="${voucher.description}"
                                        data-discount-type="${voucher.discountType}"
                                        data-discount-value="${voucher.discountValue}"
                                        data-minimum-spend="${voucher.minimumSpend}"
                                        data-max-discount-amount="${voucher.maxDiscountAmount}"
                                        data-start-date="${voucher.startDate != null ? voucher.startDate.toString().substring(0, 16).replace('T', ' ') : ''}"
                                        data-end-date="${voucher.endDate != null ? voucher.endDate.toString().substring(0, 16).replace('T', ' ') : ''}"
                                        data-max-uses="${voucher.maxUses}"
                                        data-uses-per-customer="${voucher.usesPerCustomer}"
                                        data-is-active="${voucher.isActive}"
                                        onclick="populateEditModal(this)">
                                    <i class="fas fa-edit"></i> Sửa
                                </button>

                                <!-- Form Xóa -->
                                <form action="${pageContext.request.contextPath}/admin/manager-voucher?method=delete"
                                      method="post" class="d-inline">
                                    <input type="hidden" name="idVoucher"
                                           value="${voucher.idVoucher}">
                                    <button type="submit" class="btn btn-danger btn-sm"
                                            onclick="return confirm('Bạn chắc chắn muốn xóa voucher \'${voucher.code}\'?');">
                                        <i class="fas fa-trash-alt"></i> Xóa
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="11" class="text-center">Không có voucher nào.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<%--<!-- ================== Modal Thêm Voucher ================== -->--%>
<div class="modal fade" id="addVoucherModal" tabindex="-1" aria-labelledby="addVoucherModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addVoucherModalLabel">Thêm Voucher Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form Thêm Voucher -->
                <form action="${pageContext.request.contextPath}/admin/manager-voucher?method=add" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="addCode" class="form-label">Mã Voucher <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="addCode" name="code" required maxlength="50">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="addDescription" class="form-label">Mô tả</label>
                            <input type="text" class="form-control" id="addDescription" name="description"
                                   maxlength="255">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="addDiscountType" class="form-label">Loại Giảm Giá <span
                                    class="text-danger">*</span></label>
                            <select class="form-select" id="addDiscountType" name="discountType" required>
                                <option value="FIXED" selected>Tiền cố định</option>
                                <option value="PERCENTAGE">Phần trăm</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="addDiscountValue" class="form-label">Giá Trị Giảm <span
                                    class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="addDiscountValue" name="discountValue"
                                   required step="0.01" min="0">
                            <small class="form-text text-muted">Nhập số tiền (VD: 50000) hoặc tỷ lệ % (VD: 10.5)</small>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="addMinimumSpend" class="form-label">Đơn Hàng Tối Thiểu</label>
                            <input type="number" class="form-control" id="addMinimumSpend" name="minimumSpend"
                                   step="0.01" min="0" value="0">
                            <small class="form-text text-muted">Nhập 0 nếu không yêu cầu.</small>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="addMaxDiscountAmount" class="form-label">Giảm Giá Tối Đa</label>
                            <input type="number" class="form-control" id="addMaxDiscountAmount" name="maxDiscountAmount"
                                   step="0.01" min="0">
                            <small class="form-text text-muted">Quan trọng khi loại là Phần trăm. Để trống nếu không
                                giới hạn.</small>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="addStartDate" class="form-label">Ngày Bắt Đầu</label>
                            <input type="datetime-local" class="form-control" id="addStartDate" name="startDate">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="addEndDate" class="form-label">Ngày Kết Thúc</label>
                            <input type="datetime-local" class="form-control" id="addEndDate" name="endDate">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="addMaxUses" class="form-label">Tổng Lượt Dùng Tối Đa</label>
                            <input type="number" class="form-control" id="addMaxUses" name="maxUses" min="1">
                            <small class="form-text text-muted">Để trống nếu không giới hạn.</small>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="addUsesPerCustomer" class="form-label">Lượt Dùng/Khách</label>
                            <input type="number" class="form-control" id="addUsesPerCustomer" name="usesPerCustomer"
                                   min="1" value="1">
                            <small class="form-text text-muted">Để trống nếu không giới hạn.</small>
                        </div>
                        <div class="col-md-4 mb-3 align-self-center">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch" id="addIsActive"
                                       name="isActive" value="true" checked>
                                <label class="form-check-label" for="addIsActive">Kích hoạt</label>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Thêm Voucher</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ================== Modal Sửa Voucher ================== -->
<div class="modal fade" id="editVoucherModal" tabindex="-1" aria-labelledby="editVoucherModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editVoucherModalLabel">Chỉnh Sửa Voucher</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form Sửa Voucher -->
                <form id="editVoucherForm"
                      action="${pageContext.request.contextPath}/admin/manager-voucher?method=update" method="post">
                    <input type="hidden" name="idVoucher" id="editIdVoucher">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editCode" class="form-label">Mã Voucher <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="editCode" name="code" required maxlength="50">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editDescription" class="form-label">Mô tả</label>
                            <input type="text" class="form-control" id="editDescription" name="description"
                                   maxlength="255">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editDiscountType" class="form-label">Loại Giảm Giá <span
                                    class="text-danger">*</span></label>
                            <select class="form-select" id="editDiscountType" name="discountType" required>
                                <option value="FIXED">Tiền cố định</option>
                                <option value="PERCENTAGE">Phần trăm</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editDiscountValue" class="form-label">Giá Trị Giảm <span
                                    class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="editDiscountValue" name="discountValue"
                                   required step="0.01" min="0">
                            <small class="form-text text-muted">Nhập số tiền hoặc tỷ lệ %.</small>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editMinimumSpend" class="form-label">Đơn Hàng Tối Thiểu</label>
                            <input type="number" class="form-control" id="editMinimumSpend" name="minimumSpend"
                                   step="0.01" min="0">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editMaxDiscountAmount" class="form-label">Giảm Giá Tối Đa</label>
                            <input type="number" class="form-control" id="editMaxDiscountAmount"
                                   name="maxDiscountAmount" step="0.01" min="0">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editStartDate" class="form-label">Ngày Bắt Đầu</label>
                            <input type="datetime-local" class="form-control" id="editStartDate" name="startDate">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editEndDate" class="form-label">Ngày Kết Thúc</label>
                            <input type="datetime-local" class="form-control" id="editEndDate" name="endDate">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="editMaxUses" class="form-label">Tổng Lượt Dùng Tối Đa</label>
                            <input type="number" class="form-control" id="editMaxUses" name="maxUses" min="1">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="editUsesPerCustomer" class="form-label">Lượt Dùng/Khách</label>
                            <input type="number" class="form-control" id="editUsesPerCustomer" name="usesPerCustomer"
                                   min="1">
                        </div>
                        <div class="col-md-4 mb-3 align-self-center">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch" id="editIsActive"
                                       name="isActive" value="true">
                                <label class="form-check-label" for="editIsActive">Kích hoạt</label>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/link/footLink.jsp" %>

<script>
    // Hàm để điền dữ liệu vào Modal Sửa khi nút Sửa được nhấn
    function populateEditModal(button) {
        const modal = document.getElementById('editVoucherModal');
        const form = document.getElementById('editVoucherForm');

        // Lấy dữ liệu từ data-* attributes của nút được nhấn
        const id = button.getAttribute('data-id');
        const code = button.getAttribute('data-code');
        const description = button.getAttribute('data-description');
        const discountType = button.getAttribute('data-discount-type');
        const discountValue = button.getAttribute('data-discount-value');
        const minimumSpend = button.getAttribute('data-minimum-spend');
        const maxDiscountAmount = button.getAttribute('data-max-discount-amount');
        let startDate = button.getAttribute('data-start-date');
        let endDate = button.getAttribute('data-end-date');
        const maxUses = button.getAttribute('data-max-uses');
        const usesPerCustomer = button.getAttribute('data-uses-per-customer');
        // Lấy giá trị isActive dưới dạng chuỗi ('1' hoặc '0')
        const isActiveValue = button.getAttribute('data-is-active');

        // Định dạng lại ngày giờ cho input type="datetime-local" (YYYY-MM-DDTHH:mm)
        const formatDateTimeLocal = (dateTimeString) => {
            // ... (code formatDateTimeLocal giữ nguyên như trước) ...
            if (!dateTimeString || dateTimeString === 'null' || dateTimeString.trim() === '') {
                return '';
            }
            try {
                let parts;
                let datePart, timePart;
                if (dateTimeString.includes('/')) {
                    parts = dateTimeString.split(' ');
                    datePart = parts[0].split('/');
                    timePart = parts[1];
                    // Đảm bảo các phần có 2 chữ số nếu cần (ví dụ: tháng/ngày)
                    datePart[1] = datePart[1].padStart(2, '0');
                    datePart[0] = datePart[0].padStart(2, '0');
                    // Đảm bảo giờ phút có 2 chữ số
                    let timeParts = timePart.split(':');
                    timeParts[0] = timeParts[0].padStart(2, '0');
                    timeParts[1] = timeParts[1].padStart(2, '0');
                    timePart = timeParts.join(':');
                    return `${datePart[2]}-${datePart[1]}-${datePart[0]}T${timePart}`;
                } else if (dateTimeString.includes('-') && dateTimeString.includes(' ')) { // yyyy-MM-dd HH:mm
                    return dateTimeString.replace(' ', 'T');
                } else if (dateTimeString.includes('-') && dateTimeString.includes('T')) { // Đã đúng định dạng
                    return dateTimeString;
                }
                // ... (phần parse bằng new Date giữ nguyên) ...
                else {
                    const date = new Date(dateTimeString);
                    if (!isNaN(date.getTime())) {
                        const year = date.getFullYear();
                        const month = (date.getMonth() + 1).toString().padStart(2, '0');
                        const day = date.getDate().toString().padStart(2, '0');
                        const hours = date.getHours().toString().padStart(2, '0');
                        const minutes = date.getMinutes().toString().padStart(2, '0');
                        return `${year}-${month}-${day}T${hours}:${minutes}`;
                    }
                }
            } catch (e) {
                console.error("Error parsing date:", dateTimeString, e);
                return '';
            }
            return '';
        };


        // Điền dữ liệu vào các trường trong form Sửa
        modal.querySelector('#editIdVoucher').value = id;
        modal.querySelector('#editCode').value = code;
        modal.querySelector('#editDescription').value = description === 'null' ? '' : description;
        modal.querySelector('#editDiscountType').value = discountType;
        modal.querySelector('#editDiscountValue').value = discountValue === 'null' ? '' : discountValue;
        modal.querySelector('#editMinimumSpend').value = minimumSpend === 'null' ? '' : minimumSpend;
        modal.querySelector('#editMaxDiscountAmount').value = maxDiscountAmount === 'null' ? '' : maxDiscountAmount;
        modal.querySelector('#editStartDate').value = formatDateTimeLocal(startDate);
        modal.querySelector('#editEndDate').value = formatDateTimeLocal(endDate);
        modal.querySelector('#editMaxUses').value = maxUses === 'null' ? '' : maxUses;
        modal.querySelector('#editUsesPerCustomer').value = usesPerCustomer === 'null' ? '' : usesPerCustomer;

        // *** SỬA ĐỔI Ở ĐÂY ***
        // Kiểm tra xem giá trị lấy được có phải là chuỗi '1' hay không
        // Kết quả của phép so sánh này sẽ là true (nếu là '1') hoặc false (nếu là '0' hoặc khác)
        modal.querySelector('#editIsActive').checked = (isActiveValue === '1');

    }

    // Optional: Clear add form when modal is hidden (nếu muốn)
    const addModal = document.getElementById('addVoucherModal');
    addModal.addEventListener('hidden.bs.modal', function (event) {
        // Kiểm tra xem form có tồn tại không trước khi reset
        const form = addModal.querySelector('form');
        if (form) {
            form.reset();
        }
    });

</script>

</body>
</html>