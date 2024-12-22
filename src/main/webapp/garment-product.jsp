<%--
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

<div class="container mt-1">

  <div class="row" id="product-container" >
    <div class="col-6">
      <img src="images/mayMac1.jpg" style="width: 100%; height: 100%; object-fit: cover;" alt="mayMac" class="img-fluid">
    </div>

    <div class="col-6">
      <div class="title-product text-center mb-4">
        <h2>Vải linen</h2>
      </div>

      <div class="row">
        <c:if test="${empty requestScope.garments}">
          <h1>Không có sản phẩm</h1>
        </c:if>
        <c:forEach var="p" items="${requestScope.garments}">
          <div class="col-4 products-section" onclick="showDetailProduct()">
            <div class="card product-card">
              <div class="position-relative">
                <img src="${p.image}" class="card-img-top" alt="Sản phẩm">
                <div class="product-buttons position-absolute start-50 translate-middle">
                  <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                  <button class="btn">Mua</button>
                </div>
              </div>
              <div class="card-body text-center">
                <h5 class="card-title">${p.name}</h5>
                <p class="card-text">
                  <span class="text-danger text-decoration-line-through small">${p.price.price}</span>
                  <span class="small" style="color: #339C87;">${p.price.lastPrice}</span>
                </p>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>

  <div class="pagination-container">
    <div class="pagination">
      <button class="page-btn" id="prev-btn">&lt</button>
      <button class="page-btn" id="page-1" style="background-color: #339C87;">1</button>
      <button class="page-btn active" id="page-2">2</button>
      <button class="page-btn" id="next-btn">&gt</button>
    </div>
  </div>

  <%@include file="includes/footer.jsp"%>
  <%@include file="includes/link/footLink.jsp"%>
</body>
</html>