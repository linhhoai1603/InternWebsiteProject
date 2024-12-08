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
    <title>Chi tiết sản phẩm</title>

</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/detail-product.css">

<div class="container mt-3">
    <div class="row">
        <!-- Image Carousel Section -->
        <div class="col-md-6">
            <div
                    id="productCarousel"
                    class="carousel slide"
                    data-bs-ride="carousel"
            >
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img
                                src="images/vaiGamHoaVanXanh.jpg"
                                class="d-block w-100"
                                alt="Product Image 1"
                        />
                    </div>
                    <div class="carousel-item">
                        <img
                                src="images/vaiGamHongThienPhuc.jpg"
                                class="d-block w-100"
                                alt="Product Image 2"
                        />
                    </div>
                    <div class="carousel-item">
                        <img
                                src="images/vaiGamLucThienPhuc.jpg"
                                class="d-block w-100"
                                alt="Product Image 3"
                        />
                    </div>
                </div>
                <button
                        class="carousel-control-prev"
                        type="button"
                        data-bs-target="#productCarousel"
                        data-bs-slide="prev"
                >
                    <span
                            class="carousel-control-prev-icon"
                            aria-hidden="true"
                    ></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button
                        class="carousel-control-next"
                        type="button"
                        data-bs-target="#productCarousel"
                        data-bs-slide="next"
                >
                    <span
                            class="carousel-control-next-icon"
                            aria-hidden="true"
                    ></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>

        <!-- Product Details Section -->
        <div class="col-md-6">
            <h3 class="text" style="color: #008080">
                Áo sơ mi nam dài tay Café-DriS khử mùi
            </h3>
            <p class="h4 text-decoration-line-through text-warning">600,000đ</p>
            <p class="h2 text-danger fw-bold">
                390,000₫
            </p>

            <!-- Màu sắc -->
            <div class="mb-3">
                <p class="fw-bold">Kiểu vải </p>
                <div class="d-flex gap-2">
                    <img
                            src="images/vaiDoChamHoaXanh.jpg"
                            alt="Color 1"
                            class="color-option border rounded"
                            data-color="vaiDoChamHoaXanh"
                            style="width: 40px; height: 40px"
                    />
                    <img
                            src="images/vaiGamHoaVanLaVang.jpg"
                            alt="Color 2"
                            class="color-option border rounded"
                            data-color="vaiGamHoaVanLaVang"
                            style="width: 40px; height: 40px"
                    />
                    <img
                            src="images/vaiGamHoaVanTim.webp"
                            alt="Color 3"
                            class="color-option border rounded"
                            data-color="vaiGamHoaVanTim"
                            style="width: 40px; height: 40px"
                    />
                    <img
                            src="images/vaiGamHoaVanTrang.webp"
                            alt="Color 4"
                            class="color-option border rounded"
                            data-color="vaiGamHoaVanTrang"
                            style="width: 40px; height: 40px"
                    />
                </div>
            </div>

            <!-- Size Options -->
            <div class="mb-3">
                <p class="fw-bold">Size</p>
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-outline-secondary size-option">2m<sup>2</sup></button>
                    <button type="button" class="btn btn-outline-secondary size-option" >3m<sup>2</sup></button>
                    <button type="button" class="btn btn-outline-secondary size-option" >4m<sup>2</sup></button>
                    <button type="button" class="btn btn-outline-secondary size-option" >5m<sup>2</sup></button>
                </div>
            </div>

            <!-- Form to Submit Data -->
            <form action="/checkout" method="POST">
                <!-- Color and Size Hidden Fields -->
                <input type="hidden" name="selected_color" id="selected_color" value="" />
                <input type="hidden" name="selected_size" id="selected_size" value="" />

                <!-- Quantity and Add to Cart Button -->
                <div class="row">
                    <div class="col-3">
                        <div class="input-group">
                            <button class="btn btn-outline-secondary" type="button">-</button>
                            <input type="text" class="form-control text-center" value="1" style="max-width: 50px" />
                            <button class="btn btn-outline-secondary" type="button">+</button>
                        </div>
                    </div>
                    <button type="submit" class="col-3 btn btn-custom w-10 mb-2" style="background-color: #339c87">
                        THÊM VÀO GIỎ
                    </button>
                </div>

                <button type="submit" class="btn btn-custom w-100" style="background-color: #339c87">
                    MUA NGAY
                </button>
            </form>

            <!-- Shipping Information -->
            <div class="alert alert-light mt-3" role="alert">
                <i class="bi bi-truck"></i>
                Giao hàng: Miễn phí giao hàng toàn quốc với đơn hàng > 400k hoặc mua 3 sản phẩm bất kỳ.
            </div>
        </div>
    </div>
</div>

<div class="container my-5">
    <div class="row">
        <!-- Product Description Section -->
        <div class="col-12">
            <div class="col-12 d-flex align-items-center">
                <div class="title-box px-3 py-2 text-white" style="background-color: #008080">
                    <h5 class="mb-0">MÔ TẢ SẢN PHẨM</h5>
                </div>
            </div>
            <p>Đây sẽ là chiếc áo đầu tiên trong tủ đồ của bạn với chất liệu bền vững và thân thiện với môi trường!</p>
        </div>
    </div>
    <div class="container">
        <img src="images/poster.png" alt="Poster" class="img-fluid" />
    </div>
</div>

<script src="js/detail-product.js"></script>
<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>