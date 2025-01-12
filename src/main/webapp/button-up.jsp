
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
  </style>
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

                <!-- Form Thêm Vào Giỏ Hàng -->
                <form action="cart?method=add" method="post" class="mt-auto product-options-form">
                  <!-- Hidden Inputs -->
                  <input type="hidden" name="currentURL" value="product-buttonUp?page=${currentPage}&option=${option}<c:if test='${minPrice != null || maxPrice != null}'> &amp;minPrice=${minPrice}&amp;maxPrice=${maxPrice}</c:if>">
                  <input type="hidden" name="productID" value="${product.id}">
                  <input type="hidden" name="selectedStyle" id="selectedStyle${product.id}" value="">

                  <!-- Chọn Style (nếu sản phẩm có nhiều style) -->
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

      <!-- Phân trang -->
      <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-3">
          <!-- Nút Previous -->
          <c:if test="${currentPage > 1}">
            <li class="page-item">
              <a class="page-link" href="<c:url value='product-buttonUp'>
        <c:param name='option' value='${option}'/>
        <c:param name='page' value='${currentPage - 1}'/>
        <c:if test='${minPrice != null || maxPrice != null}'>
          <c:param name='minPrice' value='${minPrice}'/>
          <c:param name='maxPrice' value='${maxPrice}'/>
        </c:if>
      </c:url>">
                &laquo;
              </a>
            </li>
          </c:if>

          <!-- Danh sách số trang -->
          <c:forEach var="i" begin="1" end="${pageNumber}">
            <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
              <a class="page-link" href="<c:url value='product-buttonUp'>
        <c:param name='option' value='${option}'/>
        <c:param name='page' value='${i}'/>
        <c:if test='${minPrice != null || maxPrice != null}'>
          <c:param name='minPrice' value='${minPrice}'/>
          <c:param name='maxPrice' value='${maxPrice}'/>
        </c:if>
      </c:url>">
                  ${i}
              </a>
            </li>
          </c:forEach>

          <!-- Nút Next -->
          <c:if test="${currentPage < pageNumber}">
            <li class="page-item">
              <a class="page-link" href="<c:url value='product-buttonUp'>
        <c:param name='option' value='${option}'/>
        <c:param name='page' value='${currentPage + 1}'/>
        <c:if test='${minPrice != null || maxPrice != null}'>
          <c:param name='minPrice' value='${minPrice}'/>
          <c:param name='maxPrice' value='${maxPrice}'/>
        </c:if>
      </c:url>">
                &raquo;
              </a>
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

<!-- Thêm thẻ thông báo -->
<div class="alert-message alert alert-success" role="alert" id="alert-message">
  <!-- Nội dung thông báo sẽ được thêm bằng JavaScript -->
</div>

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

    // Xử lý nút "Thêm vào giỏ hàng"
    const addToCartButtons = document.querySelectorAll('.add-to-cart-button');
    addToCartButtons.forEach(button => {
      button.addEventListener("click", function () {
        const form = this.closest(".product-options-form");
        const selectedStyleInput = form.querySelector('input[name="selectedStyle"]');
        const quantityContainer = form.querySelector('.quantity-container');
        const submitCartButton = form.querySelector('.submit-cart-button');

        // Kiểm tra nếu đã chọn Style
        if (selectedStyleInput.value) {
          // Hiển thị số lượng và nút "Xác nhận"
          quantityContainer.style.display = "block";
          this.style.display = "none"; // Ẩn nút "Thêm vào giỏ hàng"
          submitCartButton.style.display = "block"; // Hiển thị nút "Xác nhận"
        } else {
          // Hiển thị thông báo yêu cầu chọn Style
          alert("Vui lòng chọn Style trước khi thêm vào giỏ hàng!");
        }
      });
    });

    // Xử lý khi chọn Style
    const styleOptions = document.querySelectorAll('.style-option');
    styleOptions.forEach(option => {
      option.addEventListener("click", function () {
        const form = this.closest(".product-options-form");
        const selectedStyleInput = form.querySelector('input[name="selectedStyle"]');
        const mainImage = form.closest('.product-item').querySelector('.main-product-image'); // Sử dụng relative selector
        const styleId = this.getAttribute('data-style-id');
        const imageUrl = this.getAttribute('data-image-url');

        // Cập nhật Style đã chọn vào input ẩn
        selectedStyleInput.value = styleId;

        // Thay thế hình ảnh trên Card bằng hình ảnh của Style được chọn
        if (mainImage) {
          mainImage.src = imageUrl; // Gán URL ảnh của Style vào ảnh chính
        } else {
          console.error("Không tìm thấy phần tử hình ảnh chính.");
        }

        // Đánh dấu Style được chọn
        form.querySelectorAll('.style-option').forEach(opt => {
          opt.classList.remove('selected');
        });
        this.classList.add('selected');
      });
    });

    // Hiển thị nút Back to Top khi cuộn xuống 300px
    const backToTopButton = document.getElementById("back-to-top");
    window.addEventListener("scroll", () => {
      if (window.scrollY > 300) {
        backToTopButton.classList.add('show');
      } else {
        backToTopButton.classList.remove('show');
      }
    });
    backToTopButton.addEventListener("click", () => {
      window.scrollTo({
        top: 0,
        behavior: "smooth"
      });
    });

    // Hiển thị thông báo khi thêm vào giỏ hàng thành công hoặc lỗi
    const alertMessage = document.getElementById("alert-message");
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('message') === 'success') {
      alertMessage.textContent = "Thêm vào giỏ hàng thành công!";
      alertMessage.classList.remove('alert-success', 'alert-danger');
      alertMessage.classList.add('alert-success');
      alertMessage.style.display = "block";
      setTimeout(() => {
        alertMessage.style.display = "none";
      }, 3000);
    } else if (urlParams.get('message') === 'error') {
      alertMessage.textContent = "Đã xảy ra lỗi khi thêm vào giỏ hàng!";
      alertMessage.classList.remove('alert-success', 'alert-danger');
      alertMessage.classList.add('alert-danger');
      alertMessage.style.display = "block";
      setTimeout(() => {
        alertMessage.style.display = "none";
      }, 3000);
    }
  });
  document.addEventListener("DOMContentLoaded", function () {
    // Hàm định dạng số tiền thành tiền Việt
    function formatCurrency(amount) {
      return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
    }

    // Định dạng giá gốc
    document.querySelectorAll(".price").forEach(el => {
      const originalPrice = el.textContent.trim().replace("VND", "").replace(/,/g, "");
      if (originalPrice) {
        el.textContent = formatCurrency(parseFloat(originalPrice));
      }
    });
  });
</script>
</body>
</html>
