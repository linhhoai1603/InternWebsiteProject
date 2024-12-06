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
    <title>Các mẫu thiết kế</title>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/design-product.css">
<!-- Content -->
<div class="container-fluid">
    <!-- Vải linen -->
    <div class="row">
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center">Các mẫu thiết kế với vải Linen</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <img
                            src="images/design1.webp"
                            alt=""
                            style="width: 100%; height: 100%"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/design2.webp"
                            alt=""
                            style="width: 100%; height: 100%"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/design3.jpg"
                            alt=""
                            style="width: 100%; height: 100%"
                    />
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <img
                            src="images/design4.webp"
                            alt=""
                            style="width: 100%; height: 100%; margin-top: 10px"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/design5.jpg"
                            alt=""
                            style="width: 100%; height: 100%; margin-top: 10px"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/design6.webp"
                            alt=""
                            style="width: 100%; height: 100%; margin-top: 10px"
                    />
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center">Chi tiết</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div
                            id="carouselExampleControls"
                            class="carousel slide"
                            data-bs-ride="carousel"
                    >
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img
                                        src="images/designSlide.jpg"
                                        class="d-block w-100 h-100"
                                        alt="..."
                                />
                            </div>
                            <div class="carousel-item">
                                <img
                                        src="images/designSlide2.jpg"
                                        class="d-block w-100"
                                        alt="..."
                                />
                            </div>
                            <div class="carousel-item">
                                <img
                                        src="images/designSlide1.jpg"
                                        class="d-block w-100 h-100"
                                        alt="..."
                                />
                            </div>
                        </div>
                        <button
                                class="carousel-control-prev"
                                type="button"
                                data-bs-target="#carouselExampleControls"
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
                                data-bs-target="#carouselExampleControls"
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
            </div>
            <div class="row">
                <div class="col-md-12">
                    <img
                            src="images/design7.jpg"
                            alt=""
                            style="height: 620px; width: 500px"
                    />
                </div>
            </div>
        </div>
    </div>
    <!-- End vải linen -->
    <!-- Vải cotton -->
    <div class="row mt-3 mb-4">
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center">Các mẫu thiết kế với vải Cotton</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <img
                            src="images/design-c1.webp"
                            alt=""
                            style="width: 100%; height: 100%"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/design-c2.webp"
                            alt=""
                            style="width: 100%; height: 100%"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/design-c3.webp"
                            alt=""
                            style="width: 100%; height: 100%"
                    />
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <img
                            src="images/design-c4.webp"
                            alt=""
                            style="width: 100%; height: 100%; margin-top: 10px"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/design-c5.webp"
                            alt=""
                            style="width: 100%; height: 100%; margin-top: 10px"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/design-c6.webp"
                            alt=""
                            style="width: 100%; height: 100%; margin-top: 10px"
                    />
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center">Chi tiết</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div
                            id="carouselExampleControl"
                            class="carousel slide"
                            data-bs-ride="carousel"
                    >
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img
                                        src="images/ds-c1.jpg"
                                        class="d-block w-100 h-100"
                                        alt="..."
                                />
                            </div>
                            <div class="carousel-item">
                                <img
                                        src="images/ds-c2.jpg"
                                        class="d-block w-100"
                                        alt="..."
                                />
                            </div>
                            <div class="carousel-item">
                                <img
                                        src="images/ds-c3.jpg"
                                        class="d-block w-100"
                                        alt="..."
                                />
                            </div>
                        </div>
                        <button
                                class="carousel-control-prev"
                                type="button"
                                data-bs-target="#carouselExampleControl"
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
                                data-bs-target="#carouselExampleControl"
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
            </div>
            <div class="row">
                <div class="col-md-12">
                    <img
                            src="images/ds-c4.jpg"
                            alt=""
                            style="height: 620px; width: 500px"
                    />
                </div>
            </div>
        </div>
    </div>
    <!-- End vải cotton -->
    <!-- Vải nỉ -->
    <div class="row">
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center">Các mẫu thiết kế với vải nỉ</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <img
                            src="images/dl1.jpg"
                            alt=""
                            style="width: 100%; height: 100%"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/dl2.jpg"
                            alt=""
                            style="width: 100%; height: 100%"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/dl3.jpg"
                            alt=""
                            style="width: 100%; height: 100%"
                    />
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <img
                            src="images/dl4.jpg"
                            alt=""
                            style="width: 100%; height: 100%; margin-top: 10px"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/dl5.jpg"
                            alt=""
                            style="width: 100%; height: 100%; margin-top: 10px"
                    />
                </div>
                <div class="col-md-4">
                    <img
                            src="images/dl6.jpg"
                            alt=""
                            style="width: 100%; height: 100%; margin-top: 10px"
                    />
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center">Chi tiết</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div
                            id="carouselExampleControlsNi"
                            class="carousel slide"
                            data-bs-ride="carousel"
                    >
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img
                                        src="images/sl1.jpg"
                                        class="d-block w-100 h-100"
                                        alt="..."
                                />
                            </div>
                            <div class="carousel-item">
                                <img src="images/sl2.jpg" class="d-block w-100" alt="..." />
                            </div>
                            <div class="carousel-item">
                                <img
                                        src="images/sl3.jpg"
                                        class="d-block w-100 h-100"
                                        alt="..."
                                />
                            </div>
                        </div>
                        <button
                                class="carousel-control-prev"
                                type="button"
                                data-bs-target="#carouselExampleControlsNi"
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
                                data-bs-target="#carouselExampleControlsNi"
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
            </div>
            <div class="row">
                <div class="col-md-12">
                    <img
                            src="images/sl4.jpg"
                            alt=""
                            style="height: 620px; width: 500px; margin-top: 10px"
                    />
                </div>
            </div>
        </div>
    </div>
    <!-- End vải nỉ -->
</div>


<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>
