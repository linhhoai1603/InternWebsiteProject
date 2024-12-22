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
                    <input type="hidden" name="productID" value="${product.id}">
                    <div class="product-squares d-flex justify-content-center align-items-center flex-wrap mt-2">
                        <c:forEach var="style" items="${product.styles}">
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
                    <div class="row mt-3" style="justify-content: center">
                        <button type="submit" class="col-md-7 btn btn-warning mx-1">Thêm vào giỏ hàng</button>
                        <a href="detail-product?id=${product.id}" class="col-md-4 btn btn-primary mx-1">Xem ngay</a>
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
                    <a class="page-link mx-2" href="products?page=${requestScope.currentPage-1}&option=${requestScope.option}"> << </a>
                </li>
            </c:if>

            <!-- Các trang -->
            <c:forEach var="i" begin="1" end="${requestScope.pageNumber}">
                <li class="page-item mx-2 ${i == requestScope.currentPage ? 'active' : ''}">
                    <a class="page-link" href="products?page=${i}&option=${requestScope.option}">${i}</a>
                </li>
            </c:forEach>

            <!-- Nút Next -->
            <c:if test="${requestScope.currentPage < requestScope.pageNumber}">
                <li class="page-item">
                    <a class="page-link mx-2" href="products?page=${requestScope.currentPage+1}&option=${requestScope.option}"> >> </a>
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

</script>
<script src="js/products.js"></script>
</body>
</html>
