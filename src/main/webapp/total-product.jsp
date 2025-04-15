<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Nút áo</title>
  <c:import url="includes/link/headLink.jsp" />
  <link rel="stylesheet" href="css/button_up.css">
  <style>
    /* Thêm một số CSS cho việc chọn Style */
    .style-selection {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-bottom: 15px;
    }
    .style-option {
      position: relative;
      cursor: pointer;
    }
    .style-option img {
      width: 60px;
      height: 60px;
      border: 2px solid #ccc;
      border-radius: 5px;
      transition: transform 0.2s, border-color 0.2s;
      padding: 2px;
    }
    .style-option.selected img {
      border-color: #007bff;
      transform: scale(1.1);
    }
    /* Hiển thị thông báo */
    .alert-message {
      position: fixed;
      top: 20px;
      right: 20px;
      z-index: 1000;
      display: none;
    }
    .pagination .page-item.active .page-link {
      background-color: #339C87 !important;
      color: white !important;
      border-color: #339C87 !important;
    }
    .pagination .page-link {
      color: #339C87;
    }
    .pagination .page-link:hover {
      background-color: #287a6a;
      color: white;
      border-color: #287a6a;
    }
    /* Thêm CSS cho loading spinner */
    .loading-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(255, 255, 255, 0.7);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 999;
      display: none;
    }
    .spinner-border {
      width: 3rem;
      height: 3rem;
    }
  </style>
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
        <input class="form-check-input price-filter" type="checkbox" id="price1" data-selection="${requestScope.selection}" data-min="0" data-max="10000" onclick="handleCheckboxChange(this)">
        <label class="form-check-label" for="price1">Dưới 10.000đ</label>
      </div>

      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price2" data-selection="${requestScope.selection}" data-min="10000" data-max="50000" onclick="handleCheckboxChange(this)">
        <label class="form-check-label" for="price2">10.000đ - 50.000đ</label>
      </div>

      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price3" data-selection="${requestScope.selection}" data-min="50000" data-max="100000" onclick="handleCheckboxChange(this)">
        <label class="form-check-label" for="price3">50.000đ - 100.000đ</label>
      </div>

      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price4" data-selection="${requestScope.selection}" data-min="100000" data-max="200000" onclick="handleCheckboxChange(this)">
        <label class="form-check-label" for="price4">100.000đ - 200.000đ</label>
      </div>

      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price5" data-selection="${requestScope.selection}" data-min="200000" data-max="" onclick="handleCheckboxChange(this)">
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
              <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="latest"  onclick="handleDropdownClick(this)">Mới nhất</a></li>
              <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="expensivet"  onclick="handleDropdownClick(this)">Giá: Cao -> Thấp</a></li>
              <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="cheapt"  onclick="handleDropdownClick(this)">Giá: Thấp -> Cao</a></li>
              <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="latestt"  onclick="handleDropdownClick(this)">Bán chạy nhất</a></li>
              <li><a class="dropdown-item" data-selection="${requestScope.selection}" data-option="discountt"  onclick="handleDropdownClick(this)">Giảm giá: Cao -> Thấp</a></li>
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
                <button type="button" class="btn btn-warning w-100 mb-2 add-to-cart-button">Thêm vào giỏ hàng</button>
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

<div class="pagination-container mt-4 d-flex justify-content-center" id="paginationContainer">
  <ul class="pagination pagination-lg">

    <!-- Nút Trước -->
    <c:if test="${requestScope.currentPage > 1}">
      <li class="page-item">
        <a class="page-link pagination-link" data-page="${requestScope.currentPage - 1}" onclick="handlePaginationClick(this)"> < </a>
      </li>
    </c:if>

    <!-- Hiển thị tối đa 5 trang quanh currentPage -->
    <c:set var="startPage" value="${requestScope.currentPage - 2 > 1 ? requestScope.currentPage - 2 : 1}" />
    <c:set var="endPage" value="${requestScope.currentPage + 2 < requestScope.nupage ? requestScope.currentPage + 2 : requestScope.nupage}" />

    <c:forEach begin="${startPage}" end="${endPage}" var="i">
      <li class="page-item ${i == requestScope.currentPage ? 'active' : ''}">
        <a class="page-link pagination-link" data-page="${i}" onclick="handlePaginationClick(this)">${i}</a>
      </li>
    </c:forEach>

    <!-- Nút Sau -->
    <c:if test="${requestScope.currentPage < requestScope.nupage}">
      <li class="page-item">
        <a class="page-link pagination-link" data-page="${requestScope.currentPage + 1}" onclick="handlePaginationClick(this)"> > </a>
      </li>
    </c:if>

  </ul>
</div>

<!-- Nút Back to Top -->
<button id="back-to-top" class="back-to-top">
  <i class="fas fa-arrow-up"></i>
</button>

<!-- Thẻ thông báo -->
<div class="alert-message alert alert-success" role="alert" id="alert-message">
  <!-- Nội dung thông báo sẽ được thêm bằng JavaScript -->
</div>

<c:import url="includes/footer.jsp" />
<c:import url="includes/link/footLink.jsp" />



<!-- JavaScript -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/product.js"></script>

</body>
</html>