<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 2:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp"%>
<html>
<head>
  <link rel="stylesheet" href="css/register.css">
  <title>Đăng ký</title>
</head>
<body>
<a href="index.jsp"><-- Quay lại trang chủ</a>
<!-- Nội Dung Chính: Form Đăng Ký -->
<div class="container">
  <div class="row">
    <div class="con-md-6">
      <div class="form-section">
        <h2 class="text-center">ĐĂNG KÝ TÀI KHOẢN</h2>
        <span id="message" class="bg-danger"></span>
        <!-- Form Đăng Ký -->
        <form id="registrationForm" novalidate class="form-control">
          <!-- Email -->
          <div class="mb-3">
            <label for="email" class="form-label">Email *</label>
            <input
                    class="form-control"
                    id="email"
                    placeholder="Nhập địa chỉ Email của bạn"
                    required
                    type="email"
                    aria-describedby="emailHelp"
            />
          </div>

          <!-- Mật khẩu -->
          <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu *</label>
            <input
                    class="form-control"
                    id="password"
                    placeholder="Nhập mật khẩu"
                    required
                    type="password"
                    aria-describedby="passwordHelp"
            />
          </div>
          <!-- Xác nhận Mật khẩu -->
          <div class="mb-3">
            <label for="confirmPassword" class="form-label"
            >Xác nhận Mật khẩu *</label
            >
            <input
                    class="form-control"
                    id="confirmPassword"
                    placeholder="Nhập lại mật khẩu"
                    required
                    type="password"
                    aria-describedby="confirmPasswordHelp"
            />
          </div>
          <!-- Nút Đăng Ký -->
          <div class="text-center">
            <button class="btn btn-primary w-100" type="submit">ĐĂNG KÝ</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>