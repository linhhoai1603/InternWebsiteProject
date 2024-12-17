<%--
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
                       <div class="col-6 mb-4 category-item" onclick="window.location.href='product-fabric?option=4'" style="cursor: pointer;">
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
                    <button class="btn-buy mt-2">Xem ngay</button>
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
                    <div class="col-md-3 mb-4">
                        <div class="product-card" onclick="showDetailProduct()">
                            <img src="images/vailuacaocap.jpg" alt="Vải Lụa" class="img-fluid">
                            <div class="product-title">Vải Lụa Cao Cấp</div>
                            <div class="product-squares d-flex justify-content-between mt-2">
                                <div class="square square-white" style="background-image: url('images/luacctrang.jpg');" data-img="images/luacctrang.jpg"></div>
                                <div class="square square-black" style="background-image: url('images/luaccden.jpg');" data-img="images/luaccden.jpg"></div>
                                <div class="square square-pink" style="background-image: url('images/luaccpink.jpg');" data-img="images/luaccpink.jpg"></div>
                                <div class="square square-blue" style="background-image: url('images/luaccblue.jpg');" data-img="images/luaccblue.jpg"></div>
                            </div>
                            <div class="product-old-price">469,000₫</div>
                            <div class="product-price">390,000₫</div>
                            <div class="product-discount">-17%</div>
                            <button class="btn-buy">MUA NGAY</button>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="product-card" onclick="showDetailProduct()">
                            <img src="images/vaicotton.jpg" alt="Vải Cotton" class="img-fluid">
                            <div class="product-title">Vải Cotton Chất Lượng Cao</div>
                            <div class="product-squares d-flex justify-content-between mt-2">
                                <div class="square square-white" style="background-image: url('images/vaicotton1.jpg');" data-img="images/vaicotton1.jpg"></div>
                                <div class="square square-black" style="background-image: url('images/vaicottonblack.jpg');" data-img="images/vaicottonblack.jpg"></div>
                                <div class="square square-pink" style="background-image: url('images/vaicottonpink.jpg');" data-img="images/vaicottonpink.jpg"></div>
                                <div class="square square-blue" style="background-image: url('images/vaicottonblue.jpg');" data-img="images/vaicottonblue.jpg"></div>
                            </div>
                            <div class="product-old-price">469,000₫</div>
                            <div class="product-price">390,000₫</div>
                            <div class="product-discount">-17%</div>
                            <button class="btn-buy">MUA NGAY</button>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="product-card" onclick="showDetailProduct()">
                            <img src="images/vaimodal.jpg" alt="Vải Modal" class="img-fluid">
                            <div class="product-title">Vải Modal Mềm Mại</div>
                            <div class="product-squares d-flex justify-content-between mt-2">
                                <div class="square square-white" style="background-image: url('images/vaimodaltrang.jpg');" data-img="images/vaimodaltrang.jpg"></div>
                                <div class="square square-black" style="background-image: url('images/vaimodalden.jpg');" data-img="images/vaimodalden.jpg"></div>
                                <div class="square square-pink" style="background-image: url('images/vaimodalpink.jpg');" data-img="images/vaimodalpink.jpg"></div>
                                <div class="square square-blue" style="background-image: url('images/vaimodalblue.jpg');" data-img="images/vaimodalblue.jpg"></div>
                            </div>
                            <div class="product-old-price">469,000₫</div>
                            <div class="product-price">390,000₫</div>
                            <div class="product-discount">-17%</div>
                            <button class="btn-buy">MUA NGAY</button>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="product-card" onclick="showDetailProduct()">
                            <img src="images/vaikakicc.jpg" alt="Vải Kaki" class="img-fluid">
                            <div class="product-title">Vải Kaki Chắc Chắn</div>
                            <div class="product-squares d-flex justify-content-between mt-2">
                                <div class="square square-white" style="background-image: url('images/vaikakitrang.jpg');" data-img="images/vaikakitrang.jpg"></div>
                                <div class="square square-black" style="background-image: url('images/vaikakiden.jpg');" data-img="images/vaikakiden.jpg"></div>
                                <div class="square square-pink" style="background-image: url('images/vaikakihong.jpg');" data-img="images/vaikakihong.jpg"></div>
                                <div class="square square-blue" style="background-image: url('images/vaikakiblue.jpg');" data-img="images/vaikakiblue.jpg"></div>
                            </div>
                            <div class="product-old-price">469,000₫</div>
                            <div class="product-price">390,000₫</div>
                            <div class="product-discount">-17%</div>
                            <button class="btn-buy">MUA NGAY</button>
                        </div>
                    </div>

                    <!-- Các sản phẩm khác -->
                    <div class="col-md-3 mb-4">
                        <div class="product-card" onclick="showDetailProduct()">
                            <img src="images/vaimuahe.jpg" alt="Vải Đặc Biệt" class="img-fluid">
                            <div class="product-title">Vải Đặc Biệt Cho Mùa Hè</div>
                            <div class="product-squares d-flex justify-content-between mt-2">
                                <div class="square square-white" style="background-image: url('images/vaimuahetrang.jpg');" data-img="images/vaimuahetrang.jpg"></div>
                                <div class="square square-black" style="background-image: url('images/vaimuaheden.jpg');" data-img="images/vaimuaheden.jpg"></div>
                                <div class="square square-pink" style="background-image: url('images/vaimuahehong.jpg');" data-img="images/vaimuahehong.jpg"></div>
                                <div class="square square-blue" style="background-image: url('images/vaimuahexanhnuocbien.jpg');" data-img="images/vaimuahexanhnuocbien.jpg"></div>
                            </div>
                            <div class="product-old-price">429,000₫</div>
                            <div class="product-price">366,000₫</div>
                            <div class="product-discount">-15%</div>
                            <button class="btn-buy">MUA NGAY</button>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="product-card" onclick="showDetailProduct()">
                            <img src="images/vaimayaosomi.jpg" alt="Vải Cao Cấp" class="img-fluid">
                            <div class="product-title">Vải Cao Cấp Cho Áo Sơ Mi</div>
                            <div class="product-squares d-flex justify-content-between mt-2">
                                <div class="square square-white" style="background-image: url('images/vaisomitrang.jpg');" data-img="images/vaisomitrang.jpg"></div>
                                <div class="square square-black" style="background-image: url('images/vaisominam.jpg');" data-img="images/vaisominam.jpg"></div>
                                <div class="square square-pink" style="background-image: url('images/vaisominamhong.jpg');" data-img="images/vaisominamhong.jpg"></div>
                                <div class="square square-blue" style="background-image: url('images/vaisominamblue.jpg');" data-img="images/vaisominamblue.jpg"></div>
                            </div>
                            <div class="product-old-price">429,000₫</div>
                            <div class="product-price">366,000₫</div>
                            <div class="product-discount">-15%</div>
                            <button class="btn-buy">MUA NGAY</button>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="product-card" onclick="showDetailProduct()">
                            <img src="images/vaithoitrang.jpg" alt="Vải Thời Trang" class="img-fluid">
                            <div class="product-title">Vải Thời Trang Đẹp</div>
                            <div class="product-squares d-flex justify-content-between mt-2">
                                <div class="square square-white" style="background-image: url('images/vaifashionwhite.jpg');" data-img="images/vaifashionwhite.jpg"></div>
                                <div class="square square-black" style="background-image: url('images/vaithoitrangden.jpg');" data-img="images/vaithoitrangden.jpg'"></div>
                                <div class="square square-pink" style="background-image: url('images/vaithoitranghong.jpg');" data-img="images/vaithoitranghong.jpg"></div>
                                <div class="square square-blue" style="background-image: url('images/vaithoitrangmauxanh.jpg');" data-img="images/vaithoitrangmauxanh.jpg"></div>
                            </div>
                            <div class="product-old-price">429,000₫</div>
                            <div class="product-price">366,000₫</div>
                            <div class="product-discount">-15%</div>
                            <button class="btn-buy">MUA NGAY</button>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="product-card" onclick="showDetailProduct()">
                            <img src="images/vaidaydumausac.jpg" alt="Vải Đầy Đủ Màu Sắc" class="img-fluid">
                            <div class="product-title">Vải Đầy Đủ Màu Sắc</div>
                            <div class="product-squares d-flex justify-content-between mt-2">
                                <div class="square square-white" style="background-image: url('images/vaisacmautrang.jpg');" data-img="images/vaisacmautrang.jpg"></div>
                                <div class="square square-black" style="background-image: url('images/vaisacmauden.jpg');" data-img="images/vaisacmauden.jpg"></div>
                                <div class="square square-pink" style="background-image: url('images/vaisacmauhong.jpg');" data-img="images/vaisacmauhong.jpg"></div>
                                <div class="square square-blue" style="background-image: url('images/vaisacmauxanh.jpg');" data-img="images/vaisacmauxanh.jpg"></div>
                            </div>
                            <div class="product-old-price">429,000₫</div>
                            <div class="product-price">366,000₫</div>
                            <div class="product-discount">-15%</div>
                            <button class="btn-buy">MUA NGAY</button>
                        </div>
                    </div>
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
            <div class="col-md-3">
                <div class="product-card" onclick="showDetailProduct()">
                    <img src="images/vailuacaocap2.jpg" alt="Vải Lụa" class="img-fluid">
                    <div class="product-title">Vải Lụa Cao Cấp</div>
                    <div class="product-squares d-flex justify-content-between mt-2">
                        <div class="square square-white" style="background-image: url('images/luacctrang.jpg');" data-img="images/luacctrang.jpg"></div>
                        <div class="square square-black" style="background-image: url('images/luaccden.jpg');" data-img="images/luaccden.jpg"></div>
                        <div class="square square-pink" style="background-image: url('images/luaccpink.jpg');" data-img="images/luaccpink.jpg"></div>
                        <div class="square square-blue" style="background-image: url('images/luaccblue.jpg');" data-img="images/luaccblue.jpg"></div>
                    </div>
                    <div class="product-old-price">259,000₫</div>
                    <div class="product-price">219,000₫</div>
                    <div class="product-discount">-15%</div>
                    <button class="btn-buy">MUA NGAY</button>
                </div>
            </div>
            <div class="col-md-3">
                <div class="product-card" onclick="showDetailProduct()">
                    <img src="images/vaicotton2.jpg" alt="Vải Cotton" class="img-fluid">
                    <div class="product-title">Vải Cotton Chất Lượng</div>
                    <div class="product-squares d-flex justify-content-between mt-2">
                        <div class="square square-white" style="background-image: url('images/vaicottonChatluongWhite.jpg');" data-img="images/vaicottonChatluongWhite.jpg"></div>
                        <div class="square square-black" style="background-image: url('images/vaicotton2.jpg');" data-img="images/vaicotton2.jpg"></div>
                        <div class="square square-pink" style="background-image: url('images/vaicotton3.jpg');" data-img="images/vaicotton3.jpg"></div>
                        <div class="square square-blue" style="background-image: url('images/vaicottonclmauxanh.jpg');" data-img="images/vaicottonclmauxanh.jpg"></div>
                    </div>
                    <div class="product-old-price">259,000₫</div>
                    <div class="product-price">219,000₫</div>
                    <div class="product-discount">-15%</div>
                    <button class="btn-buy">MUA NGAY</button>
                </div>
            </div>
            <div class="col-md-3">
                <div class="product-card" onclick="showDetailProduct()">
                    <img src="images/vaimodal.jpg" alt="Vải Modal" class="img-fluid">
                    <div class="product-title">Vải Modal Mềm Mại</div>
                    <div class="product-squares d-flex justify-content-between mt-2">
                        <div class="square square-white" style="background-image: url('images/vaimodaltrangne.jpg');" data-img="images/vaimodaltrangne.jpg"></div>
                        <div class="square square-black" style="background-image: url('images/vaimodal2.jpg');" data-img="images/vaimodal2.jpg"></div>
                        <div class="square square-pink" style="background-image: url('images/vaimodalhongne.jpg');" data-img="images/vaimodalhongne.jpg"></div>
                        <div class="square square-blue" style="background-image: url('images/vaimodaldenne.jpg');" data-img="images/vaimodaldenne.jpg"></div>
                    </div>
                    <div class="product-old-price">259,000₫</div>
                    <div class="product-price">219,000₫</div>
                    <div class="product-discount">-15%</div>
                    <button class="btn-buy">MUA NGAY</button>
                </div>
            </div>
            <div class="col-md-3">
                <div class="product-card" onclick="showDetailProduct()">
                    <img src="images/vaikakicc.jpg" alt="Vải Kaki" class="img-fluid">
                    <div class="product-title">Vải Kaki Chắc Chắn</div>
                    <div class="product-squares d-flex justify-content-between mt-2">
                        <div class="square square-white" style="background-image: url('images/vaikakitrang.jpg');" data-img="images/vaikakitrang.jpg"></div>
                        <div class="square square-black" style="background-image: url('images/vaikakidenne.jpg');" data-img="images/vaikakidenne.jpg"></div>
                        <div class="square square-pink" style="background-image: url('images/vaikakihongne.jpg');" data-img="images/vaikakihongne.jpg"></div>
                        <div class="square square-blue" style="background-image: url('images/vaikakixanhne.jpg');" data-img="images/vaikakixanhne.jpg"></div>
                    </div>
                    <div class="product-old-price">249,000₫</div>
                    <div class="product-price">199,000₫</div>
                    <div class="product-discount">-20%</div>
                    <button class="btn-buy">MUA NGAY</button>
                </div>
            </div>
        </div>

    </div>



    <div class="container">
        <div class="row">
            <div class="col-md-4 product-list mt-5">
                <h5>SẢN PHẨM BÁN CHẠY</h5>
                <div class="best-sellers">
                    <div class="product-item d-flex align-items-center mb-3">
                        <img alt="Vải cotton cao cấp - Trắng" height="80" src="images/vaicaocaptrang.jpg" width="80" class="product-image"/>
                        <div class="ms-3 product-info">
                            <div class="product-title">Vải cotton cao cấp - Trắng</div>
                            <div class="product-prices">
                                <del class="old-price">469,000₫</del>
                                <span class="price">390,000₫</span>
                            </div>
                        </div>
                    </div>

                    <div class="product-item d-flex align-items-center mb-3 h-30">
                        <img alt="Vải lanh thoáng khí - Xanh nhạt" height="80" src="images/vailanhthoangkhi.jpg" width="80" class="product-image"/>
                        <div class="ms-3 product-info">
                            <div class="product-title">Vải lanh thoáng khí - Xanh nhạt</div>
                            <div class="product-prices">
                                <del class="old-price">469,000₫</del>
                                <span class="price">390,000₫</span>
                            </div>
                        </div>
                    </div>
                    <div class="product-item d-flex align-items-center mb-3">
                        <img alt="Vải polyester chống nhăn - Trắng" height="80" src="images/vaipoly.jpg" width="80" class="product-image"/>
                        <div class="ms-3 product-info">
                            <div class="product-title">Vải polyester chống nhăn - Trắng</div>
                            <div class="product-prices">
                                <del class="old-price">259,000₫</del>
                                <span class="price">219,000₫</span>
                            </div>
                        </div>
                    </div>
                    <div class="product-item d-flex align-items-center mb-3">
                        <img alt="Vải khaki bền đẹp - Camel" height="80" src="images/vaikhaly.jpg" width="80" class="product-image"/>
                        <div class="ms-3 product-info">
                            <div class="product-title">Vải khaki bền đẹp - Camel</div>
                            <div class="product-prices">
                                <del class="old-price">429,000₫</del>
                                <span class="price">366,000₫</span>
                            </div>
                        </div>
                    </div>

                    <div class="product-item d-flex align-items-center mb-3">
                        <img alt="Vải chống thấm nước - Đen" height="80" src="images/vaithamden.jpg" width="80" class="product-image"/>
                        <div class="ms-3 product-info">
                            <div class="product-title">Vải chống thấm nước - Đen</div>
                            <div class="product-prices">
                                <del class="old-price">799,000₫</del>
                                <span class="price">699,000₫</span>
                            </div>
                        </div>
                    </div>

                    <div class="product-item d-flex align-items-center mb-3">
                        <img alt="Vải denim cao cấp - Xanh đậm" height="80" src="images/vaixanhdam.jpg" width="80" class="product-image"/>
                        <div class="ms-3 product-info">
                            <div class="product-title">Vải denim cao cấp - Xanh đậm</div>
                            <div class="product-prices">
                                <del class="old-price">550,000₫</del>
                                <span class="price">495,000₫</span>
                            </div>
                        </div>
                    </div>

                    <div class="product-item d-flex align-items-center mb-3">
                        <img alt="Vải tơ tằm - Hồng" height="80" src="images/vaipink.jpg" width="80" class="product-image"/>
                        <div class="ms-3 product-info">
                            <div class="product-title">Vải tơ tằm - Hồng</div>
                            <div class="product-prices">
                                <del class="old-price">1,200,000₫</del>
                                <span class="price">1,100,000₫</span>
                            </div>
                        </div>
                    </div>


                    <div class="product-item d-flex align-items-center mb-3">
                        <img alt="Vải thun co giãn - Đen" height="80" src="images/vaiblack.jpg" width="80" class="product-image"/>
                        <div class="ms-3 product-info">
                            <div class="product-title">Vải thun co giãn - Đen</div>
                            <div class="product-prices">
                                <del class="old-price">350,000₫</del>
                                <span class="price">315,000₫</span>
                            </div>
                        </div>
                    </div>
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
    <script src="js/content.js"></script>
<%@include file="link/footLink.jsp"%>
