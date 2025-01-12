<!-- filepath: /path/to/header.jsp -->
<%@ page import="models.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="includes/css/header.css">
<%@ include file="link/headLink.jsp" %>

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
                        alt="Logo"
                        style="width: 100%; height: 100%"
                />
            </div>
            <div class="col-md-5 text-center pt-4">
                <!-- Search Form -->
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
                <!-- End Search Form -->
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
                } else {
                %>
                <div class="dropdown d-inline-block">
                    <a href="#" class="btn text-white btn-bg dropdown-toggle" id="accountDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-user"></i>&nbsp;Cá nhân
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="accountDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/personal-inf">
                                Hồ sơ
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/changePassword.jsp">
                                Thay đổi mật khẩu
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/ordered">
                                Đơn hàng đã mua
                            </a>
                        </li>
                        <c:if test="${sessionScope.account.role == 1}">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                                    Dashboard
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <a href="${pageContext.request.contextPath}/logout-user" class="btn text-white btn-bg">
                    <i class="fa fa-sign-out-alt"></i>&nbsp;Đăng xuất
                </a>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>

<%@ include file="link/footLink.jsp" %>

<!-- CSS cho Dropdown -->
<style>
    /* Hiển thị dropdown khi rê chuột */
    .dropdown:hover .dropdown-menu {
        display: block;
    }

    .dropdown-menu {
        margin-top: 0; /* Điều chỉnh khoảng cách nếu cần */
    }
</style>