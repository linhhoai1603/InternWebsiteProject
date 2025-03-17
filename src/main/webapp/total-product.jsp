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
            <input class="form-check-input price-filter" type="checkbox" id="price1" data-min="0" data-max="10000">
            <label class="form-check-label" for="price1">Dưới 10.000đ</label>
          </div>

          <div class="form-check mb-2">
            <input class="form-check-input price-filter" type="checkbox" id="price2" data-min="10000" data-max="50000">
            <label class="form-check-label" for="price2">10.000đ - 50.000đ</label>
          </div>

          <div class="form-check mb-2">
            <input class="form-check-input price-filter" type="checkbox" id="price3" data-min="50000" data-max="100000">
            <label class="form-check-label" for="price3">50.000đ - 100.000đ</label>
          </div>

          <div class="form-check mb-2">
            <input class="form-check-input price-filter" type="checkbox" id="price4" data-min="100000" data-max="200000">
            <label class="form-check-label" for="price4">100.000đ - 200.000đ</label>
          </div>

          <div class="form-check mb-2">
            <input class="form-check-input price-filter" type="checkbox" id="price5" data-min="200000" data-max="">
            <label class="form-check-label" for="price5">Trên 200.000đ</label>
          </div>
    </div>

    <!-- Nội dung chính -->
    <div class="col-md-9">
      <!-- Thanh sắp xếp -->
      <div class="header-right d-flex align-items-center justify-content-end mb-4">
        <div class="dropdown">
          <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
            Sắp xếp theo
          </button>
          <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <li><a class="dropdown-item" href="?option=1&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Mới nhất</a></li>
            <li><a class="dropdown-item" href="?option=2&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Giá: Cao -> Thấp</a></li>
            <li><a class="dropdown-item" href="?option=3&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Giá: Thấp -> Cao</a></li>
            <li><a class="dropdown-item" href="?option=4&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Bán chạy nhất</a></li>
            <li><a class="dropdown-item" href="?option=5&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Giảm giá: Cao -> Thấp</a></li>
          </ul>
        </div>
      </div>

      <!-- Danh sách sản phẩm -->
      <div class="row product-container">
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

                <form action="cart" method="post" class="mt-auto product-options-form">
                  <!-- Hidden Inputs -->
                  <input type="hidden" name="method" value="add">
                  <input type="hidden" name="currentURL" value="?page=${currentPage}&option=${option}<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">
                  <input type="hidden" name="productID" value="${product.id}">
                  <input type="hidden" name="selectedStyle" id="selectedStyle${product.id}" value="">

                  <!-- Chọn Style -->
                  <c:if test="${not empty product.styles}">
                    <div class="mb-3">
                      <label class="form-label">Chọn Style:</label>
                      <div class="style-selection">
                        <c:forEach var="style" items="${product.styles}">
                          <div class="style-option" data-style-id="${style.id}" data-image-url="${style.image}">
                            <img src="${style.image}" alt="${style.name}" class="product-style-image rounded">
                          </div>
                        </c:forEach>
                      </div>
                    </div>
                  </c:if>

                  <!-- Số lượng sản phẩm -->
                  <div class="mb-3 quantity-container" style="display: none;">
                    <label for="quantity${product.id}" class="form-label">Số lượng:</label>
                    <input type="number" class="form-control quantity-input" id="quantity${product.id}" name="quantity" min="1" value="1" required>
                  </div>

                  <!-- Nút Thêm Vào Giỏ Hàng / Xác Nhận -->
                  <button type="button" class="btn btn-warning w-100 mb-2 add-to-cart-button">Thêm vào giỏ hàng</button>
                  <button type="submit" class="btn btn-success w-100 mb-2 submit-cart-button" style="display: none;">Xác nhận</button>
                </form>

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
<div class="pagination-container mt-4 d-flex justify-content-center">
  <ul class="pagination pagination-lg">
    <c:if test="${currentPage > 1}">
      <li class="page-item">
        <a class="page-link" href="?currentPage=1&option=${option}&selection=${selection}&minPrice=${minPrice}&maxPrice=${maxPrice}" style="background-color: #339C87; color: white; border-color: #339C87;">&laquo; Đầu</a>
      </li>
    </c:if>

    <c:set var="startPage" value="${currentPage - 4 > 1 ? currentPage - 4 : 1}" />
    <c:set var="endPage" value="${currentPage + 4 < pageNumber ? currentPage + 4 : pageNumber}" />

    <c:forEach begin="${startPage}" end="${endPage}" var="i">
      <li class="page-item ${i == currentPage ? 'active' : ''}">
        <a class="page-link" href="?currentPage=${i}&option=${option}&selection=${selection}&minPrice=${minPrice}&maxPrice=${maxPrice}"
           style="background-color: ${i == currentPage ? '#339C87' : 'white'}; color: ${i == currentPage ? 'white' : '#339C87'}; border-color: #339C87;">
            ${i}
        </a>
      </li>
    </c:forEach>

    <c:if test="${currentPage < pageNumber}">
      <li class="page-item">
        <a class="page-link" href="?currentPage=${pageNumber}&option=${option}&selection=${selection}&minPrice=${minPrice}&maxPrice=${maxPrice}" style="background-color: #339C87; color: white; border-color: #339C87;">Cuối &raquo;</a>
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
<script>
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll('.price-filter').forEach(filter => {
      filter.addEventListener('change', () => {
        if (filter.checked) {
          document.querySelectorAll('.price-filter').forEach(otherFilter => {
            if (otherFilter !== filter) {
              otherFilter.checked = false;
            }
          });
        }

        const selectedFilter = document.querySelector('.price-filter:checked');
        let minPrice = null;
        let maxPrice = null;

        if (selectedFilter) {
          minPrice = selectedFilter.getAttribute('data-min');
          maxPrice = selectedFilter.getAttribute('data-max') === "" ? null : selectedFilter.getAttribute('data-max');
        }

        // Lấy tất cả tham số hiện tại từ URL
        const urlParams = new URLSearchParams(window.location.search);

        // Giữ lại các tham số hiện tại
        const option = urlParams.get('option') || '1';
        const selection = urlParams.get('selection') || 'all';
        const currentPage = urlParams.get('currentPage') || '1';

        // Cập nhật tham số lọc giá
        urlParams.set('isAjax', 'true');
        urlParams.set('option', option);
        urlParams.set('selection', selection);
        urlParams.set('currentPage', currentPage);
        if (minPrice !== null) {
          urlParams.set('minPrice', minPrice);
        } else {
          urlParams.delete('minPrice');
        }
        if (maxPrice !== null) {
          urlParams.set('maxPrice', maxPrice);
        } else {
          urlParams.delete('maxPrice');
        }

        // Gửi AJAX request đến Servlet với tất cả tham số
        fetch('TotalProductsServlet?' + urlParams.toString(), {
          method: 'GET',
        })
                .then(response => response.text()) // Nhận dữ liệu HTML trả về
                .then(html => {
                  document.getElementById('product-list').innerHTML = html; // Cập nhật danh sách sản phẩm
                })
                .catch(error => console.error('Lỗi tải sản phẩm:', error));
        window.location.href = url.toString();
      });

    });
  });



</script>
</body>
</html>