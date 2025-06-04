<%--
  Created by IntelliJ IDEA.
  User: your_name
  Date: today_date
  Time: current_time
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chỉnh Sửa Đơn Hàng</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>

<div class="container mt-4">
    <h2 class="mb-4 text-center">Chỉnh Sửa Đơn Hàng - Mã Đơn Hàng: ${requestScope.order.id}</h2>

    <form action="${pageContext.request.contextPath}/admin/edit-order" method="post">
        <!-- Hidden input for order ID -->
        <input type="hidden" name="orderId" value="${requestScope.order.id}">

        <!-- Thông tin đơn hàng có thể chỉnh sửa -->
        <div class="mb-3">
            <label for="status" class="form-label">Trạng Thái Đơn Hàng:</label>
            <select class="form-select" id="status" name="status">
                <option value="Ready to Pick" ${requestScope.order.status == 'Ready to Pick' ? 'selected' : ''}>Ready to Pick / Chờ lấy hàng</option>
                <option value="Picking" ${requestScope.order.status == 'Picking' ? 'selected' : ''}>Picking / Đang lấy hàng</option>
                <option value="Picked" ${requestScope.order.status == 'Picked' ? 'selected' : ''}>Picked / Đã lấy hàng</option>
                <option value="Storing" ${requestScope.order.status == 'Storing' ? 'selected' : ''}>Storing / Đã nhập kho</option>
                <option value="Transporting" ${requestScope.order.status == 'Transporting' ? 'selected' : ''}>Transporting / Đang vận chuyển</option>
                <option value="Delivering" ${requestScope.order.status == 'Delivering' ? 'selected' : ''}>Delivering / Đang giao hàng</option>
                <option value="Delivered" ${requestScope.order.status == 'Delivered' ? 'selected' : ''}>Delivered / Đã giao hàng thành công</option>
                <option value="Return" ${requestScope.order.status == 'Return' ? 'selected' : ''}>Return / Hoàn hàng</option>
                <option value="Returned" ${requestScope.order.status == 'Returned' ? 'selected' : ''}>Returned / Đã hoàn hàng</option>
                <option value="Cancelled" ${requestScope.order.status == 'Cancelled' ? 'selected' : ''}>Cancelled / Đã hủy</option>
                 <option value="Pending" ${requestScope.order.status == 'Pending' ? 'selected' : ''}>Pending / Chờ xử lý</option>
                <option value="Processing" ${requestScope.order.status == 'Processing' ? 'selected' : ''}>Processing / Đang xử lý</option>
                <option value="Shipped" ${requestScope.order.status == 'Shipped' ? 'selected' : ''}>Shipped / Đã giao hàng</option>
            </select>
        </div>

        <!-- Bạn có thể thêm các trường khác cần chỉnh sửa tại đây -->
        <%--
        <div class="mb-3">
            <label for="totalPrice" class="form-label">Tổng Giá Trị:</label>
            <input type="number" class="form-control" id="totalPrice" name="totalPrice" value="${requestScope.order.totalPrice}" step="0.01">
        </div>
        <div class="mb-3">
            <label for="lastPrice" class="form-label">Giá Sau Giảm:</label>
            <input type="number" class="form-control" id="lastPrice" name="lastPrice" value="${requestScope.order.lastPrice}" step="0.01">
        </div>
        --%>

        <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
        <a href="${pageContext.request.contextPath}/admin/manager-order" class="btn btn-secondary">Hủy</a>
    </form>

    <h4 class="mt-4 mb-3">Chi Tiết Sản Phẩm trong Đơn Hàng</h4>
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
            <th>Hành động</th>
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
                <td>
                    <a href="${pageContext.request.contextPath}/admin/edit-order-detail?detailId=${detail.id}" class="btn btn-primary">Edit</a>
                    <a href="${pageContext.request.contextPath}/admin/delete-order-detail?detailId=${detail.id}" class="btn btn-danger">Delete</a>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

</div>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html> 