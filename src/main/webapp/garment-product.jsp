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
  <title>Vải may mặc</title>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/garment-product.css">
<!-- Phần sản phẩm-->
<div class="container mt-1">
  <div class="row" id="product-container-1" >
    <div class="col-6">
      <img src="images/mayMac1.jpg" style="width: 100%; height: 100%; object-fit: cover;" alt="mayMac" class="img-fluid">
    </div>

    <div class="col-6">
      <div class="title-product text-center mb-4">
        <h2>Vải linen</h2>
      </div>
      <div class="row">
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac1.1.jpg" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac1.2.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac1.3.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac1.4.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center" onclick="showDetailProduct()">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac1.5.jpg" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac1.6.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="row " id="product-container-2" style="margin-top: 100px;">
    <div class="col-6 ">
      <div class="title-product text-center mb-4">
        <h2>Vải thun xốp Nhật</h2>
      </div>
      <div class="row">

        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac2.1.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac2.2.jpg" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac2.3.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac2.4.jpg" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac2.5.jpg" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac2.6.jpg" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-6 ">
      <img src="images/mayMac2.jpg" style="width: 100%; height: 100%; object-fit: cover;" alt="mayMac" class="img-fluid">
    </div>
  </div>
  <div class="row" id="product-container-3"  style="margin-top: 5px;">
    <div class="col-6 ">
      <img src="images/mayMac3.webp" style="width: 100%; height: 100%; object-fit: cover;" alt="mayMac" class="img-fluid">
    </div>

    <div class="col-6 ">
      <div class="title-product text-center ">
        <h2>Jean Denim</h2>
      </div>
      <div class="row">

        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac3.1.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac3.2.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac3.3.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac3.4.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section" onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac3.5.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
        <div class="col-4 products-section"  onclick="showDetailProduct()">
          <div class="card product-card">
            <div class="position-relative">
              <img src="images/mayMac3.6.webp" class="card-img-top" alt="Sản phẩm">
              <div class="product-buttons position-absolute start-50 translate-middle">
                <button class="btn"><i class="fas fa-shopping-cart"></i></button>
                <button class="btn">Mua</button>
              </div>
            </div>
            <div class="card-body text-center">
              <h5 class="card-title">Vải Áo Dài</h5>
              <p class="card-text">
                <span class="text-danger text-decoration-line-through small">664,000₫</span>
                <span class="small" style="color: #339C87;">531,200₫</span>
              </p>
            </div>
          </div>
        </div>
      </div>
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