<%--
  Created by IntelliJ IDEA.
  User: your_name
  Date: today_date
  Time: current_time
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Chỉnh Sửa Chi Tiết Đơn Hàng</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>

<div class="container mt-4">
    <h2 class="mb-4 text-center">
        <c:if test="${requestScope.orderDetail != null}">Chỉnh Sửa Chi Tiết Đơn Hàng - Mã Chi Tiết: ${requestScope.orderDetail.id}</c:if>
        <c:if test="${requestScope.orderDetail == null}">Thêm Mới Chi Tiết Đơn Hàng cho Đơn Hàng ${requestScope.orderId}</c:if>
    </h2>

    <form action="${pageContext.request.contextPath}/admin/edit-order-detail" method="post">
        <!-- Hidden inputs -->
        <input type="hidden" name="orderId" value="${requestScope.orderId}">
        <c:if test="${requestScope.orderDetail != null}">
            <input type="hidden" name="detailId" value="${requestScope.orderDetail.id}">
        </c:if>

        <!-- Form fields -->
        <div class="mb-3">
            <label for="style" class="form-label">Sản Phẩm/Style:</label>
            <select class="form-select" id="style" name="styleId" required>
                <c:forEach var="style" items="${requestScope.allStyles}">
                    <option value="${style.id}" ${requestScope.orderDetail.style.id == style.id ? 'selected' : ''}>
                            ${style.product.name} - ${style.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label for="quantity" class="form-label">Số Lượng:</label>
            <input type="number" class="form-control" id="quantity" name="quantity" value="${requestScope.orderDetail.quantity}" min="1" required>
        </div>

        <%-- Các trường totalPrice và weight sẽ được tính toán lại --%>

        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="${pageContext.request.contextPath}/admin/edit-order?orderId=${requestScope.orderId}" class="btn btn-secondary">Hủy</a>
    </form>

</div>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html> 