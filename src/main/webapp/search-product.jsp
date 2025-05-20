<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tìm kiếm sản phẩm</title>
    <c:import url="includes/link/headLink.jsp" />
    <link rel="stylesheet" href="css/button_up.css">
</head>
<body>
<c:import url="includes/header.jsp" />
<c:import url="includes/navbar.jsp" />

<div class="container my-5">
    <div class="row">
        <!-- Nội dung chính -->
        <div class="col-12 position-relative">
            <!-- Overlay loading spinner -->
            <div class="loading-overlay" id="loadingOverlay">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Đang tải...</span>
                </div>
            </div>

            <!-- Kết quả tìm kiếm -->
            <div class="search-results mb-4">
                <h4>Kết quả tìm kiếm cho: <span id="searchQuery" class="text-primary"></span></h4>
                <p>Tìm thấy <span id="resultCount" class="fw-bold">0</span> sản phẩm</p>
            </div>

            <!-- Danh sách sản phẩm -->
            <div class="row product-container" id="productContainer">
                <!-- Sản phẩm sẽ được render ở đây -->
            </div>
        </div>
    </div>
</div>

<!-- Dynamic Modal for Product Details -->
<div class="modal fade" id="productDetailsModal" tabindex="-1" aria-labelledby="productDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="productDetailsModalLabel">Chi tiết sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <!-- Image Section -->
                    <div class="col-md-6">
                        <img src="" class="d-block w-100 product-modal-image" alt="Product Image">
                    </div>
                    <div class="col-md-6">
                        <h3 class="text product-modal-name" style="color: #008080"></h3>
                        <p class="h4 text-decoration-line-through text-warning product-modal-original-price"></p>
                        <p class="h2 text-danger fw-bold product-modal-discounted-price"></p>
                        <form action="add-to-cart" method="post">
                            <input name="currentURL" type="hidden" value="">
                            <div class="mb-3">
                                <p class="fw-bold">Kiểu vải</p>
                                <div class="d-flex gap-2 product-modal-styles">
                                    <!-- Styles will be dynamically inserted here -->
                                </div>
                            </div>
                            <p class="fw-bold">Số lượng</p>
                            <div class="row">
                                <div class="col-6">
                                    <div class="input-group">
                                        <input type="hidden" name="currentURL" value="">
                                        <input type="number" name="quantity" class="form-control text-center quantity-input" value="1" style="max-width: 100px" min="1">
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="productID" value="">
                            <button type="submit" class="btn btn-custom w-100" style="background-color: #339c87">Thêm vào giỏ hàng</button>
                        </form>
                        <div class="alert alert-light mt-3" role="alert">
                            <i class="bi bi-truck"></i>
                            Giao hàng: Mua hàng từ 10 sản phẩm (trong đó có trên 5 loại là vải) thì được freeship.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="paginationContainer" class="pagination-container"></div>

<c:import url="includes/footer.jsp" />
<c:import url="includes/link/footLink.jsp" />

<!-- JavaScript -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/search-product.js"></script>

<!-- Add this script to initialize Bootstrap modal -->
<script>
    $(document).ready(function() {
        // Initialize Bootstrap modal
        const productModal = new bootstrap.Modal(document.getElementById('productDetailsModal'), {
            backdrop: 'static',
            keyboard: false
        });
        
        // Add click handler for add to cart button
        $(document).on('click', '.add-to-cart-button', function() {
            const productId = $(this).data('id');
            loadProductDetails(productId);
        });

        // Handle modal hidden event
        $('#productDetailsModal').on('hidden.bs.modal', function () {
            // Clean up modal content
            $('.product-modal-image').attr('src', '');
            $('.product-modal-name').text('');
            $('.product-modal-original-price').text('');
            $('.product-modal-discounted-price').text('');
            $('.product-modal-styles').empty();
            $('input[name="productID"]').val('');
            $('input[name="currentURL"]').val('');
            
            // Remove modal backdrop
            $('.modal-backdrop').remove();
            $('body').removeClass('modal-open');
            $('body').css('overflow', '');
            $('body').css('padding-right', '');
        });
    });
</script>
</body>
</html> 