<%@ page import="models.Style" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.StyleDao" %><%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 11:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="link/headLink.jsp"%>
<link rel="stylesheet" href="includes/css/content.css">
<div class="container-fluid" style="margin-top: -350px">
    <div class="container">
        <!-- Sidebar Section -->
        <div class="row">
            <div class="col-md-3 sidebar-section">
                <!-- Category Title -->
                <div class="category-title">
                    NỘI THÁT BÁN CHẠY
                </div>
                <!-- Category Items -->
                <div class="row">
                   <c:forEach var="product" items="${sessionScope.fabricHotSelling}">
                       <!-- sản phẩm -->
                       <div class="col-6 mb-4 category-item" style="cursor: pointer;" onclick="navigateToProduct(${product.id})">
                           <img src="${product.image}" alt="Hình ảnh sản phẩm" class="w-100">
                           <div>${product.name}</div>
                       </div>
                   </c:forEach>
                </div>

                <div class="category-title">
                   SẢN PHẨM VẢI MỚI NHẤT
                </div>
                <!-- Advertisement Section -->

                <div class="category-item mt-3" onclick="showDetailProduct()">
                    <img src="${sessionScope.mostProductNew.image}" alt="Sản phẩm mới nhất">
                    <div>${sessionScope.mostProductNew.name}</div>
                    <button class="btn-buy mt-2"><a href="detail-product?productId=${product.id}"></a> Xem ngay</button>
                </div>
            </div>
            <!-- Main Product Section -->
            <div class="col-md-9">
                <!-- Sale Section -->
                <div class="d-flex justify-content-between align-items-center sale-banner">
                    <div>
                        MAY MẶC BÁN CHẠY
                    </div>
                    <div class="more-link">
                        <a href="#" class="text-white">Xem thêm <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>

                <div class="row">
                    <!-- Thông tin sản phẩm -->
                    <c:forEach var="product" items="${sessionScope.productHotSelling}">
                        <div class="col-md-3 mb-4">
                            <div class="product-card">
                                <!-- Hình ảnh lớn -->
                                <img id="mainImage${product.id}" src="${product.image}" alt="Hình ảnh sản phẩm" class="img-fluid main-image">
                                <!-- Tên sản phẩm -->
                                <div class="product-title">${product.name}</div>
                                <!-- Các style -->
                                <div class="product-squares d-flex justify-content-between mt-2">
                                    <c:forEach var="style" items="${product.styles}">
                                        <div
                                                class="square square-white"
                                                style="background-image: url('${style.image}');"
                                                onmouseover="changeMainImage(${product.id}, '${style.image}')"
                                                onmouseout="restoreMainImage(${product.id}, '${product.image}')">
                                        </div>
                                    </c:forEach>
                                </div>
                                <!-- Thông tin giá -->
                                <div class="product-old-price" data-original-price="${product.price.price}">${product.price.price} VND</div>
                                <div class="product-price" style="font-size: 22px" data-last-price="${product.price.lastPrice}">${product.price.lastPrice}</div>
                                <div class="product-discount" data-discount-percent="${product.price.discountPercent}">${product.price.discountPercent}%</div>

                                <!-- Nút mua -->
                                <button class="btn-buy" onclick="navigateToProduct(${product.id})"> XEM NGAY</button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>


    <!-- Bootstrap Carousel (Full-width below product section) -->
    <div class="container-fluid mt-5">
        <div class="row">
            <div class="col-12">
                <div id="featuredCarousel" class="carousel slide custom-carousel" data-bs-ride="carousel">
                    <!-- Indicators/dots -->
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#featuredCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#featuredCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#featuredCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    </div>

                    <!-- The slideshow/carousel -->
                    <div class="carousel-inner">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="images/qc1.png" alt="Featured Product 1" class="d-block w-100">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Lụa tơ tằm</h5>
                                    <p>Lụa tơ tằm, một loại vải mỏng nhẹ và mịn màng, chủ yếu được làm từ sợi tơ tằm.</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img src="images/qc2.png" alt="Featured Product 2" class="d-block w-100">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Vải Supima Cotton</h5>
                                    <p>Supima là một loại cotton đặc biệt được trồng tại Hoa Kỳ.</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img src="images/qc3.png" alt="Featured Product 3" class="d-block w-100">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Vải Modal</h5>
                                    <p>Vải Modal được sản xuất từ sợi gỗ cây bạch đàn.</p>
                                </div>
                            </div>
                        </div>


                    </div>

                    <!-- Left and right controls/icons -->
                    <button class="carousel-control-prev" type="button" data-bs-target="#featuredCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#featuredCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- End of Carousel -->


    <div class="container mt-4">
        <!-- Sale Section -->
        <div class="d-flex justify-content-between align-items-center sale-banner">
            <p class="text-center">
                SẢN PHẨM SALE LỚN NHẤT
            </p>
        </div>
        <div class="row">
            <!-- Thông tin sản phẩm -->
            <c:forEach var="product" items="${sessionScope.productsMostDiscount}">
                <div class="col-md-3">
                    <div class="product-card" >
                        <!-- Hình ảnh lớn -->
                        <img id="mainImage${product.id}" src="${product.image}" alt="${product.description}" class="img-fluid main-image">
                        <div class="product-title">${product.name}</div>
                        <div class="product-squares d-flex justify-content-between mt-2">
                            <c:forEach var="style" items="${product.styles}">
                                <div
                                        class="square square-white"
                                        style="background-image: url('${style.image}');"
                                        onmouseover="changeMainImage(${product.id}, '${style.image}')"
                                        onmouseout="restoreMainImage(${product.id}, '${product.image}')">
                                </div>
                            </c:forEach>
                        </div>
                        <div class="product-old-price">${product.price.price}₫</div>
                        <div class="product-price"  style="font-size: 22px">${product.price.lastPrice}₫</div>
                        <div class="product-discount">${product.price.discountPercent}₫</div>
                        <button class="btn-buy" onclick="navigateToProduct(${product.id})">XEM NGAY</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-4 product-list mt-5">
                <h5>MỘT SỐ SẢN PHẨM MỚI</h5>
                <div class="best-sellers">
                <!-- Thông tin sản phẩm -->
                    <c:forEach var="product" items="${sessionScope.mostProductsNew}">
                        <div class="product-item d-flex align-items-center mb-3" onclick="navigateToProduct(${product.id})">
                            <img alt="${product.description}" height="80" src="${product.image}" width="80" class="product-image"/>
                            <div class="ms-3 product-info">
                                <div class="product-title">${product.name}</div>
                                <div class="product-prices">
                                    <del class="old-price product-old-price">${product.price.price}đ</del>
                                    <span class="price product-price">${product.price.lastPrice}đ</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>


            <div class="col-md-8 commitment-section mt-4">
                <h3>Cam Kết 100% Hài Lòng</h3>
                <div class="user-images">
                    <div class="commitment-item">
                        <div class="flex-container">
                            <img alt="Person in black t-shirt" src="images/user1.png" />
                            <div class="commitment-info">
                                <div class="stars">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <p>
                                    Sản phẩm rất ưng ý. Đóng gói chuyên nghiệp. Một người mua hàng thông thái, không chỉ cần 1 sp (sản phẩm) chất lượng...
                                </p>
                                <div class="manager"><strong>Nguyễn Thế Anh</strong> / Manager</div>
                            </div>
                        </div>
                    </div>

                    <div class="commitment-item">
                        <div class="flex-container">
                            <img alt="Person in blue shirt" src="images/user2.png" />
                            <div class="commitment-info">
                                <div class="stars">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <p>
                                    Sản phẩm rất ưng ý. Đóng gói chuyên nghiệp. Một người mua hàng thông thái, không chỉ cần 1 sp (sản phẩm) chất lượng...
                                </p>
                                <div class="manager"><strong>Nguyễn Văn An</strong> / Manager</div>
                            </div>
                        </div>
                    </div>
                </div>


                <h3>Cam Kết 100% Hài Lòng</h3>
                <div class="accordion" id="accordionExample">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button aria-controls="collapseOne" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseOne" data-bs-toggle="collapse" type="button">
                                01. Liên hệ Chăm sóc khách hàng dễ dàng
                            </button>
                        </h2>
                        <div aria-labelledby="headingOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseOne">
                            <div class="accordion-body">
                                Liên hệ Chăm sóc khách hàng dễ dàng
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingTwo">
                            <button aria-controls="collapseTwo" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseTwo" data-bs-toggle="collapse" type="button">
                                02. Thời gian trao đổi với các bạn tổng đài viên là không hạn chế
                            </button>
                        </h2>
                        <div aria-labelledby="headingTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseTwo">
                            <div class="accordion-body">
                                Thời gian trao đổi với các bạn tổng đài viên là không hạn chế
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingThree">
                            <button aria-controls="collapseThree" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseThree" data-bs-toggle="collapse" type="button">
                                03. Văn hóa say YES trong xử lý tình huống
                            </button>
                        </h2>
                        <div aria-labelledby="headingThree" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseThree">
                            <div class="accordion-body">
                                Văn hóa say YES trong xử lý tình huống
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingFour">
                            <button aria-controls="collapseFour" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseFour" data-bs-toggle="collapse" type="button">
                                04. Sự tương tác mang tính cá nhân hóa
                            </button>
                        </h2>
                        <div aria-labelledby="headingFour" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseFour">
                            <div class="accordion-body">
                                Sự tương tác mang tính cá nhân hóa
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingFive">
                            <button aria-controls="collapseFive" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseFive" data-bs-toggle="collapse" type="button">
                                05. CSKH hoạt động 13,5h/1 ngày và 7 ngày/1 tuần
                            </button>
                        </h2>
                        <div aria-labelledby="headingFive" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseFive">
                            <div class="accordion-body">
                                CSKH hoạt động 13,5h/1 ngày và 7 ngày/1 tuần
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingSix">
                            <button aria-controls="collapseSix" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseSix" data-bs-toggle="collapse" type="button">
                                06. Dịch vụ đổi trả miễn phí 60 ngày với BẤT CỨ LÝ DO Gì
                            </button>
                        </h2>
                        <div aria-labelledby="headingSix" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseSix">
                            <div class="accordion-body">
                                Dịch vụ đổi trả miễn phí 60 ngày với BẤT CỨ LÝ DO Gì
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingSeven">
                            <button aria-controls="collapseSeven" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseSeven" data-bs-toggle="collapse" type="button">
                                07. Dịch vụ đổi trả tận nơi của Fashion
                            </button>
                        </h2>
                        <div aria-labelledby="headingSeven" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseSeven">
                            <div class="accordion-body">
                                Dịch vụ đổi trả tận nơi của Fashion
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingEight">
                            <button aria-controls="collapseEight" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseEight" data-bs-toggle="collapse" type="button">
                                08. Trả hàng hoàn tiền và có bưu tá lấy hàng tận nơi
                            </button>
                        </h2>
                        <div aria-labelledby="headingEight" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseEight">
                            <div class="accordion-body">
                                Trả hàng hoàn tiền và có bưu tá lấy hàng tận nơi
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingNine">
                            <button aria-controls="collapseNine" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseNine" data-bs-toggle="collapse" type="button">
                                09. Giao hàng nhanh mà không thu thêm phí
                            </button>
                        </h2>
                        <div aria-labelledby="headingNine" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseNine">
                            <div class="accordion-body">
                                Giao hàng nhanh mà không thu thêm phí
                            </div>
                        </div>
                    </div>
                    <!-- Mục mới thêm vào -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingTen">
                            <button aria-controls="collapseTen" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseTen" data-bs-toggle="collapse" type="button">
                                10. Hỗ trợ kỹ thuật 24/7
                            </button>
                        </h2>
                        <div aria-labelledby="headingTen" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseTen">
                            <div class="accordion-body">
                                Chúng tôi cung cấp hỗ trợ kỹ thuật 24/7 để giải quyết mọi vấn đề của khách hàng.
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingEleven">
                            <button aria-controls="collapseEleven" aria-expanded="false" class="accordion-button collapsed" data-bs-target="#collapseEleven" data-bs-toggle="collapse" type="button">
                                11. Đảm bảo sản phẩm chất lượng
                            </button>
                        </h2>
                        <div aria-labelledby="headingEleven" class="accordion-collapse collapse" data-bs-parent="#accordionExample" id="collapseEleven">
                            <div class="accordion-body">
                                Chúng tôi cam kết cung cấp sản phẩm chất lượng cao nhất cho khách hàng.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="includes/js/content.js"></script>

<%@include file="link/footLink.jsp"%>
