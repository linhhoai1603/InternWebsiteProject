<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <link rel="stylesheet" href="css/register.css">
  <title>Đăng ký</title>
  <style>
    body, html {
      height: 100%;
    }
    .container {
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .form-section {
      width: 100%;
      max-width: 500px;
      padding: 20px;
      border: 1px solid #dee2e6;
      border-radius: 8px;
      background-color: #f8f9fa;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    .alert {
      display: none;
    }
    .alert.show {
      display: block;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="row w-100">
    <div class="col-md-6 mx-auto">
      <div class="form-section">
        <h2 class="text-center mb-4">ĐĂNG KÝ TÀI KHOẢN</h2>

        <!-- Hiển thị thông báo lỗi từ Servlet (nếu có) -->
        <c:if test="${not empty error}">
          <div class="alert alert-danger show" role="alert">
            <c:out value="${error}" />
          </div>
        </c:if>

        <!-- Form Đăng Ký -->
        <!-- CHỈNH SỬA Ở ĐÂY: action="register" (trùng với @WebServlet(value="/register")) -->
        <form id="registrationForm" action="register" method="post" novalidate>
          <!-- Email -->
          <div class="form-group mb-3">
            <label for="email" class="form-label">Email *</label>
            <input
                    class="form-control"
                    id="email"
                    name="email"
                    placeholder="Nhập địa chỉ Email của bạn"
                    required
                    type="email"
            />
          </div>

          <!-- Mật khẩu -->
          <div class="form-group mb-3">
            <label for="password" class="form-label">Mật khẩu *</label>
            <input
                    class="form-control"
                    id="password"
                    name="password"
                    placeholder="Nhập mật khẩu"
                    required
                    type="password"
            />
          </div>

          <!-- Xác nhận Mật khẩu -->
          <div class="form-group mb-4">
            <label for="confirmPassword" class="form-label">Xác nhận Mật khẩu *</label>
            <input
                    class="form-control"
                    id="confirmPassword"
                    name="confirmPassword"
                    placeholder="Nhập lại mật khẩu"
                    required
                    type="password"
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
<%@ include file="includes/link/footLink.jsp" %>
</body>
</html>
