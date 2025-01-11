<%@ page import="static com.oracle.wls.shaded.org.apache.xalan.xsltc.compiler.sym.error" %><%--
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
    <title> Đăng nhập </title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<link rel="stylesheet" href="css/login.css">

<!-- Header with Navbar -->
        <a class="btn-back-home" href="index.jsp"><-- Về trang chủ</a>
<div class="container ">
    <!-- Lấy giá trị error và username từ request scope -->
    <c:set var="error" value="${not empty requestScope.error ? requestScope.error : ''}" />
    <c:set var="username" value="${not empty requestScope.username ? requestScope.username : ''}" />

    <!-- Hiển thị thông báo nếu có lỗi -->
    <c:if test="${not empty error}">
        <script type="text/javascript">
            Swal.fire({
                title: 'Thông báo',
                text: "${error}"
            });
        </script>
    </c:if>

    <div class="form-section">
        <h2>ĐĂNG NHẬP</h2>
        <p class="text-center">Vui lòng đăng nhập để truy cập tài khoản của bạn</p>
            <div style="color: red;">
                    ${error}
            </div>
        <form id="loginForm" method="post" action="login">

            <div class="mb-3">
                <input class="form-control" id="username" placeholder="Tài khoản *" required type="text" name="username" aria-label="Username" value="${username}"/>
            </div>
            <div class="mb-3">
                <input class="form-control" id="password" placeholder="Mật khẩu *" required type="password" name="password" aria-label="Mật khẩu"/>
            </div>
            <div class="text-center">
                <button class="btn btn-primary" type="submit">Đăng nhập</button>
            </div>
        </form>
        <a href="register.jsp" class="register-link">Chưa có tài khoản? Đăng ký</a>
        <a href="confirm-email.jsp" class="register-link">Bạn quên mật khẩu?</a>
    </div>
</div>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>