<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <title>Các mẫu thiết kế</title>
  <link rel="stylesheet" href="css/zipstar-product.css">

  <!-- CSS tùy biến -->
  <style>
    /* Bo tròn card và bỏ hiệu ứng hover */
    .card {
      border-radius: 10px;
      box-shadow: 0 0 8px rgba(0,0,0,0.1);
      /* BỎ hiệu ứng hover (di chuyển và đổ bóng) bằng cách comment hoặc xóa đoạn dưới:
      .card:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 12px rgba(0,0,0,0.15);
      }
      */
    }

    /* Cố định chiều cao ảnh (nếu muốn) */
    .card-img-top {
      object-fit: cover;
      border-radius: 10px 10px 0 0;
      height: 200px;
    }


    /* Sidebar filter */
    .sidebar {
      background-color: #f8f9fa;
      padding: 1rem;
      border-radius: 8px;
    }
    .quantity-container {
      margin-top: 0.5rem;
      transition: all 0.3s ease;
    }

    /* Nút Back to Top */
    .back-to-top {
      position: fixed;
      bottom: 20px;
      right: 20px;
      display: none;
      font-size: 20px;
      background-color: #007bff;
      color: #fff;
      width: 45px;
      height: 45px;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      align-items: center;
      justify-content: center;
      z-index: 999;
    }
    .back-to-top:hover {
      background-color: #0056b3;
    }
  </style>
</head>

<body>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<!-- Kiểm tra nếu không có dữ liệu, chuyển hướng -->
<c:if test="${zippers == null}">
  <script>
    window.location.href = "product-zippers";
  </script>
</c:if>

<!-- Container chính -->
<div class="container-fluid mt-3">

  <div class="row">
    <!-- Sidebar (Bộ lọc giá) -->
    <div class="col-md-3 mb-3">
      <div class="sidebar">
        <h5 class="mb-3">Lọc theo giá</h5>
        <!-- Dưới 10.000đ -->
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  type="checkbox"
                  id="price1"
                  data-min="0"
                  data-max="10000"
                  <c:if test="${minPrice != null && minPrice == 0 && maxPrice == 10000}">checked</c:if>
          />
          <label class="form-check-label" for="price1">Dưới 10.000đ</label>
        </div>
        <!-- 10.000đ - 20.000đ -->
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  type="checkbox"
                  id="price2"
                  data-min="10000"
                  data-max="20000"
                  <c:if test="${minPrice != null && minPrice == 10000 && maxPrice == 20000}">checked</c:if>
          />
          <label class="form-check-label" for="price2">10.000đ - 20.000đ</label>
        </div>
        <!-- 20.000đ - 50.000đ -->
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  type="checkbox"
                  id="price3"
                  data-min="20000"
                  data-max="50000"
                  <c:if test="${minPrice != null && minPrice == 20000 && maxPrice == 50000}">checked</c:if>
          />
          <label class="form-check-label" for="price3">20.000đ - 50.000đ</label>
        </div>
        <!-- 50.000đ - 100.000đ -->
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  type="checkbox"
                  id="price4"
                  data-min="50000"
                  data-max="100000"
                  <c:if test="${minPrice != null && minPrice == 50000 && maxPrice == 100000}">checked</c:if>
          />
          <label class="form-check-label" for="price4">50.000đ - 100.000đ</label>
        </div>
        <!-- Trên 100.000đ -->
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  type="checkbox"
                  id="price5"
                  data-min="100000"
                  data-max=""
                  <c:if test="${minPrice != null && minPrice == 100000 && maxPrice == null}">checked</c:if>
          />
          <label class="form-check-label" for="price5">Trên 100.000đ</label>
        </div>
      </div>
    </div>
    <!-- End Sidebar -->

    <!-- Nội dung chính -->
    <div class="col-md-9">
      <!-- Header Controls: Title, Sort -->
      <div class="d-flex justify-content-between align-items-center mb-3 header-controls">
        <div class="header-left">
          <h4 class="mb-0 text-uppercase fw-bold">Phụ Kiện Dây Kéo Cao Cấp</h4>
        </div>
        <div class="header-right d-flex align-items-center">
          <!-- Dropdown để chọn cách sắp xếp -->
          <select class="form-select d-inline-block w-auto" id="sortSelect">
            <option value="newest"       <c:if test="${option == 1}">selected</c:if>>Mới Nhất</option>
            <option value="best-sellers" <c:if test="${option == 4}">selected</c:if>>Bán chạy nhất</option>
            <option value="price-asc"    <c:if test="${option == 3}">selected</c:if>>Từ thấp đến cao</option>
            <option value="price-desc"   <c:if test="${option == 2}">selected</c:if>>Từ cao đến thấp</option>
          </select>
        </div>
      </div>

      <!-- Product Grid -->
      <div class="row product-grid">
        <c:forEach var="product" items="${zippers}">
          <div class="col-md-4 mb-4">
            <div class="card position-relative h-100">
              <!-- Thẻ hiển thị giảm giá -->
              <c:if test="${product.price.discountPercent > 0}">
                <span class="badge bg-danger position-absolute top-0 end-0 m-2 px-3 py-2 fs-6 product-discount">
                  -<fmt:formatNumber value="${product.price.discountPercent}" pattern="##0"/>%
                </span>
              </c:if>

              <!-- Hình ảnh sản phẩm -->
              <c:choose>
                <c:when test="${not empty product.image}">
                  <img
                          src="${product.image}"
                          class="card-img-top"
                          alt="${product.name}"
                          onerror="this.onerror=null; this.src='https://via.placeholder.com/200x200?text=No+Image';"
                  />
                </c:when>
                <c:otherwise>
                  <img
                          src="https://via.placeholder.com/200x200?text=No+Image"
                          class="card-img-top"
                          alt="${product.name}"
                  />
                </c:otherwise>
              </c:choose>

              <!-- BẮT ĐẦU FORM thêm vào giỏ -->
              <form action="cart?method=add" method="post" class="h-100 d-flex flex-column justify-content-between">
                <!-- Input ẩn để gửi ID sản phẩm -->
                <input type="hidden" name="productID" value="${product.id}">

                <div class="card-body d-flex flex-column">
                  <h5 class="card-title">${product.name}</h5>
                  <p class="card-text description">${product.description}</p>
                  <div class="pricing mt-auto">
                    <c:if test="${product.price.discountPercent > 0}">
                      <span class="badge bg-danger me-2">
                        -<fmt:formatNumber value="${product.price.discountPercent}" pattern="##0"/>%
                      </span>
                    </c:if>
                    <span class="text-success fw-bold me-2">
                      <fmt:formatNumber value="${product.price.lastPrice}" type="currency" currencySymbol="₫"/>
                    </span>
                    <c:if test="${product.price.discountPercent > 0}">
                      <span class="text-muted text-decoration-line-through">
                        <fmt:formatNumber value="${product.price.price}" type="currency" currencySymbol="₫"/>
                      </span>
                    </c:if>
                  </div>

                  <!-- Trường Số lượng (ẩn lúc đầu) -->
                  <div class="quantity-container" style="display: none;">
                    <label for="quantity${product.id}" class="fw-bold d-block mt-2">Số lượng:</label>
                    <input
                            type="number"
                            name="quantity"
                            id="quantity${product.id}"
                            class="form-control"
                            min="1"
                            value="1"
                    >
                  </div>
                </div>

                <!-- Khu vực nút ở dưới cùng của card -->
                <div class="p-3">
                  <!-- Nút hiển thị trường Số lượng -->
                  <button
                          type="button"
                          class="btn btn-warning w-100 mb-2 add-to-cart-button"
                  >
                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                  </button>
                  <!-- Nút Xác nhận (submit form) -->
                  <button
                          type="submit"
                          class="btn btn-success w-100 submit-cart-button"
                          style="display: none;"
                  >
                    Xác nhận
                  </button>

                  <!-- Nút Xem Ngay (link sang chi tiết) -->
                  <a
                          href="detail-product?id=${product.id}"
                          class="btn btn-primary w-100 mt-2"
                  >
                    Xem Ngay
                  </a>
                </div>
              </form>
              <!-- KẾT THÚC FORM -->
            </div>
          </div>
        </c:forEach>
      </div>
      <!-- End Product Grid -->

      <!-- Phân trang -->
      <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-3">
          <!-- Nút Previous -->
          <c:if test="${currentPage > 1}">
            <li class="page-item">
              <a class="page-link"
                 href="product-zippers?option=${option}&page=${currentPage - 1}
                   <c:if test='${minPrice != null || maxPrice != null}'>
                     &amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}
                   </c:if>"
              >
                Trước
              </a>
            </li>
          </c:if>

          <!-- Các trang -->
          <c:forEach var="i" begin="1" end="${pageNumber}">
            <li class="page-item ${i == currentPage ? 'active' : ''}">
              <a class="page-link"
                 href="product-zippers?option=${option}&page=${i}
                   <c:if test='${minPrice != null || maxPrice != null}'>
                     &amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}
                   </c:if>"
              >
                  ${i}
              </a>
            </li>
          </c:forEach>

          <!-- Nút Next -->
          <c:if test="${currentPage < pageNumber}">
            <li class="page-item">
              <a class="page-link"
                 href="product-zippers?option=${option}&page=${currentPage + 1}
                   <c:if test='${minPrice != null || maxPrice != null}'>
                     &amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}
                   </c:if>"
              >
                Sau
              </a>
            </li>
          </c:if>
        </ul>
      </nav>

    </div>
  </div>
</div>
<!-- End Container chính -->

<!-- Nút Back to Top -->
<button id="back-to-top" class="back-to-top d-flex">
  <i class="fas fa-arrow-up m-auto"></i>
</button>

<%@ include file="includes/footer.jsp" %>
<%@ include file="includes/link/footLink.jsp" %>

<!-- JavaScript đã được cập nhật -->
<script>
  document.addEventListener("DOMContentLoaded", function () {
    // 1. Xử lý lọc giá
    document.querySelectorAll('.price-filter').forEach(filter => {
      filter.addEventListener('change', () => {
        if (filter.checked) {
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

        // Reset về trang đầu
        url.searchParams.set('page', 1);
        window.location.href = url.toString();
      });
    });

    // 2. Xử lý sắp xếp
    const sortSelect = document.getElementById('sortSelect');
    sortSelect.addEventListener('change', function () {
      const selectedOption = this.value;
      let optionValue = 0; // Giá trị mặc định

      switch (selectedOption) {
        case 'newest':
          optionValue = 1; break;
        case 'best-sellers':
          optionValue = 4; break;
        case 'price-asc':
          optionValue = 3; break;
        case 'price-desc':
          optionValue = 2; break;
      }

      const url = new URL(window.location.href);
      url.searchParams.set('option', optionValue);
      url.searchParams.set('page', 1);
      window.location.href = url.toString();
    });

    // 3. Hiển thị/ẩn trường Số lượng khi nhấn "Thêm vào giỏ"
    const addToCartButtons = document.querySelectorAll(".add-to-cart-button");
    addToCartButtons.forEach(button => {
      button.addEventListener("click", function () {
        const card = this.closest(".card");
        const quantityContainer = card.querySelector(".quantity-container");
        const submitCartButton = card.querySelector(".submit-cart-button");

        // Hiển thị input số lượng, ẩn nút "Thêm vào giỏ", hiện nút "Xác nhận"
        quantityContainer.style.display = "block";
        this.style.display = "none";
        submitCartButton.style.display = "block";
      });
    });

    // 4. Nút Back to Top
    const backToTopBtn = document.getElementById("back-to-top");
    window.addEventListener("scroll", () => {
      if (window.scrollY > 200) {
        backToTopBtn.style.display = "flex";
      } else {
        backToTopBtn.style.display = "none";
      }
    });
    backToTopBtn.addEventListener("click", () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  });
</script>
</body>
</html>
