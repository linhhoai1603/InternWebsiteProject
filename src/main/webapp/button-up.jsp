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

<c:if test="${buttonUp == null}">
  <script>
    window.location.href = "product-buttonUp";
  </script>
</c:if>

<div class="container my-5">
  <div class="row">
    <!-- Sidebar bộ lọc -->
    <div class="col-md-3">
      <h5>Giá</h5>

      <!-- Dưới 10.000đ -->
      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price1" data-min="0" data-max="10000"
               <c:if test="${minPrice != null && minPrice == 0 && maxPrice == 10000}">checked</c:if> >
        <label class="form-check-label" for="price1">Dưới 10.000đ</label>
      </div>

      <!-- 10.000đ - 20.000đ -->
      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price2" data-min="10000" data-max="20000"
               <c:if test="${minPrice != null && minPrice == 10000 && maxPrice == 20000}">checked</c:if> >
        <label class="form-check-label" for="price2">10.000đ - 20.000đ</label>
      </div>

      <!-- 20.000đ - 50.000đ -->
      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price3" data-min="20000" data-max="50000"
               <c:if test="${minPrice != null && minPrice == 20000 && maxPrice == 50000}">checked</c:if> >
        <label class="form-check-label" for="price3">20.000đ - 50.000đ</label>
      </div>

      <!-- 50.000đ - 100.000đ -->
      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price4" data-min="50000" data-max="100000"
               <c:if test="${minPrice != null && minPrice == 50000 && maxPrice == 100000}">checked</c:if> >
        <label class="form-check-label" for="price4">50.000đ - 100.000đ</label>
      </div>

      <!-- Trên 100.000đ -->
      <div class="form-check mb-2">
        <input class="form-check-input price-filter" type="checkbox" id="price5" data-min="100000" data-max=""
               <c:if test="${minPrice != null && minPrice == 100000 && maxPrice == null}">checked</c:if> >
        <label class="form-check-label" for="price5">Trên 100.000đ</label>
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
            <li><a class="dropdown-item" href="product-buttonUp?option=1&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Mới nhất</a></li>
            <li><a class="dropdown-item" href="product-buttonUp?option=2&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Giá: Cao -> Thấp</a></li>
            <li><a class="dropdown-item" href="product-buttonUp?option=3&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Giá: Thấp -> Cao</a></li>
            <li><a class="dropdown-item" href="product-buttonUp?option=4&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Bán chạy nhất</a></li>
            <li><a class="dropdown-item" href="product-buttonUp?option=5&page=1<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">Giảm giá: Cao -> Thấp</a></li>
          </ul>
        </div>
      </div>

      <!-- Danh sách sản phẩm -->
      <div class="row product-container">
        <c:forEach var="product" items="${buttonUp}">
          <div class="col-md-4 mb-4">
            <div class="card product-item position-relative h-100">
              <!-- Thẻ hiển thị giảm giá -->
              <c:if test="${product.price.discountPercent > 0}">
                <span class="badge bg-danger position-absolute top-0 end-0 m-2 px-3 py-2 fs-5 product-discount">
                  -<fmt:formatNumber value="${product.price.discountPercent}" pattern="##0" />%
                </span>
              </c:if>
              <img src="${product.image}" class="card-img-top h-50" alt="Hình ảnh sản phẩm" style="object-fit: cover;">
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
                <p class="cart-text">Mô tả: ${product.description}</p>
                <div class="mt-auto">
                  <a href="detail-product?productId=${product.id}" class="btn btn-warning w-100 mb-2">Thêm vào giỏ hàng</a>
                  <a href="detail-product?productId=${product.id}" class="btn btn-primary w-100">Xem ngay</a>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>

      <!-- Phân trang -->
      <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-3">
          <!-- Nút Previous -->
          <c:if test="${currentPage > 1}">
            <li class="page-item">
              <a class="page-link" href="product-buttonUp?option=${option}&page=${currentPage - 1}<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>"> << </a>
            </li>
          </c:if>

          <!-- Các trang -->
          <c:forEach var="i" begin="1" end="${pageNumber}">
            <li class="page-item ${i == currentPage ? 'active' : ''}">
              <a class="page-link" href="product-buttonUp?option=${option}&page=${i}<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">${i}</a>
            </li>
          </c:forEach>

          <!-- Nút Next -->
          <c:if test="${currentPage < pageNumber}">
            <li class="page-item">
              <a class="page-link" href="product-buttonUp?option=${option}&page=${currentPage + 1}<c:if test='${minPrice != null || maxPrice != null}'>&amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>"> >> </a>
            </li>
          </c:if>
        </ul>
      </nav>
    </div>
  </div>
</div>

<!-- Nút Back to Top -->
<button id="back-to-top" class="back-to-top">
  <i class="fas fa-arrow-up"></i>
</button>

<c:import url="includes/footer.jsp" />
<c:import url="includes/link/footLink.jsp" />

<!-- JavaScript đã được cập nhật -->
<script>
  document.addEventListener("DOMContentLoaded", function () {
    // Xử lý lọc giá
    document.querySelectorAll('.price-filter').forEach(filter => {
      filter.addEventListener('change', () => {
        if (filter.checked) {
          // Bỏ chọn tất cả các checkbox khác
          document.querySelectorAll('.price-filter').forEach(otherFilter => {
            if (otherFilter !== filter) {
              otherFilter.checked = false;
            }
          });
        }

        // Lấy checkbox được chọn
        const selectedFilter = Array.from(document.querySelectorAll('.price-filter:checked'))[0];
        let minPrice = null;
        let maxPrice = null;

        if (selectedFilter) {
          minPrice = parseFloat(selectedFilter.getAttribute('data-min'));
          maxPrice = selectedFilter.getAttribute('data-max') === "" ? null : parseFloat(selectedFilter.getAttribute('data-max'));
        }

        const url = new URL(window.location.href);
        if (minPrice !== null) {
          url.searchParams.set('minPrice', minPrice);
        } else {
          url.searchParams.delete('minPrice');
        }
        if (maxPrice !== null) {
          url.searchParams.set('maxPrice', maxPrice);
        } else {
          url.searchParams.delete('maxPrice');
        }

        // Reset về trang đầu khi lọc
        url.searchParams.set('page', 1);
        window.location.href = url.toString();
      });
    });

    // Hàm định dạng giá tiền (nếu cần)
    function formatCurrency(amount) {
      return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
    }
  });
</script>
</body>
</html>

