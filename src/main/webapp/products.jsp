<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp"%>
<html>
<head>
    <title>Danh mục sản phẩm</title>
    <style>
        .product-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 cột đều */
            gap: 20px; /* Khoảng cách giữa các sản phẩm */
        }

        .product-item {
            display: flex;
            flex-direction: column;
            border: 1px solid #ccc;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        .product-card {
            height: 100%;
            display: flex;
            flex-direction: column;
            padding: 15px;
        }

        .product-title {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }

        .product-squares {
            display: flex;
            gap: 5px;
            margin-top: 10px;
        }

        .square {
            width: 40px;
            height: 40px;
            border: 1px solid #ddd;
            background-size: cover;
            background-position: center;
            cursor: pointer;
        }

        .square:hover {
            border: 2px solid #007bff;
        }

        .product-old-price {
            text-decoration: line-through;
            color: #888;
        }

        .product-price {
            font-weight: bold;
            color: #e60023;
        }

        .btn-buy {
            margin-top: 15px;
            padding: 10px 15px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-buy:hover {
            background-color: #0056b3;
        }

        .pagination {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .page-item {
            list-style: none;
        }

        .page-link {
            text-decoration: none;
            padding: 8px 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            color: #007bff;
        }

        .page-item.disabled .page-link {
            color: #ccc;
        }
        .product-discount-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #e60023; /* Màu đỏ nổi bật */
            color: #fff;
            font-size: 14px;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
            z-index: 10; /* Đảm bảo nó nằm trên các phần tử khác */
        }
        .product-card {
            position: relative; /* Thêm để các phần tử con dùng vị trí relative/absolute */
            height: 100%;
            display: flex;
            flex-direction: column;
            padding: 15px;
        }

    </style>
    <link rel="stylesheet" href="css/products.css">
</head>
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

                <!-- Danh sách các tùy chọn màu sắc -->
                <div class="product-squares d-flex justify-content-center mt-2">
                    <c:forEach var="style" items="${product.styles}">
                        <div
                                class="square"
                                style="background-image: url('${style.image}'); background-size: cover; background-position: center; width: 40px; height: 40px; border: 1px solid #ccc; margin: 0 5px; cursor: pointer;"
                                onmouseover="changeMainImage(${product.id}, '${style.image}')"
                                onmouseout="restoreMainImage(${product.id}, '${product.image}')">
                        </div>
                    </c:forEach>
                </div>

                <div class="card-body text-center">
                    <h5 class="card-title">${product.name}</h5>
                    <h4 class="card-text text-success">Chỉ còn: <span class="product-price text-success">${product.price.lastPrice}</span></h4>
                    <p class="text-danger text-decoration-line-through text-center">Giá gốc: <span class="product-price">${product.price.price}</span></p>
                    <p class="cart-text ">Mô tả: ${product.description}</p>
                    <div class="row" style="justify-content: center">
                        <a href="detail-product?id=${product.id}" class="col-md-7 btn btn-warning mx-1">Thêm vào giỏ hàng</a>
                        <a href="detail-product?id=${product.id}" class="col-md-4 btn btn-primary mx-1">Xem ngay</a>
                    </div>
                </div>
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
    function changeMainImage(productId, imageUrl) {
        document.getElementById("mainImage" + productId).src = imageUrl;
    }

    function restoreMainImage(productId, imageUrl) {
        document.getElementById("mainImage" + productId).src = imageUrl;
    }
</script>
<script src="js/products.js"></script>
</body>
</html>
