<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 2:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp"%>
<html>
<head>
  <title>Vải nội thất</title>
  <link rel="stylesheet" href="css/fabric-blog.css">
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<div class="container my-5">
  <div class="header-right d-flex align-items-center justify-content-end">
    <!-- Loại bỏ view-toggle -->
    <select class="form-select d-inline-block w-auto" id="sortSelect">
      <option value="newest" selected>Mới Nhất</option>
      <option value="best-selling">Bán chạy Nhất</option>
      <option value="price-asc">Từ thấp đến cao</option>
      <option value="price-desc">Từ cao đến thấp</option>
    </select>
  </div>
  <div class="d-flex product-container">
    <!-- Sản phẩm 1 -->
    <div class="card product-item">
      <img src="https://via.placeholder.com/150" class="card-img-top" alt="Sản phẩm 1">
      <div class="card-body text-center">
        <h5 class="card-title">Sản phẩm 1</h5>
        <p class="card-text">Giá: 100,000 VND</p>
        <a href="#" class="btn btn-primary">Mua ngay</a>
      </div>
    </div>
    <!-- Sản phẩm 2 -->
    <div class="card product-item">
      <img src="https://via.placeholder.com/150" class="card-img-top" alt="Sản phẩm 2">
      <div class="card-body text-center">
        <h5 class="card-title">Sản phẩm 2</h5>
        <p class="card-text">Giá: 200,000 VND</p>
        <a href="#" class="btn btn-primary">Mua ngay</a>
      </div>
    </div>
    <!-- Sản phẩm 3 -->
    <div class="card product-item">
      <img src="https://via.placeholder.com/150" class="card-img-top" alt="Sản phẩm 3">
      <div class="card-body text-center">
        <h5 class="card-title">Sản phẩm 3</h5>
        <p class="card-text">Giá: 300,000 VND</p>
        <a href="#" class="btn btn-primary">Mua ngay</a>
      </div>
    </div>
    <!-- Sản phẩm 4 -->
    <div class="card product-item">
      <img src="https://via.placeholder.com/150" class="card-img-top" alt="Sản phẩm 4">
      <div class="card-body text-center">
        <h5 class="card-title">Sản phẩm 4</h5>
        <p class="card-text">Giá: 400,000 VND</p>
        <a href="#" class="btn btn-primary">Mua ngay</a>
      </div>
    </div>
  </div>
  <!-- Phân trang -->
  <nav aria-label="Page navigation example" class="mt-4">
    <ul class="pagination justify-content-center">
      <li class="page-item disabled">
        <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Trước</a>
      </li>
      <li class="page-item"><a class="page-link" href="#">1</a></li>
      <li class="page-item"><a class="page-link" href="#">2</a></li>
      <li class="page-item"><a class="page-link" href="#">3</a></li>
      <li class="page-item">
        <a class="page-link" href="#">Tiếp</a>
      </li>
    </ul>
  </nav>
</div>
    <%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>