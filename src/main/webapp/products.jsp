<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Danh mục sản phẩm</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/products.css">
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>
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

    /* Filter styles */
    .filter-section {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
    }

    .filter-section h5 {
        color: #333;
        margin-bottom: 15px;
    }

    .price-range {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .price-input {
        width: 120px;
    }

    .filter-buttons {
        margin-top: 15px;
        display: flex;
        gap: 10px;
    }

    .category-checkbox {
        margin-bottom: 8px;
    }

    .filter-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-top: 10px;
    }

    .filter-tag {
        background-color: #e9ecef;
        padding: 5px 10px;
        border-radius: 15px;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .filter-tag .remove-tag {
        cursor: pointer;
        color: #666;
    }

    .filter-tag .remove-tag:hover {
        color: #dc3545;
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
    <!-- Filter Section -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="filter-section">
                <h5><fmt:message key="filter"/></h5>
                
                <!-- Price Range Filter -->
                <div class="mb-4">
                    <h6><fmt:message key="price_range"/></h6>
                    <div class="price-range">
                        <input type="number" class="form-control price-input" id="minPrice" placeholder="Min" value="${param.minPrice}">
                        <span>-</span>
                        <input type="number" class="form-control price-input" id="maxPrice" placeholder="Max" value="${param.maxPrice}">
                    </div>
                </div>

                <!-- Category Filter -->
                <div class="mb-4">
                    <h6><fmt:message key="categories"/></h6>
                    <div class="category-list">
                        <c:forEach var="category" items="${requestScope.categories}">
                            <div class="category-checkbox">
                                <input type="checkbox" class="form-check-input" 
                                       id="category${category.id}" 
                                       name="categories" 
                                       value="${category.id}"
                                       <c:if test="${not empty paramValues.categories}">
                                           <c:forEach var="selectedCategory" items="${paramValues.categories}">
                                               <c:if test="${selectedCategory eq category.id}">checked</c:if>
                                           </c:forEach>
                                       </c:if>>
                                <label class="form-check-label" for="category${category.id}">
                                    ${category.name}
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Active Filters -->
                <div class="active-filters mb-4">
                    <h6><fmt:message key="active_filters"/></h6>
                    <div class="filter-tags" id="filterTags">
                        <c:if test="${not empty param.minPrice || not empty param.maxPrice}">
                            <div class="filter-tag">
                                <span>Price: ${param.minPrice} - ${param.maxPrice}</span>
                                <span class="remove-tag" onclick="removePriceFilter()">&times;</span>
                            </div>
                        </c:if>
                        <c:forEach var="categoryId" items="${paramValues.categories}">
                            <c:forEach var="category" items="${requestScope.categories}">
                                <c:if test="${category.id == categoryId}">
                                    <div class="filter-tag">
                                        <span>${category.name}</span>
                                        <span class="remove-tag" onclick="removeCategoryFilter('${category.id}')">&times;</span>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </div>

                <!-- Filter Buttons -->
                <div class="filter-buttons">
                    <button class="btn btn-primary" onclick="applyFilters()">
                        <fmt:message key="apply_filters"/>
                    </button>
                    <button class="btn btn-secondary" onclick="clearFilters()">
                        <fmt:message key="clear_filters"/>
                    </button>
                </div>
            </div>
        </div>

        <div class="col-md-9">
            <!-- Existing sorting dropdown -->
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
                                    <div class="d-flex justify-content-center gap-2">
                                        <button type="button" class="btn btn-warning add-to-cart-button">
                                            <i class="fa-solid fa-cart-shopping"></i>
                                        </button>
                                        <c:if test="${product.id > 0}">
                                            <a href="detail-product?productId=${product.id}"
                                               class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#productDetailModal" data-product-id="${product.id}">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                        </c:if>
                                    </div>
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
    </div>
</div>

<!-- Product Detail Modal -->
<div class="modal fade" id="productDetailModal" tabindex="-1" aria-labelledby="productDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="productDetailModalLabel">Chi tiết sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="modalProductDetails">
                    <!-- Content will be populated dynamically -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<%@include file="includes/footer.jsp" %>

<script>
document.addEventListener('DOMContentLoaded', function () {
    // --- Filter Functions ---
    window.applyFilters = function() {
        let url = new URL(window.location.href);
        let params = new URLSearchParams(url.search);

        // Get price range
        const minPrice = document.getElementById('minPrice').value;
        const maxPrice = document.getElementById('maxPrice').value;

        if (minPrice) params.set('minPrice', minPrice);
        if (maxPrice) params.set('maxPrice', maxPrice);

        // Get selected categories
        const selectedCategories = Array.from(document.querySelectorAll('input[name="categories"]:checked'))
            .map(cb => cb.value);

        if (selectedCategories.length > 0) {
            params.delete('categories');
            selectedCategories.forEach(category => {
                params.append('categories', category);
            });
        }

        // Reset to page 1 when applying filters
        params.set('page', '1');

        // Redirect to new URL
        window.location.href = url.pathname + '?' + params.toString();
    };

    window.clearFilters = function() {
        let url = new URL(window.location.href);
        let params = new URLSearchParams(url.search);

        // Remove filter parameters
        params.delete('minPrice');
        params.delete('maxPrice');
        params.delete('categories');

        // Reset to page 1
        params.set('page', '1');

        // Redirect to new URL
        window.location.href = url.pathname + '?' + params.toString();
    };

    window.removePriceFilter = function() {
        let url = new URL(window.location.href);
        let params = new URLSearchParams(url.search);

        params.delete('minPrice');
        params.delete('maxPrice');

        window.location.href = url.pathname + '?' + params.toString();
    };

    window.removeCategoryFilter = function(categoryId) {
        let url = new URL(window.location.href);
        let params = new URLSearchParams(url.search);

        // Get current categories
        let categories = params.getAll('categories');
        // Remove the specified category
        categories = categories.filter(id => id !== categoryId.toString());

        // Update URL
        params.delete('categories');
        categories.forEach(category => {
            params.append('categories', category);
        });

        window.location.href = url.pathname + '?' + params.toString();
    };

    // --- Modal and AJAX Handling ---
    const productDetailModal = document.getElementById('productDetailModal');
    const modalProductDetails = document.getElementById('modalProductDetails');

    if (productDetailModal) {
        productDetailModal.addEventListener('show.bs.modal', function (event) {
            // Button that triggered the modal
            const button = event.relatedTarget;
            // Extract product ID from data-product-id attribute
            const productId = button.getAttribute('data-product-id');

            if (!productId) {
                modalProductDetails.innerHTML = 'Lỗi: Không tìm thấy ID sản phẩm';
                return;
            }

            // Clear previous content
            modalProductDetails.innerHTML = 'Đang tải...';

            // Fetch product details via AJAX
            fetch(`detail-product?productId=${productId}&ajax=true`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(product => {
                    if (!product) {
                        modalProductDetails.innerHTML = 'Không tìm thấy chi tiết sản phẩm.';
                        return;
                    }

                    // Populate modal with product details
                    const productName = product.name || 'N/A';
                    const productImage = product.image || '';
                    const productLastPrice = product.price && product.price.lastPrice !== undefined ? product.price.lastPrice + '₫' : 'N/A';
                    const productDescription = product.description || 'Không có mô tả';
                    const productQuantity = product.quantity !== undefined ? product.quantity : 'N/A';
                    const productDateAdded = product.dateAdded || 'N/A';

                    modalProductDetails.innerHTML = `
                        <div class="row">
                            <div class="col-md-6">
                                <img src="${productImage}" class="img-fluid" alt="${productName}">
                            </div>
                            <div class="col-md-6">
                                <h5>${productName}</h5>
                                <p><strong>Giá:</strong> ${productLastPrice}</p>
                                <p><strong>Mô tả:</strong> ${productDescription}</p>
                                <p><strong>Số lượng còn lại:</strong> ${productQuantity}</p>
                                <p><strong>Ngày thêm:</strong> ${productDateAdded}</p>
                            </div>
                        </div>
                    `;
                })
                .catch(error => {
                    console.error('Error fetching product details:', error);
                    modalProductDetails.innerHTML = `Lỗi khi tải chi tiết sản phẩm: ${error.message}`;
                });
        });
    }

    // --- Style Selection, Quantity, Add to Cart Handling ---
    const styleInputs = document.querySelectorAll('input[type="radio"][name="styleId"]');
    styleInputs.forEach(input => {
        input.addEventListener("change", function () {
            const form = this.closest(".product-options-form");
            const productId = form.querySelector('input[name="productId"]');
            const imageUrl = this.nextElementSibling.src;
            if (productId) {
                changeMainImage(productId.value, imageUrl);
            }
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
            if (quantityAndButtons) {
                quantityAndButtons.style.display = "block";
            }
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

            if (quantityAndButtons) {
                quantityAndButtons.style.display = "none";
            }
            if (addToCartButton) {
                addToCartButton.style.display = "block";
            }
        });
    });

    // Form submission handling
    const forms = document.querySelectorAll(".product-options-form");
    forms.forEach(form => {
        form.addEventListener("submit", function(e) {
            e.preventDefault();

            const quantityInput = form.querySelector(".quantity-input");
            const styleInput = form.querySelector('input[type="radio"][name="styleId"]:checked');
            const productId = form.querySelector('input[name="productId"]');

            // Validate style selection
            if (!styleInput) {
                alert("Vui lòng chọn style sản phẩm!");
                return;
            }

            // Validate quantity
            if (!quantityInput || !quantityInput.value || parseInt(quantityInput.value) < 1) {
                alert("Vui lòng nhập số lượng hợp lệ!");
                return;
            }

            // Validate product ID
            if (!productId || !productId.value) {
                alert("Lỗi: Không tìm thấy thông tin sản phẩm!");
                return;
            }

            // If all validations pass, submit the form
            this.submit();
        });
    });

    function changeMainImage(productId, imageUrl) {
        const mainImage = document.getElementById("mainImage" + productId);
        if (mainImage) {
            mainImage.src = imageUrl;
        }
    }
}); // End DOMContentLoaded
</script>
</body>
</html>