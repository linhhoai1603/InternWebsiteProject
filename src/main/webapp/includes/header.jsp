<%@ page import="models.User" %><%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 10:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="includes/css/header.css">
<%@include file="link/headLink.jsp"%>
<div class="container-fluid">
    <div class="row intro text-white bg">
        <div class="col-md-12">
            <p class="text-center">Vô Vàn Vải - Vô vàn sáng tạo</p>
        </div>
    </div>
    <div class="header">
        <div class="row">
            <div class="col-md-2 text-center">
                <img
                        src="images/logo.png"
                        alt=""
                        style="width: 100%; height: 100%"
                />
            </div>
            <div class="col-md-5 text-center pt-4">
                <!-- a line search-->
                <form action="${pageContext.request.contextPath}/products" method="get">
                    <div class="input-group">
                        <input
                                type="text"
                                class="form-control w-80"
                                placeholder="Tìm kiếm sản phẩm"
                                name="search"
                                id="searchInput"
                        />
                        <button class="btn text-white btn-bg" type="submit">
                            <i class="fa-solid fa-magnifying-glass"></i>&nbsp;Tìm kiếm
                        </button>
                    </div>
                </form>
                <!-- end a line search-->
            </div>
            <div class="col-md-5 text-center pt-4">
                <a href="shopping-cart.jsp" class="btn text-white btn-bg" id="shoppingCart">
                    <i class="fa-solid fa-cart-shopping"></i>&nbsp;Giỏ hàng
                </a>
                <%
                    User user = (User) session.getAttribute("user");
                    if (user == null) {
                %>
                <a href="${pageContext.request.contextPath}/login" class="btn text-white btn-bg" id="loginButton">
                    <i class="fa-solid fa-right-to-bracket"></i>&nbsp;Đăng nhập
                </a>
                <a href="register.jsp" class="btn text-white btn-bg" id="registerButton">
                    <i class="fa-solid fa-pen-to-square"></i>&nbsp;Đăng ký
                </a>
                <%
                    }else {
                %>
                <a href="${pageContext.request.contextPath}/personal" class="btn text-white btn-bg" id="accountButton">
                    <i class="fa-solid fa-user"></i>&nbsp;Cá nhân</a>
                <a href="${pageContext.request.contextPath}/logout-user" class="btn text-white btn-bg"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                <%
                    }
                %>



            </div>
        </div>
    </div>
</div>
<%@include file="link/footLink.jsp"%>


