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
          <div class="col-4 products-section" onclick="showDetailProduct()">
            <div class="card product-card">
              <div class="position-relative">
                <img src="${p.image}" class="card-img-top" alt="Sản phẩm" style="object-fit: cover; height: 200px;">
                <div class="product-buttons position-absolute start-50 translate-middle">
                  <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                  <button class="btn">Mua</button>
                </div>
              </div>
              <div class="card-body text-center">
                <h5 class="card-title">${p.name}</h5>
                <p class="card-text">
                <div class="price-container">
                  <span style="font-weight: bold; color: #339C87; font-size: 16px;">Giá</span>
                  <span  class="text-decoration-line-through small" style="color: #555; font-size: 0.9em;">
                    <fmt:formatNumber value="${p.price.price}" type="number" />
                  </span >
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
          <div class="col-4 products-section" onclick="showDetailProduct()">
            <div class="card product-card">
              <div class="position-relative">
                <img src="${p.image}" class="card-img-top" alt="Sản phẩm" style="object-fit: cover; height: 200px;">
                <div class="product-buttons position-absolute start-50 translate-middle">
                  <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                  <button class="btn">Mua</button>
                </div>
              </div>
              <div class="card-body text-center">
                <h5 class="card-title">${p.name}</h5>
                <p class="card-text">
                <div class="price-container">
                <span style="font-weight: bold; color: #339C87; font-size: 16px;">Giá</span>
                  <span  class="text-decoration-line-through small" style="color: #555; font-size: 0.9em;">
                    <fmt:formatNumber value="${p.price.price}" type="number" />
                  </span >
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


<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>