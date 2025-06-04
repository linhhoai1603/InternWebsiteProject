<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 11:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="link/headLink.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<link rel="stylesheet" href="includes/css/navbar.css">

<div class="container-fluid">
    <!-- Navbar for page -->
    <nav class="navbar navbar-expand-lg" style="background-color: #4fd0b6; height: 40px">
        <div class="container-fluid">
            <a class="navbar-item text-white active" href="index.jsp"
               style="text-decoration: none;"><fmt:message key="index"/></a>
            <!-- Updated href -->
            <button
                    class="navbar-toggler"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarNav"
                    aria-controls="navbarNav"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
            >
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item dropdown" >
                        <a
                                class="nav-link text-white dropdown-toggle"
                                role="button"
                                id="productDropdown"
                                href="${pageContext.request.contextPath}/total-product"
                                data-bs-toggle="dropdown"
                                aria-expanded="false"
                        >
                            <fmt:message key="pro"/>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="productDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/total-product?selection=1"><fmt:message key="vmm"/></a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/total-product?selection=2"><fmt:message key="vnt"/></a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/total-product?selection=3"><fmt:message key="na"/></a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/total-product?selection=4"><fmt:message key="dk"/></a></li>
                        </ul>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/may-mac"
                        ><fmt:message key="vmm"/></a
                        >
                        <!-- Updated href -->
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="product-fabric"
                        ><fmt:message key="vnt"/></a
                        >
                        <!-- Updated href -->
                    </li>
                    <li class="nav-item dropdown">
                        <a
                                class="nav-link dropdown-toggle text-white"
                                href="#"
                                id="accessoryDropdown"
                                role="button"
                                data-bs-toggle="dropdown"
                                aria-expanded="false"
                        >
                            Phụ kiện may mặc
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="accessoryDropdown">
                            <li>
                                <a class="dropdown-item" href="button-up.jsp"><fmt:message key="na"/></a>
                            </li>

                            <li><hr class="dropdown-divider" /></li>
                            <li>
                                <a class="dropdown-item" href="zipstar-product.jsp"><fmt:message key="dk"/></a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="design-product.jsp"
                        ><fmt:message key="cmtk"/></a
                        >
                        <!-- Updated href -->
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="contact.jsp"><fmt:message key="lh"/></a>
                        <!-- Updated href -->
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="police-return.jsp"
                        ><fmt:message key="csdt"/></a
                        >
                        <!-- Updated href -->
                    </li>
                </ul>
            </div>

        </div>
</nav>
<script>
    let lastScrollTop = 0;
    const navbar = document.querySelector(".navbar");
    const header = document.querySelector("header"); // Giả sử header là phần trên navbar

    window.addEventListener("scroll", function () {
        let scrollTop = window.scrollY || document.documentElement.scrollTop;

        if (scrollTop === 0) {
            // Nếu quay lại đầu trang -> Đặt navbar về dưới header
            navbar.style.position = "relative";
            navbar.style.top = "0";
        } else if (scrollTop > lastScrollTop) {
            // Nếu cuộn xuống -> Giữ navbar cố định trên màn hình
            navbar.style.position = "fixed";
            navbar.style.top = "0";
            navbar.style.width = "100%";
            navbar.style.transition = "top 0.3s";
        } else {
            // Nếu cuộn lên -> Ẩn navbar
            navbar.style.top = "-60px";
        }

        lastScrollTop = scrollTop;
    });

</script>
<%@include file="link/footLink.jsp" %>
