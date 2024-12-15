<%--
  Created by IntelliJ IDEA.
  User: Le Dinh Hung
  Date: 12/15/2024
  Time: 9:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<html>
<head>
  <title>Thông tin người dùng</title>
</head>
<body>
<div class="container mt-5">
  <!-- Header -->
  <h3 class="text-center text-primary mb-4">Thông tin người dùng</h3>

  <!-- Form để chỉnh sửa thông tin người dùng -->
  <form action="saveUserInfo.jsp" method="post">
    <div class="row">
      <!-- Cột ảnh đại diện -->
      <div class="col-md-3 text-center">
        <div class="rounded-circle overflow-hidden" style="width: 150px; height: 150px; border: 3px solid #4fd0b6;">
          <img src="" alt="User Avatar" class="img-fluid">
        </div>
        <input type="file" class="form-control mt-2" name="avatar" accept="image/*">
      </div>

      <!-- Cột thông tin người dùng -->
      <div class="col-md-9">
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email" value="" required>
        </div>

        <div class="form-group">
          <label for="fullName">Họ và tên</label>
          <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ và tên" value="" required>
        </div>

        <div class="form-group">
          <label for="phoneNumber">Số điện thoại</label>
          <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Nhập số điện thoại" value="" required>
        </div>

        <!-- Địa chỉ -->
        <div class="form-group">
          <label for="province">Tỉnh</label>
          <input type="text" class="form-control" id="province" name="province" placeholder="Nhập tỉnh" value="" required>
        </div>

        <div class="form-group">
          <label for="commune">Xã</label>
          <input type="text" class="form-control" id="commune" name="commune" placeholder="Nhập xã" value="" required>
        </div>

        <div class="form-group">
          <label for="city">Thành phố</label>
          <input type="text" class="form-control" id="city" name="city" placeholder="Nhập thành phố" value="" required>
        </div>

        <div class="form-group">
          <label for="street">Đường</label>
          <input type="text" class="form-control" id="street" name="street" placeholder="Nhập đường" value="" required>
        </div>

        <!-- Nút lưu -->
        <button type="submit" class="btn btn-success mt-3">Lưu thông tin</button>
      </div>
    </div>
  </form>
</div>

<%@ include file="includes/footer.jsp" %>
<%@ include file="includes/link/footLink.jsp" %>
</body>
</html>

