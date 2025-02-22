<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp"%>
<html>
<head>
    <title>Danh mục sản phẩm</title>
    <link rel="stylesheet" href="css/products.css">
</head>
<style>
    /* Thay đổi giao diện khi người dùng chọn */
    .product-style-image {
        transition: transform 0.2s, border-color 0.2s;
    }

    input[type="radio"]:checked + .product-style-image {
        border-color: #007bff;
        transform: scale(1.3);
    }
</style>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/products.css">
<c:if test="${requestScope.products == null}">
    <script>
        window.location.href = "products";
    </script>
</c:if>
<div class="container">
    <!-- Thanh sắp xếp -->
    <div class="header-right d-flex align-items-center justify-content-end my-4">
        <div class="dropdown">
            <a class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                Sắp xếp theo
            </a>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li><a class="dropdown-item" href="products?option=1&page=1">Mới nhất</a></li>
                <li><a class="dropdown-item" href="products?option=2&page=1">Giá: Cao -> Thấp</a></li>
                <li><a class="dropdown-item" href="products?option=3&page=1">Giá: Thấp -> Cao</a></li>
                <li><a class="dropdown-item" href="products?option=4&page=1">Bán chạy nhất</a></li>
                <li><a class="dropdown-item" href="products?option=5&page=1">Giảm giá: Cao -> Thấp</a></li>
            </ul>
        </div>
    </div>

    <div class="product-container">
        <c:forEach var="product" items="${requestScope.products}">
            <div class="card product-item position-relative" style="background-color: #ededed">
                <!-- Thẻ span hiển thị phần trăm giảm giá -->
                <span class="badge bg-danger position-absolute top-0 end-0 m-2 px-3 py-2 fs-5 product-discount">
                     -${product.price.discountPercent}
                </span>

                <!-- Hình ảnh chính -->
                <img id="mainImage${product.id}" src="${product.image}" alt="${product.description}" class="img-fluid main-image w-100 h-50">

                <!-- Danh sách các tùy chọn màu sắc hiển thị dưới dạng ảnh -->
                <form action="cart?method=add" method="post" class="product-options-form">
                    <input name="currentURL" type="hidden" value="products?page=${requestScope.currentPage}&option=${requestScope.option}">
                    <input type="hidden" name="productID" value="${product.id}">
                    <div class="product-squares d-flex justify-content-center align-items-center flex-wrap mt-2">
                        <c:forEach var="style" items="${product.styles}">

                            <!-- Trường số lượng ẩn ban đầu -->
                            <div class="quantity-container" style="display: none;">
                                <label for="quantity" class="fw-bold">Số lượng:</label>
                                <input name="quantity" id="quantity" class="quantity-input " type="number" min="1" value="1">
                            </div>

                            <label for="style${style.id}" class="product-style-label" style="cursor: pointer; margin: 5px;">
                                <input
                                        type="radio"
                                        name="selectedStyle"
                                        id="style${style.id}"
                                        value="${style.id}"
                                        style="display: none;"
                                        required>
                                <img
                                        src="${style.image}"
                                        alt="${style.name}"
                                        class="product-style-image rounded"
                                        style="width: 60px; height: 60px; border: 2px solid #ccc; padding: 2px;">
                            </label>
                        </c:forEach>

                    </div>
                <div class="card-body text-center">
                    <h5 class="card-title">${product.name}</h5>
                    <h4 class="card-text text-success">Chỉ còn: <span class="product-price text-success">${product.price.lastPrice}</span></h4>
                    <p class="text-danger text-decoration-line-through text-center">Giá gốc: <span class="product-price">${product.price.price}</span></p>
                    <p class="cart-text ">Mô tả: ${product.description}</p>
                    <div class="row justify-content-center">
                        <div class="col-md-4 d-flex justify-content-between">
                            <button type="button" class="btn btn-warning add-to-cart-button">+<i class="fa-solid fa-cart-shopping"></i></button>
                            <button type="submit" class="btn btn-success submit-cart-button" style="display: none;">Xác nhận</button>
                        </div>
                        <a href="detail-product?productId=${product.id}" class="btn btn-primary mx-1 col-md-4 text-center">Xem ngay</a>
                    </div>
                </div>
                </form>
            </div>
        </c:forEach>
    </div>

    <!-- Phân trang -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-3">
            <!-- Nút Previous -->
            <c:if test="${requestScope.currentPage > 1}">
                <li class="page-item">
                    <a class="page-link mx-2" href="products?page=${requestScope.currentPage-1}&option=${requestScope.option}"><<</a>
                </li>
            </c:if>

            <!-- Hiển thị tối đa 5 trang -->
            <c:forEach var="i" begin="1" end="${requestScope.pageNumber}">
                <c:choose>
                    <c:when test="${i == 1 || i == requestScope.pageNumber || (i >= requestScope.currentPage - 2 && i <= requestScope.currentPage + 2)}">
                        <li class="page-item ${i == requestScope.currentPage ? 'active' : ''}">
                            <a class="page-link" href="products?page=${i}&option=${requestScope.option}">${i}</a>
                        </li>
                    </c:when>
                    <c:when test="${i == 2 && requestScope.currentPage > 4}">
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                    </c:when>
                    <c:when test="${i == requestScope.pageNumber - 1 && requestScope.currentPage < requestScope.pageNumber - 3}">
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                    </c:when>
                </c:choose>
            </c:forEach>

            <!-- Nút Next -->
            <c:if test="${requestScope.currentPage < requestScope.pageNumber}">
                <li class="page-item">
                    <a class="page-link mx-2" href="products?page=${requestScope.currentPage+1}&option=${requestScope.option}">>></a>
                </li>
            </c:if>
        </ul>
    </nav>

</div>

<%@include file="includes/footer.jsp"%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Lắng nghe sự kiện thay đổi của tất cả các radio button
        const styleInputs = document.querySelectorAll('input[type="radio"][name="selectedStyle"]');
        styleInputs.forEach(input => {
            input.addEventListener("change", function () {
                // Lấy productId từ form chứa radio button
                const form = this.closest(".product-options-form");
                const productId = form.querySelector('input[name="productID"]').value;

                // Lấy URL của ảnh từ <img> liền kề radio button
                const imageUrl = this.nextElementSibling.src;

                // Gọi hàm thay đổi ảnh chính
                changeMainImage(productId, imageUrl);
            });
        });
    });

    function changeMainImage(productId, imageUrl) {
        const mainImage = document.getElementById("mainImage" + productId);
        if (mainImage) {
            mainImage.src = imageUrl;
        }
    }
    document.addEventListener("DOMContentLoaded", function () {
        // Lấy danh sách các nút "Thêm vào giỏ hàng"
        const addToCartButtons = document.querySelectorAll(".add-to-cart-button");

        addToCartButtons.forEach(button => {
            button.addEventListener("click", function () {
                // Tìm container sản phẩm hiện tại
                const productContainer = this.closest(".product-item");

                // Lấy các phần tử cần thiết trong container hiện tại
                const quantityContainer = productContainer.querySelector(".quantity-container");
                const submitCartButton = productContainer.querySelector(".submit-cart-button");

                // Hiển thị input số lượng và nút "Xác nhận"
                quantityContainer.style.display = "block";
                this.style.display = "none"; // Ẩn nút "Thêm vào giỏ hàng"
                submitCartButton.style.display = "inline-block"; // Hiển thị nút "Xác nhận"
            });
        });
    });

</script>
<script src="js/products.js"></script>
</body>
</html>