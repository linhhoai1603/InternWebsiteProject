<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="link/headLink.jsp"%>
<link rel="stylesheet" href="includes/css/slides.css">
<div class="container-fluid">
  <div class="row">
    <div class="col-md-8 slide-container">
      <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img src="images/qc1.png" class="d-block w-100" alt="Ảnh 1">
          </div>
          <div class="carousel-item">
            <img src="images/qc2.png" class="d-block w-100" alt="Ảnh 2">
          </div>
          <div class="carousel-item">
            <img src="images/qc3.png" class="d-block w-100" alt="Ảnh 3">
          </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Trở lại</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Tiếp theo</span>
        </a>
      </div>
    </div>
    <div class="col-md-4 ad-section">
      <div class="row">
        <div class="col-md-12">
          <img src="images/qc4.png" alt="commercial4" class="w-100 p-3">
        </div>
        <div class="col-md-12">
          <img src="images/qc5.png" alt="commercial5" class="w-100 p-3">
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Sửa lại jQuery và Bootstrap -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

