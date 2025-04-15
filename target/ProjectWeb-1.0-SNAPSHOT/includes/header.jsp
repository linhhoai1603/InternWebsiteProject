<!-- filepath: /path/to/header.jsp -->
<%@ page import="models.User" %>
<%@ page import="models.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="includes/css/header.css">
<%@ include file="link/headLink.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>

<div class="container-fluid">
    <div class="row intro text-white bg">
        <div class="col-md-12">
            <p class="text-center"><fmt:message key="intro"/></p>
        </div>
    </div>
    <div class="header">
        <div class="row">
            <div class="col-md-2 text-center">
                <a href="${pageContext.request.contextPath}/home">
                    <img
                            src="images/logo.png"
                            alt="Logo"
                            style="width: 100%; height: 100%"
                    />
                </a>
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
                            <i class="fa-solid fa-magnifying-glass"></i>&nbsp;<fmt:message key="search"/>
                        </button>
                    </div>
                </form>
                <!-- End Search Form -->
            </div>
            <div class="col-md-5 text-center pt-4">
                <%
                    // Kiểm tra xem cart có tồn tại trong session không
                    Cart cart = (Cart) session.getAttribute("cart");
                    int cartCount = 0;
                    if (cart != null) {
                        cartCount = cart.getTotalQuantity(); // Giả sử Cart có phương thức getTotalItems()
                    }
                %>
                <a href="shopping-cart.jsp" class="btn text-white btn-bg position-relative" id="shoppingCart">
                    <i class="fa-solid fa-cart-shopping"></i>&nbsp;<fmt:message key="cart"/>
                    <span class="position-absolute top-0 start-0 translate-middle badge rounded-pill bg-danger cart-count">
                        <%= cartCount %>
                    </span>
                </a>
                <%
                    User user = (User) session.getAttribute("user");
                    if (user == null) {
                %>
                <a href="${pageContext.request.contextPath}/login" class="btn text-white btn-bg" id="loginButton">
                    <i class="fa-solid fa-right-to-bracket"></i>&nbsp;<fmt:message key="login"/>
                </a>
                <a href="register.jsp" class="btn text-white btn-bg" id="registerButton">
                    <i class="fa-solid fa-pen-to-square"></i>&nbsp;<fmt:message key="logout"/>
                </a>
                <%
                } else {
                %>
                <div class="dropdown d-inline-block">
                    <a href="#" class="btn text-white btn-bg dropdown-toggle" id="accountDropdown"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-user"></i>&nbsp;<fmt:message key="user"/>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="accountDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/personal-inf">
                                <fmt:message key="user"/>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/changePassword.jsp">
                                <fmt:message key="changepass"/>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/ordered">
                                <fmt:message key="check"/>
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
                    <i class="fa fa-sign-out-alt"></i>&nbsp;<fmt:message key="logout"/>
                </a>
                <%
                    }
                %>

                <!-- translate -->
                <form action="<c:url value="/ChangeLanguage"/>" method="get" style="display: inline-block;">
                    <select id="langSelect" name="lang" class="form-select me-2" style="width: 100px;"
                            onchange="this.form.submit()">
                        <option value="en" ${sessionScope.lang == 'en' ? 'selected' : ''}>English</option>
                        <option value="vi" ${sessionScope.lang == 'vi' ? 'selected' : ''}>Tiếng Việt</option>
                    </select>
                </form>
                <!-- end translate -->

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