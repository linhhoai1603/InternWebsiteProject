<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 11:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="link/headLink.jsp"%>
<link rel="stylesheet" href="includes/css/navbar.css">
<div class="container-fluid">
    <!-- Navbar for page -->
    <nav class="navbar navbar-expand-lg" style="background-color: #4fd0b6; height: 40px">
        <div class="container-fluid">
            <a class="navbar-item text-white active" href="index.jsp"
               style="text-decoration: none;">Trang chủ</a>
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
                    <li class="nav-item">
                        <div class="dropdown">
                            <a
                                    class="nav-link text-white"
                                    role="button"
                                    id="dropdownMenuLink"
                                    href="products.jsp"
                            >
                                Sản phẩm
                            </a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/may-mac"
                        >Vải may mặc</a
                        >
                        <!-- Updated href -->
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="product-fabric"
                        >Vải nội thất</a
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
                                <a class="dropdown-item" href="button-up.jsp">NÚT ÁO</a>
                            </li>

                            <li><hr class="dropdown-divider" /></li>
                            <li>
                                <a class="dropdown-item" href="zipstar-product.jsp">DÂY KÉO</a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="design-product.jsp"
                        >Các mẫu thiết kế</a
                        >
                        <!-- Updated href -->
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="contact.jsp">Liên hệ</a>
                        <!-- Updated href -->
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="police-return.jsp"
                        >Chính sách đổi trả</a
                        >
                        <!-- Updated href -->
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!--end navbar for page-->
</div>
<%@include file="link/footLink.jsp"%>
