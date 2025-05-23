<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    /* Style selection styles */
    .product-style-label {
        position: relative;
        display: inline-block;
        cursor: pointer;
        transition: transform 0.2s, border-color 0.2s;
    }

    .product-style-image {
        transition: transform 0.2s, border-color 0.2s;
        border: 2px solid #ccc;
        border-radius: 4px;
        padding: 2px;
    }

    .product-style-label:hover .product-style-image {
        transform: scale(1.1);
        border-color: #007bff;
    }

    input[type="radio"]:checked + .product-style-image {
        border-color: #007bff;
        transform: scale(1.1);
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }

    /* Quantity input styles */
    .quantity-input {
        text-align: center;
        border: 1px solid #ced4da;
        border-radius: 4px;
        padding: 0.375rem 0.75rem;
    }

    .quantity-input:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }

    /* Button styles */
    .add-to-cart-button {
        transition: all 0.3s ease;
    }

    .add-to-cart-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }

    .cancel-button, .submit-cart-button {
        transition: all 0.3s ease;
    }

    .cancel-button:hover, .submit-cart-button:hover {
        transform: scale(1.05);
    }
</style>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>
<%@include file="includes/header.jsp" %>
<%@include file="includes/navbar.jsp" %>
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
            <a class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown"
               aria-expanded="false">
                <fmt:message key="sx"/>
            </a>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li><a class="dropdown-item" href="products?option=1&page=1"><fmt:message key="mn"/></a></li>
                <li><a class="dropdown-item" href="products?option=2&page=1"><fmt:message key="ct"/></a></li>
                <li><a class="dropdown-item" href="products?option=3&page=1"><fmt:message key="tc"/></a></li>
                <li><a class="dropdown-item" href="products?option=4&page=1"><fmt:message key="bcn"/></a></li>
                <li><a class="dropdown-item" href="products?option=5&page=1"><fmt:message key="gg"/></a></li>
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
                <img id="mainImage${product.id}" src="${product.image}" alt="${product.description}"
                     class="img-fluid main-image w-100 h-50">

                <!-- Danh sách các tùy chọn màu sắc hiển thị dưới dạng ảnh -->
                <form action="add-to-cart" method="post" class="product-options-form">
                    <input name="currentURL" type="hidden"
                           value="products?page=${requestScope.currentPage}&option=${requestScope.option}">
                    <input type="hidden" name="productId" value="${product.id}">
                    
                    <!-- Style Selection -->
                    <div class="mb-3">
                        <label class="form-label fw-bold"><fmt:message key="chonStyle"/></label>
                        <div class="product-squares d-flex justify-content-center align-items-center flex-wrap gap-2">
                            <c:forEach var="style" items="${product.styles}">
                                <label for="style${style.id}" class="product-style-label"
                                       style="cursor: pointer;">
                                    <input
                                            type="radio"
                                            name="styleId"
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
                    </div>

                    <!-- Quantity input and buttons container -->
                    <div class="quantity-and-buttons mt-3" style="display: none;">
                        <div class="quantity-container mb-3">
                            <label for="quantity${product.id}" class="form-label fw-bold"><fmt:message key="soluong"/></label>
                            <input name="quantity" id="quantity${product.id}" class="form-control quantity-input" 
                                   type="number" min="1" value="1" style="width: 100px; margin: 0 auto;" required>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-md-4 d-flex justify-content-between">
                                <button type="button" class="btn btn-secondary cancel-button">
                                    <i class="fas fa-times"></i>
                                </button>
                                <button type="submit" class="btn btn-success submit-cart-button">
                                    <i class="fas fa-check"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="card-body text-center">
                        <h5 class="card-title">${product.name}</h5>
                        <h4 class="card-text text-success">Chỉ còn: <span
                                class="product-price text-success">${product.price.lastPrice}</span></h4>
                        <p class="text-danger text-decoration-line-through text-center">Giá gốc: <span
                                class="product-price">${product.price.price}</span></p>
                        <p class="cart-text "><fmt:message key="mota"/> ${product.description}</p>
                        <div class="row justify-content-center">
                            <div class="col-md-4">
                                <button type="button" class="btn btn-warning add-to-cart-button w-100">
                                    <i class="fa-solid fa-cart-shopping"></i> <fmt:message key="themvaogio"/>
                                </button>
                            </div>
                            <a href="detail-product?productId=${product.id}"
                               class="btn btn-primary mx-1 col-md-4 text-center"><fmt:message key="xem"/></a>
                        </div>
                    </div>
                </form>
            </div>
        </c:forEach>
    </div>

    <!-- Phân trang -->
    <div class="d-flex justify-content-between align-items-center mt-4 mb-4">
        <div class="text-muted">
            Trang ${requestScope.currentPage} / ${requestScope.nupage}
        </div>
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center mb-0">
                <!-- Nút Previous -->
                <c:if test="${requestScope.currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" 
                           href="products?page=${requestScope.currentPage-1}&option=${requestScope.option}&selection=${requestScope.selection}&minPrice=${requestScope.minPrice}&maxPrice=${requestScope.maxPrice}">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>
                </c:if>

                <!-- Hiển thị tối đa 5 trang -->
                <c:forEach var="i" begin="1" end="${requestScope.nupage}">
                    <c:choose>
                        <c:when test="${i == 1 || i == requestScope.nupage || (i >= requestScope.currentPage - 2 && i <= requestScope.currentPage + 2)}">
                            <li class="page-item ${i == requestScope.currentPage ? 'active' : ''}">
                                <a class="page-link" 
                                   href="products?page=${i}&option=${requestScope.option}&selection=${requestScope.selection}&minPrice=${requestScope.minPrice}&maxPrice=${requestScope.maxPrice}">
                                    ${i}
                                </a>
                            </li>
                        </c:when>
                        <c:when test="${i == 2 && requestScope.currentPage > 4}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:when>
                        <c:when test="${i == requestScope.nupage - 1 && requestScope.currentPage < requestScope.nupage - 3}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:when>
                    </c:choose>
                </c:forEach>

                <!-- Nút Next -->
                <c:if test="${requestScope.currentPage < requestScope.nupage}">
                    <li class="page-item">
                        <a class="page-link" 
                           href="products?page=${requestScope.currentPage+1}&option=${requestScope.option}&selection=${requestScope.selection}&minPrice=${requestScope.minPrice}&maxPrice=${requestScope.maxPrice}">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>

    <style>
        .pagination {
            margin-bottom: 0;
        }
        .page-link {
            color: #007bff;
            border: 1px solid #dee2e6;
            padding: 0.5rem 0.75rem;
            margin: 0 2px;
            border-radius: 4px;
        }
        .page-item.active .page-link {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }
        .page-link:hover {
            background-color: #e9ecef;
            color: #0056b3;
        }
        .page-item.disabled .page-link {
            color: #6c757d;
            pointer-events: none;
            background-color: #fff;
            border-color: #dee2e6;
        }
    </style>

</div>

<%@include file="includes/footer.jsp" %>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Style selection handling
        const styleInputs = document.querySelectorAll('input[type="radio"][name="styleId"]');
        styleInputs.forEach(input => {
            input.addEventListener("change", function () {
                const form = this.closest(".product-options-form");
                const productId = form.querySelector('input[name="productId"]').value;
                const imageUrl = this.nextElementSibling.src;
                changeMainImage(productId, imageUrl);
            });
        });

        // Add to cart button handling
        const addToCartButtons = document.querySelectorAll(".add-to-cart-button");
        addToCartButtons.forEach(button => {
            button.addEventListener("click", function () {
                const form = this.closest(".product-options-form");
                const quantityAndButtons = form.querySelector(".quantity-and-buttons");
                const styleInputs = form.querySelectorAll('input[type="radio"][name="styleId"]');
                
                // Check if a style is selected
                let styleSelected = false;
                styleInputs.forEach(input => {
                    if (input.checked) {
                        styleSelected = true;
                    }
                });

                if (!styleSelected) {
                    alert("Vui lòng chọn style sản phẩm trước!");
                    return;
                }

                // Show quantity input and confirm/cancel buttons
                quantityAndButtons.style.display = "block";
                this.style.display = "none";
            });
        });

        // Cancel button handling
        const cancelButtons = document.querySelectorAll(".cancel-button");
        cancelButtons.forEach(button => {
            button.addEventListener("click", function () {
                const form = this.closest(".product-options-form");
                const quantityAndButtons = form.querySelector(".quantity-and-buttons");
                const addToCartButton = form.querySelector(".add-to-cart-button");
                
                quantityAndButtons.style.display = "none";
                addToCartButton.style.display = "block";
            });
        });

        // Form submission handling
        const forms = document.querySelectorAll(".product-options-form");
        forms.forEach(form => {
            form.addEventListener("submit", function(e) {
                e.preventDefault(); // Prevent default form submission
                
                const quantityInput = form.querySelector(".quantity-input");
                const styleInput = form.querySelector('input[type="radio"][name="styleId"]:checked');
                
                if (!styleInput) {
                    alert("Vui lòng chọn style sản phẩm!");
                    return;
                }
                
                if (!quantityInput.value || quantityInput.value < 1) {
                    alert("Vui lòng nhập số lượng hợp lệ!");
                    return;
                }

                // If all validations pass, submit the form
                this.submit();
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