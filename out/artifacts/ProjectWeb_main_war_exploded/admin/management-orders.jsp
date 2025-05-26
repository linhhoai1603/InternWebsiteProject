<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/6/2024
  Time: 3:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý đơn hàng</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>
<div class="container-fluid mt-4">
    <h2 class="text-center mb-4">Quản Lý Đơn Hàng</h2>


    <div class="row my-3">
        <div class="col-md-8">
            <c:set var="error" value="${not empty requestScope.error ? requestScope.error : ''}" />
            <c:if test="${not empty error}">
                <script type="text/javascript">
                    Swal.fire({
                        icon: 'error',
                        title: 'Thông báo',
                        text: "${error}"
                    });
                </script>
            </c:if>
        </div>
        <div class="col-md-4">
            <form method="post" action="${pageContext.request.contextPath}/admin/manager-order" class="d-flex float-end w-100">
                <div class="row w-100">
                    <div class="col-md-8">
                        <input type="number" placeholder="Tìm theo mã đơn hàng" name="idOrder" class="form-control me-2">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                    </div>
                </div>
            </form>
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
            <th>Trạng Thái Đơn Hàng</th>
            <th>Tổng Giá Trị</th>
            <th>Giá Sau Giảm</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="oder" items="${requestScope.orders}">
            <tr>
                <td>${oder.id}</td>
                <td>${oder.timeOrdered}</td>
                <td>${oder.user.id}</td>
                <td>
                    <c:choose>
                        <c:when test="${oder.voucher == null || oder.voucher.idVoucher == 0}">
                            NULL
                        </c:when>
                        <c:otherwise>
                            ${oder.voucher.idVoucher}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${oder.status}</td>
                <td>${oder.totalPrice}</td>
                <td>${oder.lastPrice}</td>
                <td><a class="btn btn-info" href="${pageContext.request.contextPath}/admin/order-detail?orderId=${oder.id}">Xem chi tiết</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="d-flex justify-content-center mt-3">
    <%
        int nuPage = Integer.parseInt(request.getAttribute("nuPage").toString());
        int loca = Integer.parseInt(request.getAttribute("loca").toString());
    %>
    <nav>
        <ul class="pagination">
            <%
                if (loca > 1) {
            %>
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/manager-order?loca=<%= loca - 1 %>">&laquo;</a>
            </li>
            <%
                }
                for (int i = 1; i <= nuPage; i++) {
                    if (i == loca) {
            %>
            <li class="page-item active">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/manager-order?loca=<%= i %>"><%= i %></a>
            </li>
            <%
            } else {
            %>
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/manager-order?loca=<%= i %>"><%= i %></a>
            </li>
            <%
                    }
                }
                if (loca < nuPage) {
            %>
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/manager-order?loca=<%= loca + 1 %>">&raquo;</a>
            </li>
            <%
                }
            %>
        </ul>
    </nav>
</div>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
