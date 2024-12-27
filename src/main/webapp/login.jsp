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
    <title>Các mẫu thiết kế</title>
</head>
<body>
<link rel="stylesheet" href="css/login.css">

<!-- Header with Navbar -->
        <a class="btn-back-home" href="index.jsp"><-- Về trang chủ</a>
<div class="container ">
    <%
        String error= (String) request.getAttribute("error");
        String username=(String) request.getAttribute("username");
        if(error==null) error = "";
        if(username==null) username = "";
    %>
    <p><%= error %></p>
    <div class="form-section">
        <h2>ĐĂNG NHẬP</h2>
        <p class="text-center">Vui lòng đăng nhập để truy cập tài khoản của bạn</p>

        <form id="loginForm" method="post" action="login">
            <div class="mb-3">
                <input class="form-control" id="username" placeholder="Username *" required type="text" name="username" aria-label="Username"/>
            </div>
            <div class="mb-3">
                <input class="form-control" id="password" placeholder="Mật khẩu *" required type="password" name="password" aria-label="Mật khẩu"/>
            </div>
            <div class="text-center">
                <button class="btn btn-primary" type="submit">Đăng nhập</button>
            </div>
        </form>
        <a href="register.jsp" class="register-link">Chưa có tài khoản? Đăng ký</a>
    </div>
</div>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>