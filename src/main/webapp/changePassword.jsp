<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/10/2024
  Time: 10:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Đổi Mật Khẩu</title>
   <%@include file="includes/link/headLink.jsp"%>
</head>
<body>
<a href="index.jsp"><-- Trang chủ</a>
<div class="container py-5">
    <h2 class="text-center mb-4">Đổi Mật Khẩu</h2>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <form>
                <!-- Mật khẩu hiện tại -->
                <div class="mb-3">
                    <label for="currentPassword" class="form-label">Mật khẩu hiện tại</label>
                    <input type="password" name="current_pass" class="form-control" id="currentPassword" placeholder="Nhập mật khẩu hiện tại" required>
                </div>
                <!-- Mật khẩu mới -->
                <div class="mb-3">
                    <label for="newPassword" class="form-label">Mật khẩu mới</label>
                    <input type="password" name="new_pass1" class="form-control" id="newPassword" placeholder="Nhập mật khẩu mới" required>
                </div>
                <!-- Xác nhận mật khẩu mới -->
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                    <input type="password" name="new_pass2" class="form-control" id="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                </div>
                <!-- Nút gửi -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Đổi Mật Khẩu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="includes/link/headLink.jsp"%>
</body>
</html>

