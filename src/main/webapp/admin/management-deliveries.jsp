<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/6/2024
  Time: 11:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý vận chuyển</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>
<div class="container-fluid mt-4">
    <h2 class="text-center mb-4">Quản Lý Vận Chuyển</h2>

    <!-- Tìm kiếm vận chuyển -->
    <div class="row my-3">
        <div class="col-md-8"></div>
        <div class="col-md-4">
            <form method="post" action="manager-deliveries" class="d-flex float-end w-100">
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

    <!-- Bảng danh sách vận chuyển -->
    <table class="table table-bordered table-striped custom-table">
        <thead>
        <tr>
            <th> Mã vận chuyển </th>
            <th>Mã Đơn Hàng</th>
            <th>Thông Tin Giao Hàng</th>
            <th>Trọng lượng</th>
            <th>Phí Vận Chuyển</th>
            <th>Ghi Chú</th>
            <th>Trạng Thái Vận Chuyển</th>
            <th>Thời gian giao dự kiến </th>
        </tr>
        </thead>
        <tbody>
        <!-- Dữ liệu vận chuyển mẫu -->
       <c:forEach var="d" items="${requestScope.deliveries}">
           <tr>
                <td>${d.id}</td>
               <td>${d.idOrder}</td>
               <td>
                   <p><strong>Địa chỉ:</strong> ${d.address.street} / ${d.address.commune} / ${d.address.province} / ${d.address.city}</p>
                   <p><strong>Người nhận:</strong> ${d.fullName}</p>
                   <p><strong>SĐT:</strong> ${d.phoneNumber}</p>
               </td>
               <td> ${d.area} Kg</td>
               <td> ${d.deliveryFee} </td>
               <td>${d.note}</td>
               <td>${d.status}</td>
               <td>${d.scheduledDateTime}</td>
           </tr>
       </c:forEach>

        <!-- Các vận chuyển khác -->
        </tbody>
    </table>
</div>
<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
