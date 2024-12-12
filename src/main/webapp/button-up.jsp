<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 2:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp"%>
<html>
<head>
    <title>Nút áo</title>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/button_up.css">

<!-- Container chính -->
<div class="container mt-3">
  <!-- Breadcrumb -->

  <div class="row">
    <!-- Sidebar -->
    <div class="col-md-3">
      <div class="sidebar">
        <h5>Giá</h5>
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  id="price1"
                  type="checkbox"
                  data-min="0"
                  data-max="10000"
          />
          <label class="form-check-label" for="price1">Dưới 10.000đ</label>
        </div>
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  id="price2"
                  type="checkbox"
                  data-min="10000"
                  data-max="20000"
          />
          <label class="form-check-label" for="price2"
          >10.000đ - 20.000đ</label
          >
        </div>
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  id="price3"
                  type="checkbox"
                  data-min="20000"
                  data-max="50000"
          />
          <label class="form-check-label" for="price3"
          >20.000đ - 50.000đ</label
          >
        </div>
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  id="price4"
                  type="checkbox"
                  data-min="50000"
                  data-max="100000"
          />
          <label class="form-check-label" for="price4"
          >50.000đ - 100.000đ</label
          >
        </div>
        <div class="form-check mb-2">
          <input
                  class="form-check-input price-filter"
                  id="price5"
                  type="checkbox"
                  data-min="100000"
                  data-max=""
          />
          <label class="form-check-label" for="price5">Trên 100.000đ</label>
        </div>
        <div class="form-check mb-2">
          <input
                  class="form-check-input brand-filter"
                  id="brand2"
                  type="checkbox"
                  data-brand="StyleButtons"
          />
          <label class="form-check-label" for="brand2">StyleButtons</label>
        </div>
        <div class="form-check mb-2">
          <input
                  class="form-check-input brand-filter"
                  id="brand3"
                  type="checkbox"
                  data-brand="ElegantButtons"
          />
          <label class="form-check-label" for="brand3"
          >ElegantButtons</label
          >
        </div>
      </div>
    </div>
    <!-- Nội dung chính -->
    <div class="col-md-9">
      <!-- Header Controls: Title, Sort, Pagination -->
      <div
              class="d-flex justify-content-between align-items-center mb-3 header-controls"
      >
        <div class="header-left">
          <h5 class="mb-0">Phụ Kiện Nút Áo Cao Cấp</h5>
        </div>
        <div class="header-right d-flex align-items-center">
          <!-- Loại bỏ view-toggle -->
          <select class="form-select d-inline-block w-auto" id="sortSelect">
            <option value="newest" selected>Mới Nhất</option>
            <option value="best-selling">Bán chạy Nhất</option>
            <option value="price-asc">Từ thấp đến cao</option>
            <option value="price-desc">Từ cao đến thấp</option>
          </select>
          <!-- Phân trang ở trên bên phải -->
          <nav aria-label="Page navigation example" class="ms-3">
            <ul class="pagination mb-0" id="paginationTop">
              <li class="page-item disabled" data-page="prev">
                <a
                        class="page-link"
                        href="#"
                        tabindex="-1"
                        aria-disabled="true"
                >Trước</a
                >
              </li>
              <li
                      class="page-item active"
                      aria-current="page"
                      data-page="1"
              >
                <a class="page-link" href="#">1</a>
              </li>
              <li class="page-item" data-page="2">
                <a class="page-link" href="#">2</a>
              </li>
              <li class="page-item" data-page="3">
                <a class="page-link" href="#">3</a>
              </li>
              <li class="page-item" data-page="next">
                <a class="page-link" href="#">Sau</a>
              </li>
            </ul>
          </nav>
        </div>
      </div>

      <!-- Product Grid -->
      <div class="row product-grid">
        <!-- Sản phẩm 1 -->
        <div class="col-md-4 mb-4" data-price="8000" data-brand="ButtonPro" data-date="2024-04-01" data-sales="150">
          <div class="card h-100">
            <img
                    src="images/nutaothantienmautrang.jpg"
                    class="card-img-top"
                    alt="Nút Áo Thần Tiên - Màu Trắng"
            />
            <!-- Các nút Thêm vào Giỏ và Yêu Thích -->
            <div class="card-actions">
              <button class="btn btn-add-to-cart" title="Thêm vào giỏ">
                <i class="fas fa-shopping-cart"></i>
              </button>
              <button class="btn btn-favorite" title="Yêu thích">
                <i class="fas fa-heart"></i>
              </button>
            </div>
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Nút Áo Thần Tiên - Màu Trắng</h5>
              <p class="card-text description">
                Nút áo chất liệu cao cấp, bền bỉ, phù hợp cho mọi loại trang
                phục.
              </p>
              <div class="pricing mt-auto">
                <span class="discount-badge">-10%</span>
                <span class="discounted-price">8,000đ</span>
                <span class="original-price">8,888đ</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Sản phẩm 2 -->
        <div
                class="col-md-4 mb-4"
                data-price="12000"
                data-brand="StyleButtons"
                data-date="2024-03-15"
                data-sales="200"
        >
          <div class="card h-100">
            <img
                    src="images/nutaostyleblue.jpg"
                    class="card-img-top"
                    alt="Nút Áo Style - Màu Xanh Dương"
            />
            <div class="card-actions">
              <button class="btn btn-add-to-cart" title="Thêm vào giỏ">
                <i class="fas fa-shopping-cart"></i>
              </button>
              <button class="btn btn-favorite" title="Yêu thích">
                <i class="fas fa-heart"></i>
              </button>
            </div>
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Nút Áo Style - Màu Xanh Dương</h5>
              <p class="card-text description">
                Nút áo thiết kế hiện đại, đa màu sắc, phù hợp với nhiều
                phong cách.
              </p>
              <div class="pricing mt-auto">
                <span class="discount-badge">-15%</span>
                <span class="discounted-price">12,000đ</span>
                <span class="original-price">14,117đ</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Sản phẩm 3 -->
        <div
                class="col-md-4 mb-4"
                data-price="15000"
                data-brand="ElegantButtons"
                data-date="2024-02-20"
                data-sales="250"
        >
          <div class="card h-100">
            <img
                    src="images/nutaoelegantred.jpg"
                    class="card-img-top"
                    alt="Nút Áo Elegant - Màu Đỏ"
            />
            <div class="card-actions">
              <button class="btn btn-add-to-cart" title="Thêm vào giỏ">
                <i class="fas fa-shopping-cart"></i>
              </button>
              <button class="btn btn-favorite" title="Yêu thích">
                <i class="fas fa-heart"></i>
              </button>
            </div>
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Nút Áo Elegant - Màu Đỏ</h5>
              <p class="card-text description">
                Nút áo sang trọng, thiết kế tinh tế, phù hợp cho các dịp đặc
                biệt.
              </p>
              <div class="pricing mt-auto">
                <span class="discount-badge">-20%</span>
                <span class="discounted-price">15,000đ</span>
                <span class="original-price">18,750đ</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Sản phẩm 4 -->
        <div class="col-md-4 mb-4" data-price="5000" data-brand="ButtonPro" data-date="2024-05-10" data-sales="100">
          <div class="card h-100">
            <img
                    src="images/nutaothanhtheocochai.jpg"
                    class="card-img-top"
                    alt="Nút Áo Thánh Thiểu - Cổ Chai"
            />
            <div class="card-actions">
              <button class="btn btn-add-to-cart" title="Thêm vào giỏ">
                <i class="fas fa-shopping-cart"></i>
              </button>
              <button class="btn btn-favorite" title="Yêu thích">
                <i class="fas fa-heart"></i>
              </button>
            </div>
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Nút Áo Thánh Thiểu - Cổ Chai</h5>
              <p class="card-text description">
                Nút áo cổ chai, phù hợp với các loại áo sơ mi cổ điển.
              </p>
              <div class="pricing mt-auto">
                <span class="discount-badge">-5%</span>
                <span class="discounted-price">5,000đ</span>
                <span class="original-price">5,263đ</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Sản phẩm 5 -->
        <div
                class="col-md-4 mb-4"
                data-price="7000"
                data-brand="StyleButtons"
                data-date="2024-04-18"
                data-sales="180"
        >
          <div class="card h-100">
            <img
                    src="images/nutaostylexanhla.jpg"
                    class="card-img-top"
                    alt="Nút Áo Style - Màu Xanh Lá"
            />
            <div class="card-actions">
              <button class="btn btn-add-to-cart" title="Thêm vào giỏ">
                <i class="fas fa-shopping-cart"></i>
              </button>
              <button class="btn btn-favorite" title="Yêu thích">
                <i class="fas fa-heart"></i>
              </button>
            </div>
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Nút Áo Style - Màu Xanh Lá</h5>
              <p class="card-text description">
                Nút áo màu xanh lá, tạo điểm nhấn cho trang phục hàng ngày.
              </p>
              <div class="pricing mt-auto">
                <span class="discount-badge">-10%</span>
                <span class="discounted-price">7,000đ</span>
                <span class="original-price">7,778đ</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Sản phẩm 6 -->
        <div
                class="col-md-4 mb-4"
                data-price="9000"
                data-brand="ElegantButtons"
                data-date="2024-03-25"
                data-sales="220"
        >
          <div class="card h-100">
            <img
                    src="images/nutaoelexanhduong.jpg"
                    class="card-img-top"
                    alt="Nút Áo Elegant - Màu Xanh Dương"
            />
            <div class="card-actions">
              <button class="btn btn-add-to-cart" title="Thêm vào giỏ">
                <i class="fas fa-shopping-cart"></i>
              </button>
              <button class="btn btn-favorite" title="Yêu thích">
                <i class="fas fa-heart"></i>
              </button>
            </div>
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Nút Áo Elegant - Màu Xanh Dương</h5>
              <p class="card-text description">
                Nút áo màu xanh dương, phong cách và hiện đại cho mọi loại
                áo.
              </p>
              <div class="pricing mt-auto">
                <span class="discount-badge">-15%</span>
                <span class="discounted-price">9,000đ</span>
                <span class="original-price">10,588đ</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Sản phẩm 7 -->
        <div
                class="col-md-4 mb-4"
                data-price="11000"
                data-brand="ButtonPro"
                data-date="2024-02-05"
                data-sales="300"
        >
          <div class="card h-100">
            <img
                    src="images/nutaothanthietmauvang.jpg"
                    class="card-img-top"
                    alt="Nút Áo Thần Thiết - Màu Vàng"
            />
            <div class="card-actions">
              <button class="btn btn-add-to-cart" title="Thêm vào giỏ">
                <i class="fas fa-shopping-cart"></i>
              </button>
              <button class="btn btn-favorite" title="Yêu thích">
                <i class="fas fa-heart"></i>
              </button>
            </div>
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Nút Áo Thần Thiết - Màu Vàng</h5>
              <p class="card-text description">
                Nút áo màu vàng, nổi bật và thu hút ánh nhìn cho trang phục.
              </p>
              <div class="pricing mt-auto">
                <span class="discount-badge">-20%</span>
                <span class="discounted-price">11,000đ</span>
                <span class="original-price">13,750đ</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Sản phẩm 8 -->
        <div
                class="col-md-4 mb-4"
                data-price="6000"
                data-brand="StyleButtons"
                data-date="2024-04-10"
                data-sales="130"
        >
          <div class="card h-100">
            <img
                    src="images/nutaomaubac.jpg"
                    class="card-img-top"
                    alt="Nút Áo Style - Màu Bạc"
            />
            <div class="card-actions">
              <button class="btn btn-add-to-cart" title="Thêm vào giỏ">
                <i class="fas fa-shopping-cart"></i>
              </button>
              <button class="btn btn-favorite" title="Yêu thích">
                <i class="fas fa-heart"></i>
              </button>
            </div>
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Nút Áo Style - Màu Bạc</h5>
              <p class="card-text description">
                Nút áo màu bạc, tinh tế và thanh lịch cho trang phục công
                sở.
              </p>
              <div class="pricing mt-auto">
                <span class="discount-badge">-5%</span>
                <span class="discounted-price">6,000đ</span>
                <span class="original-price">6,316đ</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Sản phẩm 16 -->
        <div
                class="col-md-4 mb-4"
                data-price="16000"
                data-brand="ElegantButtons"
                data-date="2024-04-12"
                data-sales="240"
        >
          <div class="card h-100">
            <img
                    src="images/nutaothanhtheoocochai4.jpg"
                    class="card-img-top"
                    alt="Nút Áo Thần Thiết - Cổ Chai 4"
            />
            <div class="card-actions">
              <button class="btn btn-add-to-cart" title="Thêm vào giỏ">
                <i class="fas fa-shopping-cart"></i>
              </button>
              <button class="btn btn-favorite" title="Yêu thích">
                <i class="fas fa-heart"></i>
              </button>
            </div>
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Nút Áo Thần Thiết - Cổ Chai 4</h5>
              <p class="card-text description">
                Nút áo màu trắng, tinh tế và phù hợp với các loại áo formal.
              </p>
              <div class="pricing mt-auto">
                <span class="discount-badge">-20%</span>
                <span class="discounted-price">16,000đ</span>
                <span class="original-price">20,000đ</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Phân trang ở dưới bên phải -->
      <nav aria-label="Page navigation example" class="mt-3">
        <ul class="pagination" id="paginationBottom">
          <li class="page-item disabled" data-page="prev">
            <a class="page-link" href="#" tabindex="-1" aria-disabled="true"
            >Trước</a
            >
          </li>
          <li class="page-item active" aria-current="page" data-page="1">
            <a class="page-link" href="#">1</a>
          </li>
          <li class="page-item" data-page="2">
            <a class="page-link" href="#">2</a>
          </li>
          <li class="page-item" data-page="3">
            <a class="page-link" href="#">3</a>
          </li>
          <li class="page-item" data-page="next">
            <a class="page-link" href="#">Sau</a>
          </li>
        </ul>
      </nav>
    </div>
  </div>
</div>
<!-- Nút Back to Top -->
<button id="back-to-top" class="back-to-top">
  <i class="fas fa-arrow-up"></i>
</button>
<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>
