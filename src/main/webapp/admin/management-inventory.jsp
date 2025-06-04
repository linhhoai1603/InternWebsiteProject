<%--
  Created by IntelliJ IDEA.
  User: Le Dinh Hung
  Date: 6/4/2025
  Time: 9:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý Kho</title>
    <%@include file="../includes/link/headLink.jsp"%>
</head>
<body>
    <div class="container mt-4">
        <h1>Quản lý Kho</h1>

        <div class="button-container mb-3">
            <button id="kiemKhoBtn" class="btn btn-primary">Kiểm kho</button>
            <button id="nhapKhoBtn" class="btn btn-secondary">Nhập kho</button>
        </div>

        <div id="kiemKhoSection">
            <h2>Kiểm kho</h2>
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Mã Phiếu</th>
                        <th>Ngày tạo</th>
                        <th>Trạng thái</th>
                        <th>Mô tả</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${requestScope.inventory}">
                        <tr>
                            <td><c:out value="${item.id}"/></td>
                            <td><c:out value="${item.creatDate}"/></td>
                            <td><c:out value="${item.status}"/></td>
                            <td><c:out value="${item.description}"/></td>
                            <td>
                                <button class="btn btn-sm btn-info">Xem chi tiết</button>
                                <c:if test="${item.status != 'Đã chấp nhận'}">
                                    <button class="btn btn-sm btn-success accept-btn" data-id="${item.id}">Chấp nhận</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="nhapKhoSection" class="d-none">
            <h2>Nhập kho</h2>
            <table class="table table-striped table-bordered table-hover">
                 <thead>
                    <tr>
                        <th>Mã Phiếu</th>
                        <th>Ngày tạo</th>
                        <th>Trạng thái</th>
                        <th>Mô tả</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${requestScope.inventoryIn}">
                         <tr>
                            <td><c:out value="${item.id}"/></td>
                            <td><c:out value="${item.creatDate}"/></td>
                            <td><c:out value="${item.status}"/></td>
                            <td><c:out value="${item.description}"/></td>
                            <td>
                                <button class="btn btn-sm btn-info">Chi tiết nhập</button>
                                <c:if test="${item.status != 'Đã chấp nhận'}">
                                    <button class="btn btn-sm btn-success accept-btn" data-id="${item.id}">Xác nhận</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Xác nhận -->
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmModalLabel">Xác nhận</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn chấp nhận phiếu này không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" id="confirmAccept">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thành công -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="successModalLabel">Thành công</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <i class="fas fa-check-circle text-success" style="font-size: 48px;"></i>
                    <p class="mt-3">Đã chấp nhận phiếu thành công!</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <script src="js/ma-inventory.js"></script>
    <%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
