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
                                    class="nav-link dropdown-toggle text-white"
                                    role="button"
                                    id="dropdownMenuLink"
                                    href="products.jsp"
                            >
                                Sản phẩm
                            </a>
                            <ul
                                    class="dropdown-menu custom-dropdown"
                                    aria-labelledby="dropdownMenuLink"
                            >
                                <div class="dropdown-item">
                                    <div class="container">
                                        <div class="row h-50">
                                            <div class="col-md-3">
                                                <div class="card">
                                                    <img
                                                            src="https://th.bing.com/th/id/OIP.OprMkiqtc3Lnf5vyMtfSdQHaHa?w=1200&h=1200&rs=1&pid=ImgDetMain"
                                                            class="card-img-top"
                                                            alt="..."
                                                    />
                                                    <div class="card-body">
                                                        <h4
                                                                class="card-title"
                                                                style="text-align: center"
                                                        >
                                                            Vải lụa
                                                        </h4>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="card">
                                                    <img
                                                            src="https://file.hstatic.net/1000361985/article/vai-kaki-la-gi_e7480b5129684cea950712b3e91e8a80.jpg"
                                                            class="card-img-top"
                                                            alt="..."
                                                    />
                                                    <div class="card-body">
                                                        <h4
                                                                class="card-title"
                                                                style="text-align: center"
                                                        >
                                                            Vải kaki
                                                        </h4>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="card">
                                                    <img
                                                            src="https://cuahangnoithat.vn/sites/default/files/tu-van/vai-nhung-thuong-mem-mai-va-co-do-bong-cao.jpg"
                                                            class="card-img-top"
                                                            alt="..."
                                                    />
                                                    <div class="card-body">
                                                        <h4
                                                                class="card-title"
                                                                style="text-align: center"
                                                        >
                                                            Vải nhung
                                                        </h4>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="card">
                                                    <img
                                                            src="https://th.bing.com/th/id/OIP.Q4mxQDdT9Wy7Zu89L3z8VwHaHa?rs=1&pid=ImgDetMain"
                                                            class="card-img-top"
                                                            alt="..."
                                                    />
                                                    <div class="card-body">
                                                        <h4
                                                                class="card-title"
                                                                style="text-align: center"
                                                        >
                                                            Vải Linen
                                                        </h4>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="garment-product.jsp"
                        >Vải may mặc</a
                        >
                        <!-- Updated href -->
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="fabric-product.jsp"
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
