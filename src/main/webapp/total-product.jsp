<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Nút áo</title>
  <c:import url="includes/link/headLink.jsp" />
  <link rel="stylesheet" href="css/button_up.css">
</head>
<body>
<c:import url="includes/header.jsp" />
<c:import url="includes/navbar.jsp" />

<div class="container my-5">
  <div class="row">
    <!-- Sidebar bộ lọc -->
    <div class="col-md-3">
      <h5>Giá</h5>

      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price1" data-selection="${requestScope.selection}" data-min="0" data-max="10000">
        <label class="form-check-label" for="price1">Dưới 10.000đ</label>
      </div>

      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price2" data-selection="${requestScope.selection}" data-min="10000" data-max="50000">
        <label class="form-check-label" for="price2">10.000đ - 50.000đ</label>
      </div>

      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price3" data-selection="${requestScope.selection}" data-min="50000" data-max="100000">
        <label class="form-check-label" for="price3">50.000đ - 100.000đ</label>
      </div>

      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price4" data-selection="${requestScope.selection}" data-min="100000" data-max="200000">
        <label class="form-check-label" for="price4">100.000đ - 200.000đ</label>
      </div>

      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price5" data-selection="${requestScope.selection}" data-min="200000" data-max="">
        <label class="form-check-label" for="price5">Trên 200.000đ</label>
      </div>
</div>

      <!-- Nội dung chính -->
    <div class="col-md-9 position-relative">
      <!-- Overlay loading spinner -->
      <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner-border text-primary" role="status">
          <span class="visually-hidden">Đang tải...</span>
        </div>
      </div>

      <!-- Thanh sắp xếp -->
      <div class="header-right d-flex align-items-center justify-content-end mb-4">
        <div class="dropdown">
          <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
            Sắp xếp theo
          </button>
          <ul class="dropdown-menu sort-options" aria-labelledby="dropdownMenuButton">
            <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="latest">Mới nhất</a></li>
            <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="expensivet">Giá: Cao -> Thấp</a></li>
            <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="cheapt">Giá: Thấp -> Cao</a></li>
            <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="latestt">Bán chạy nhất</a></li>
            <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="discountt">Giảm giá: Cao -> Thấp</a></li>
          </ul>
        </div>
      </div>

      <!-- Danh sách sản phẩm -->
      <div class="row product-container" id="productContainer">
        <c:forEach var="product" items="${requestScope.products}">
          <div class="col-md-4 mb-4">
            <div class="card product-item position-relative h-100">
              <!-- Thẻ hiển thị giảm giá -->
              <c:if test="${product.price.discountPercent > 0}">
                <span class="badge bg-danger position-absolute top-0 end-0 m-2 px-3 py-2 fs-5 product-discount">
                  -<fmt:formatNumber value="${product.price.discountPercent}" pattern="##0" />%
                </span>
              </c:if>

              <!-- Hình ảnh chính của sản phẩm -->
              <img id="mainImage${product.id}" src="${product.image}" alt="${product.description}" class="card-img-top main-product-image" style="object-fit: cover; cursor: pointer;">

              <!-- Modal để hiển thị hình ảnh lớn -->
              <div class="modal fade" id="imageModal${product.id}" tabindex="-1" aria-labelledby="imageModalLabel${product.id}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">
                    <div class="modal-body">
                      <img src="${product.image}" class="img-fluid" id="modalImage${product.id}" alt="Hình ảnh lớn">
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                  </div>
                </div>
              </div>

              <div class="card-body text-center d-flex flex-column">
                <h5 class="card-title">${product.name}</h5>
                <h4 class="card-text text-success">
                  Chỉ còn:
                  <span class="product-old-price">
                    <fmt:formatNumber value="${product.price.lastPrice}" type="currency" currencySymbol="₫" />
                  </span>
                </h4>
                <p class="text-danger text-decoration-line-through">
                  Giá gốc:
                  <span class="product-price">
                    <fmt:formatNumber value="${product.price.price}" type="currency" currencySymbol="₫" />
                  </span>
                </p>

                <p class="cart-text description">Mô tả: ${product.description}</p>
                <button type="button" data-id="${product.id}" class="btn btn-warning w-100 mb-2 add-to-cart-button">Thêm vào giỏ hàng</button>
                <!-- Nút Xem Ngay -->
                <a href="detail-product?productId=${product.id}" class="btn btn-primary w-100">Xem ngay</a>
              </div>
            </div>
          </div>
        </c:forEach>
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
<script src="js/product.js"></script>

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