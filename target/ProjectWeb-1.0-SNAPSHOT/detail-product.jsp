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
<style>
    .color-option {
        border-radius : 15% 2px;
        transition: border 0.3s, transform 0.3s; /* Hiệu ứng chuyển động mượt */
        cursor: pointer; /* Thay đổi con trỏ khi hover */
    }

    /* Khi ảnh được chọn */
    .color-option.selected-style  {
        border: 4px solid #339C87; /* Viền màu xanh lá */
        transform: scale(1.1); /* Phóng to nhẹ ảnh khi chọn */
    }

    /* Hiệu ứng hover cho tất cả ảnh */
    .color-option:hover {
        transform: scale(1.05); /* Phóng to nhẹ khi hover */
        border-color: #aaa; /* Đổi viền khi hover */
    }
    /* Ẩn spinner trên Chrome, Edge, Safari */
    input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    /* Ẩn spinner trên Firefox */
    input[type="number"] {
        -moz-appearance: textfield;
    }


</style>
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
                    <c:forEach var="style" items="${product.styles}">
                    <div class="carousel-item active">
                        <img
                                src="${style.image}"
                                class="d-block w-100"
                                alt="${style.name}"
                                style="width: 300px; height: 500px; object-fit: cover;"
                        />

                    </div>
                    </c:forEach>
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
            <h1 class="text" style="color: #008080">
                ${requestScope.product.name}
            </h1>
            <p class="h4 text-decoration-line-through text-warning"><fmt:formatNumber value="${product.price.price}" type="number" />₫</p>
            <p class="h2 text-danger fw-bold">
                <fmt:formatNumber value="${product.price.lastPrice}" type="number" />₫
            </p>

            <!-- Màu sắc -->
            <div class="mb-3">
                <p class="fw-bold">Màu sắc</p>
                <div class="d-flex gap-2">
                    <c:forEach var="style" items="${product.styles}">
                        <img
                                src="${style.image}"
                                alt="${style.name}"
                                class="color-option"
                                style="width: 60px; height: 60px; cursor: pointer;"
                                data-style-id="${style.id}"
                        />
                    </c:forEach>
                </div>
            </div>


            <form action="cart?method=add" method="post">
                <input name="currentURL" type="hidden" value="detail-product?productId=${requestScope.product.id}">
                <input type="hidden" name="selectedStyle" id="selectedStyle" value="">

                <!-- Quantity and Add to Cart Button -->
                <div class="row">
                    <div class="col-3">
                        <div class="input-group">
                            <button class="btn btn-outline-secondary decrement-btn" type="button">-</button>
                            <input type="number" name="quantity" class="form-control text-center quantity-input" value="1" style="max-width: 50px" min="1">
                            <button class="btn btn-outline-secondary increment-btn" type="button">+</button>
                        </div>
                    </div>
                    <button type="submit" class="col-3 btn btn-custom w-10 mb-2" style="background-color: #339c87">
                        THÊM VÀO GIỎ
                    </button>
                </div>
            </form>
            <form action="cart?method=add" method="post">
                <input name="currentURL" type="hidden" value="shopping-cart.jsp">
                <input type="hidden" name="selectedStyle" id="selectedStyle1" value="">
                <input type="hidden" name="quantity" class="form-control text-center quantity-input" value="1" style="max-width: 50px" min="1">
                <button type="submit" class="btn btn-custom w-100" style="background-color: #339c87">
                    MUA NGAY
                </button>
            </form>

            <!-- Shipping Information -->
            <div class="alert alert-light mt-3" role="alert">
                <i class="bi bi-truck"></i>
                Giao hàng: Miễn phí giao hàng khi mua từ 10 sản phẩm trở lên (Trong đó có trên 5 sản phẩm vải)
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
            <p>${requestScope.product.description}</p>
            <p>${requestScope.product.technicalInfo.specification}</p>
        </div>
    </div>
    <div class="container">
        <img src="images/poster.png" alt="Poster" class="img-fluid" />
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const colorOptions = document.querySelectorAll('.color-option');
        const selectedStyleInput = document.getElementById('selectedStyle');
        const selectedStyleInput1 = document.getElementById('selectedStyle1');
        // Khởi tạo giá trị ban đầu (style đầu tiên)
        if (colorOptions.length > 0) {
            colorOptions[0].classList.add('selected-style'); // Chọn style đầu tiên
            selectedStyleInput.value = colorOptions[0].getAttribute('data-style-id');
            selectedStyleInput1.value = colorOptions[0].getAttribute('data-style-id');
        }

        // Cập nhật giá trị khi chọn style
        colorOptions.forEach(option => {
            option.addEventListener('click', function () {
                // Xóa lớp selected-style khỏi tất cả các ảnh
                colorOptions.forEach(opt => opt.classList.remove('selected-style'));

                // Thêm lớp selected-style vào ảnh được chọn
                this.classList.add('selected-style');

                // Cập nhật giá trị input
                selectedStyleInput.value = this.getAttribute('data-style-id');
                selectedStyleInput1.value = this.getAttribute('data-style-id');
            });
        });
    });
    document.querySelectorAll('.color-option').forEach(option => {
        option.addEventListener('click', function () {
            document.querySelectorAll('.color-option').forEach(opt => opt.classList.remove('selected-style'));

            this.classList.add('selected-style');

            console.log(this.classList.contains('selected-style')); // Kết quả true nếu đúng
        });
    });
    document.addEventListener('DOMContentLoaded', function () {
        const decrementButtons = document.querySelectorAll('.decrement-btn');
        const incrementButtons = document.querySelectorAll('.increment-btn');
        const quantityInputs = document.querySelectorAll('.quantity-input');

        // Xử lý nút giảm (-)
        decrementButtons.forEach((button, index) => {
            button.addEventListener('click', function () {
                const input = quantityInputs[index]; // Lấy input tương ứng
                let value = parseInt(input.value, 10); // Chuyển giá trị sang số nguyên
                if (value > 1) {
                    input.value = value - 1; // Giảm giá trị xuống 1
                }
            });
        });

        // Xử lý nút tăng (+)
        incrementButtons.forEach((button, index) => {
            button.addEventListener('click', function () {
                const input = quantityInputs[index]; // Lấy input tương ứng
                let value = parseInt(input.value, 10); // Chuyển giá trị sang số nguyên
                input.value = value + 1; // Tăng giá trị lên 1
            });
        });
    });

</script>
<script src="js/detail-product.js"></script>
<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>