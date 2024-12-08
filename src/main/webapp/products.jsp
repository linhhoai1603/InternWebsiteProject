<%--
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
    <title>Danh mục sản phẩm</title>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/products.css">

<div class="container">
    <div class="col text-end mt-3">
        <div class="mb-3">
            <div class="dropdown">
                <button class="btn btn-primary dropdown-toggle custom-btn" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown">
                    Mới nhất
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item" href="#">Mới nhất</a></li>
                    <li><a class="dropdown-item" href="#">Giá từ thấp đến cao</a></li>
                    <li><a class="dropdown-item" href="#">Giá từ cao đến thấp</a></li>
                    <li><a class="dropdown-item" href="#">Bán chạy</a></li>
                </ul>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-lg-3 d-none d-lg-block">
            <div class="bestseller-title">
                <h6 class="text-light pb-2 ">SẢN PHẨM BÁN CHẠY</h6>
            </div>
            <div class="bestseller-section bg-light p-3 rounded">

                <ul class="list-unstyled">
                    <li class="mb-3 d-flex align-items-start">
                        <img src="images/vaiGamHoaVanLaVang.jpg" alt="Áo sơ mi đen" class="img-fluid me-3" style="width: 50px; height:60px;">
                        <div>
                            <p class="mb-1">Vải gấm hoa văn lá vàng</p>
                            <div class="product-price row">
                                <p class="col text-muted text-decoration-line-through mb-0">469,000đ</p>
                                <p class="col  fw-bold mb-0" style="color: #339C87;">390,000đ</p>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Phần sản phẩm chính (hiển thị trên mọi kích thước màn hình) -->
        <div class="col-lg-9 col-12">
            <div id="content-1" class="content" style="display: block;">
                <div class="row">
                    <div class="col-md-4 col-sm-6 mb-4">
                        <div class="card product-card">
                            <img src="images/vaiGamHongThienPhuc.jpg" class="card-img-top" alt="Áo sơ mi đen">
                            <button class="btn cart-btn">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                            <div class="card-body">
                                <h6 class="card-title">Vải Gấm Hồng Thiên Phúc </h6>
                                <p class="card-text">
                                    <span class="text-muted text-decoration-line-through">469,000đ</span>
                                    <span class="fw-bold" style="color: #339C87;">390,000đ</span>
                                </p>
                                <div class="button-container">
                                    <button class="btn custom-btn me-2">MUA NGAY</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>

        <div class="col">
            <div class="pagination-container">
                <div class="pagination">
                    <button class="page-btn" id="prev-btn">&lt</button>
                    <button class="page-btn" id="page-1">1</button>
                    <button class="page-btn active" id="page-2">2</button>
                    <button class="page-btn" id="next-btn">&gt</button>
                </div>
            </div>
</div>
</div>

<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
<script src="js/products.js"></script>
</body>
</html>