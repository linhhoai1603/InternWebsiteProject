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
    <title>Quản lý tin nhắn từ người dùng</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
    <%@include file="menu-admin.jsp"%>
    <div class="container-fluid mt-4">
        <h2 class="mb-4 text-center">Quản lý tin nhắn từ người dùng</h2>

        <!-- Tìm kiếm tin nhắn -->
        <div class="row my-3">
            <div class="col-md-8"></div>
            <div class="col-md-4">
                <form method="post" action="manager-message" class="d-flex float-end w-100">
                    <div class="row w-100">
                        <div class="col-md-8">
                            <input type="text" placeholder="Nhập tên người dùng tìm kiếm" name="name" class="form-control me-2">
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Bảng hiển thị tin nhắn -->
       <div class="row">
           <table class="table table-bordered table-hover table-striped custom-table">
               <thead>
               <tr>
                   <th>Mã Tin Nhắn</th>
                   <th>Mã Người Dùng</th>
                   <th>Tên Người Dùng</th>
                   <th>Số Điện Thoại</th>
                   <th>Địa Chỉ Email</th>
                   <th>Tiêu Đề</th>
                   <th>Nội Dung</th>
               </tr>
               </thead>
               <tbody id="messageTable">
              <c:forEach var="message" items="${requestScope.messages}">
                  <tr>
                      <td>${message.id}</td>
                      <td>${message.user.id}</td>
                      <td>${message.user.fullName}</td>
                      <td>${message.user.numberPhone}</td>
                      <td>${message.user.email}</td>
                      <td>${message.title}</td>
                      <td>${message.content}</td>
                  </tr>
              </c:forEach>
               </tbody>
           </table>
       </div>
    </div>
    <%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
