<%@ page import="models.Product" %><%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 2:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Vải may mặc</title>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/garment-product.css">
<style>

  /* Container for style selection */
  .product-style-label {
    display: inline-block;
    cursor: pointer;
    padding: 5px;
    border: 2px solid #ccc;
    transition: border-color 0.3s ease, transform 0.3s ease;
  }

  /* Hover effect on style selection */
  .product-style-label:hover {
    border-color: #339C87;
    transform: scale(1.05);
  }

  /* Highlight selected style */
  .product-style-label.selected {
    border-color: #339C87;
    background-color: #e8f9f5;
  }

  /* Style image (displayed in the style selection) */
  .product-style-image {
    width: 60px;
    height: 60px;
    border-radius: 5px;
    border: 2px solid #ccc;
    padding: 2px;
    transition: transform 0.3s ease;
  }

  /* Hover effect for style images */
  .product-style-image:hover {
    transform: scale(1.1);
  }

  /* Active effect for selected style image */
  .product-style-label.selected .product-style-image {
    border-color: #339C87;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  }



</style>
<div class="container mt-1">

  <div class="row " id="product-container" style="margin-bottom: 50px ;margin-top: 50px">
    <div class="col-6">
      <img src="images/maymac1.png" style="width: 100%; height: 100%; object-fit: cover;" alt="mayMac" class="img-fluid">
    </div>

    <div class="col-6">
      <div class="title-product text-center mb-4">
        <h2>May mặc tại thời trang</h2>
      </div>

      <div class="row">
        <c:if test="${empty requestScope.garment}">
          <h1>Không có sản phẩm</h1>
        </c:if>
        <c:forEach begin="0" end="5" items="${requestScope.garment}" var="p">
          <div class="col-4 products-section" onclick="showDetailProduct(${p.id})">
            <div class="card product-card">
              <div class="position-relative">
                <img src="${p.image}" class="card-img-top" alt="Sản phẩm" style="object-fit: cover; height: 200px;">
                <div class="product-buttons position-absolute start-50 translate-middle">
                  <button class="btn" data-bs-toggle="modal" data-bs-target="#orderDetailsModal${p.id}">
                    <i class="fas fa-shopping-cart"></i>
                  </button>
                  <button class="btn" ><a style="color: white !important;text-decoration: none;font-weight: bold;" href="detail-product?productId=${p.id}">Xem</a></button>
                </div>
              </div>
              <div class="card-body text-center">
                <h5 class="card-title">${p.name}</h5>
                <p class="card-text">
                <div class="price-container">
                  <span style="font-weight: bold; color: #339C87; font-size: 16px;">Giá</span>
                  <span class="text-decoration-line-through small" style="color: #555; font-size: 0.9em;">
              <fmt:formatNumber value="${p.price.price}" type="number" />
            </span>
                  <strong class="small" style="color: #339C87;">
                    <fmt:formatNumber value="${p.price.lastPrice}" type="number" />₫
                  </strong>
                </div>
                <div class="text-danger small">
                  <strong>Giảm ${p.price.discountPercent}%</strong>
                </div>
                </p>
              </div>
            </div>
          </div>

          <!-- Modal for this specific product -->
          <div class="modal fade" id="orderDetailsModal${p.id}" tabindex="-1" aria-labelledby="orderDetailsModalLabel${p.id}" aria-hidden="true">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="orderDetailsModalLabel${p.id}">Chi tiết sản phẩm</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <div class="row">
                    <!-- Image Carousel Section -->
                    <div class="col-md-6">
                      <img src="${p.image}" class="d-block w-100" alt="Product Image 3">
                    </div>
                    <div class="col-md-6">
                      <h3 class="text" style="color: #008080">${p.name}</h3>
                      <p class="h4 text-decoration-line-through text-warning">
                        <fmt:formatNumber value="${p.price.price}" type="number" />₫
                      </p>
                      <p class="h2 text-danger fw-bold">
                        <fmt:formatNumber value="${p.price.lastPrice}" type="number" />₫
                      </p>
                      <form action="cart?method=add" method="post">
                        <input name="currentURL" type="hidden" value="may-mac?loca=${requestScope.loca}">
                        <div class="mb-3">
                          <p class="fw-bold">Kiểu vải </p>
                          <div class="d-flex gap-2">
                            <c:forEach var="style" items="${p.styles}">
                              <input type="hidden" name="productID" value="${p.id}">
                              <label for="style${style.id}" class="product-style-label" style="margin: 5px;">
                                <input
                                        type="radio"
                                        name="selectedStyle"
                                        id="style${style.id}"
                                        value="${style.id}"
                                        required
                                        style="display: none;">
                                <img
                                        src="${style.image}"
                                        alt="${style.name}"
                                        class="product-style-image rounded"
                                        style="width: 60px; height: 60px; border: 2px solid #ccc; padding: 2px;">
                              </label>
                          </c:forEach>
                          </div>
                        </div>
                        <p class="fw-bold">Số lượng </p>
                        <div class="row">
                          <div class="col-6">
                            <div class="input-group">
                              <input type="number" id="quantity-${p.id}" name="quantity" class="form-control text-center quantity-input" value="1" style="max-width: 100px" min="1">
                            </div>
                          </div>
                        </div>
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
        </c:forEach>
      </div>
  </div>
</div>
  <div class="row " id="product-container" style="margin-bottom: 50px ;margin-top: 50px">


    <div class="col-6">
      <div class="title-product text-center mb-4">
        <h2>May mặc cơ bản </h2>
      </div>

      <div class="row">
        <c:if test="${empty requestScope.garment}">
          <h1>Không có sản phẩm</h1>
        </c:if>
        <c:forEach begin="6" end="11" items="${requestScope.garment}" var="p">
          <div class="col-4 products-section" onclick="showDetailProduct(${p.id})">
            <div class="card product-card">
              <div class="position-relative">
                <img src="${p.image}" class="card-img-top" alt="Sản phẩm" style="object-fit: cover; height: 200px;">
                <div class="product-buttons position-absolute start-50 translate-middle">
                  <button class="btn" data-bs-toggle="modal" data-bs-target="#orderDetailsModal${p.id}">
                    <i class="fas fa-shopping-cart"></i>
                  </button>
                  <button class="btn" ><a style="color: white !important;text-decoration: none;font-weight: bold; " href="detail-product?productId=${p.id}">Xem</a></button>
                </div>
              </div>
              <div class="card-body text-center">
                <h5 class="card-title">${p.name}</h5>
                <p class="card-text">
                <div class="price-container">
                  <span style="font-weight: bold; color: #339C87; font-size: 16px;">Giá</span>
                  <span class="text-decoration-line-through small" style="color: #555; font-size: 0.9em;">
              <fmt:formatNumber value="${p.price.price}" type="number" />
            </span>
                  <strong class="small" style="color: #339C87;">
                    <fmt:formatNumber value="${p.price.lastPrice}" type="number" />₫
                  </strong>
                </div>
                <div class="text-danger small">
                  <strong>Giảm ${p.price.discountPercent}%</strong>
                </div>
                </p>
              </div>
            </div>
          </div>

          <!-- Modal for this specific product -->
          <div class="modal fade" id="orderDetailsModal${p.id}" tabindex="-1" aria-labelledby="orderDetailsModalLabel${p.id}" aria-hidden="true">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="orderDetailsModalLabel${p.id}">Chi tiết sản phẩm</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <div class="row">
                    <!-- Image Carousel Section -->
                    <div class="col-md-6">
                      <img src="${p.image}" class="d-block w-100" alt="Product Image 3">
                    </div>
                    <div class="col-md-6">
                      <h3 class="text" style="color: #008080">${p.name}</h3>
                      <p class="h4 text-decoration-line-through text-warning">
                        <fmt:formatNumber value="${p.price.price}" type="number" />₫
                      </p>
                      <p class="h2 text-danger fw-bold">
                        <fmt:formatNumber value="${p.price.lastPrice}" type="number" />₫
                      </p>
                      <form action="cart?method=add" method="post">
                        <input name="currentURL" type="hidden" value="may-mac?loca=${requestScope.loca}">
                        <div class="mb-3">
                          <p class="fw-bold">Kiểu vải </p>
                          <div class="d-flex gap-2">
                            <c:forEach var="style" items="${p.styles}">
                              <label for="style${style.id}" class="product-style-label" style="margin: 5px;">
                                <input
                                        type="radio"
                                        name="selectedStyle"
                                        id="style${style.id}"
                                        value="${style.id}"
                                        required
                                        style="display: none;">
                                <img
                                        src="${style.image}"
                                        alt="${style.name}"
                                        class="product-style-image rounded"
                                        style="width: 60px; height: 60px; border: 2px solid #ccc; padding: 2px;">
                              </label>
                            </c:forEach>

                          </div>
                        </div>
                        <p class="fw-bold">Số lượng </p>
                        <div class="row">

                          <div class="col-6">
                            <div class="input-group">
                              <input type="number" id="quantity-${p.id}" name="quantity" class="form-control text-center quantity-input mb2" value="1" style="max-width: 100px" min="1">
                            </div>
                          </div>
                        </div>
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
        </c:forEach>

      </div>
    </div>
    <div class="col-6">
      <img src="images/maymac2.png" style="width: 100%; height: 100%; object-fit: cover;" alt="mayMac" class="img-fluid">
    </div>
  </div>

<div class="pagination-container">
  <div class="pagination">
    <%
      int nuPage = Integer.parseInt(request.getAttribute("nuPage").toString());
      int loca = Integer.parseInt(request.getAttribute("loca").toString());
    %>
    <%
      if (loca>1){
    %>
    <a class="page-btn" id="prev-btn" href="may-mac?loca=<%=loca-1%>">&lt</a>
    <%
      }
      for (int i = 1; i <= nuPage; i++) {
        if(i == loca) {
    %>
    <a href="may-mac?loca=<%=i%>" class="page-btn active" id="page-<%= i %>" style="background-color: #339C87;"><%= i %></a>
    <%
    } else {
    %>
    <a class="page-btn" id="page-<%= i %>" href="may-mac?loca=<%= i %>"><%= i %></a>
    <%
        }
      }
      if (loca< nuPage){
    %>
    <a class="page-btn" id="next-btn" href="may-mac?loca=<%=loca+1%>" >&gt</a>
    <%
      }
    %>
  </div>
</div>
  <script>
    function showDetailProduct(productId) {
      const modal = document.getElementById(`orderDetailsModal${productId}`);
      const modalInstance = new bootstrap.Modal(modal);
      modalInstance.show();
    }

    document.querySelectorAll('.product-style-label').forEach(label => {
      label.addEventListener('click', function() {
        const selectedStyle = this.querySelector('input');
        document.querySelectorAll('.product-style-label').forEach(otherLabel => {
          otherLabel.classList.remove('selected');
        });
        label.classList.add('selected');
      });
    });

    document.getElementById('product-list').addEventListener('click', function(event) {
      const target = event.target;
      const productId = target.getAttribute('data-id');  // Lấy ID của sản phẩm từ thuộc tính data-id

      // Xử lý sự kiện cho nút "+"
      if (target.classList.contains('increment-btn')) {
        const input = document.getElementById(`quantity-${productId}`);
        input.value = parseInt(input.value) + 1;
      }

      // Xử lý sự kiện cho nút "-"
      if (target.classList.contains('decrement-btn')) {
        const input = document.getElementById(`quantity-${productId}`);
        let currentValue = parseInt(input.value);
        if (currentValue > 1) {
          input.value = currentValue - 1;
        }
      }
    });
  </script>

<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>