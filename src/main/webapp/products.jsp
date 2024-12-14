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
    <title>Danh mục sản phẩm</title>
    <style>
        .product-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 cột đều */
            gap: 20px; /* Khoảng cách giữa các sản phẩm */
        }

        .product-item {
            display: flex;
            flex-direction: column;
            border: 1px solid #ccc;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        .product-card {
            height: 100%;
            display: flex;
            flex-direction: column;
            padding: 15px;
        }

        .pagination {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        .page-item {
            list-style: none;
        }
        .page-link {
            text-decoration: none;
            padding: 8px 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            color: #007bff;
        }
        .page-item.disabled .page-link {
            color: #ccc;
        }
    </style>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/products.css">

<div class="container">
    <div class="col text-end mt-3">
        <div class="mb-3">
            <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle custom-btn" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown">
                    Sắp xếp theo
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item" href="#">Mới nhất</a></li>
                    <li><a class="dropdown-item" href="#">Giá từ thấp đến cao</a></li>
                    <li><a class="dropdown-item" href="#">Giá từ cao đến thấp</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Sử dụng Grid để tạo layout 4 sản phẩm mỗi dòng -->
    <div class="product-container">
        <div class="product-item">
            <div class="card product-card">
                <img src="https://cdn.shopify.com/s/files/1/0681/2821/1221/files/31_372b7815-7362-47b0-8a4e-0b0ad969dfc4_480x480.jpg?v=1698393515" class="card-img-top" alt="Vải Gấm Hồng Thiên Phúc">
                <button class="btn cart-btn">
                    <i class="fas fa-shopping-cart"></i>
                </button>
                <div class="card-body">
                    <h6 class="card-title">Vải Gấm Hồng Thiên Phúc</h6>
                    <p class="card-text text-center">
                        <p class="text-danger text-decoration-line-through fs-5 text-center">469,000đ</p>
                        <p class="fw-bold fs-4 text-center" style="color: #339C87;">390,000đ</p>
                    </p>
                    <div class="button-container">
                        <button class="btn btn-primary me-2">MUA NGAY</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="product-item">
            <div class="card product-card">
                <img src="images/vaiGamLucThienPhuc.jpg" class="card-img-top" alt="Vải Gấm Lục Thiên Phúc">
                <button class="btn cart-btn">
                    <i class="fas fa-shopping-cart"></i>
                </button>
                <div class="card-body">
                    <h6 class="card-title">Vải Gấm Lục Thiên Phúc</h6>
                    <p class="card-text">
                        <span class="text-muted text-decoration-line-through">469,000đ</span>
                        <span class="fw-bold" style="color: #339C87;">390,000đ</span>
                    </p>
                    <div class="button-container">
                        <button class="btn custom-btn me-2">MUA NGAY</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="product-item">
            <div class="card product-card">
                <img src="images/vaiGamHoaVanXanh.jpg" class="card-img-top" alt="Vải Gấm Hoa Văn Xanh">
                <button class="btn cart-btn">
                    <i class="fas fa-shopping-cart"></i>
                </button>
                <div class="card-body">
                    <h6 class="card-title">Vải Gấm Hoa Văn Xanh</h6>
                    <p class="card-text">
                        <span class="text-muted text-decoration-line-through">469,000đ</span>
                        <span class="fw-bold" style="color: #339C87;">390,000đ</span>
                    </p>
                    <div class="button-container">
                        <button class="btn custom-btn me-2">MUA NGAY</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="product-item">
            <div class="card product-card">
                <img src="images/vaiGamNhiSacMauXanh.webp" class="card-img-top" alt="Vải Gấm Nhị Sắc Màu Xanh">
                <button class="btn cart-btn">
                    <i class="fas fa-shopping-cart"></i>
                </button>
                <div class="card-body">
                    <h6 class="card-title">Vải Gấm Nhị Sắc Màu Xanh</h6>
                    <p class="card-text">
                        <span class="text-muted text-decoration-line-through">469,000đ</span>
                        <span class="fw-bold" style="color: #339C87;">390,000đ</span>
                    </p>
                    <div class="button-container">
                        <button class="btn custom-btn me-2">MUA NGAY</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="product-item">
            <div class="card product-card">
                <img src="images/vaiGamNhiSacMauXanh.webp" class="card-img-top" alt="Vải Gấm Nhị Sắc Màu Xanh">
                <button class="btn cart-btn">
                    <i class="fas fa-shopping-cart"></i>
                </button>
                <div class="card-body">
                    <h6 class="card-title">Vải Gấm Nhị Sắc Màu Xanh</h6>
                    <p class="card-text">
                        <span class="text-muted text-decoration-line-through">469,000đ</span>
                        <span class="fw-bold" style="color: #339C87;">390,000đ</span>
                    </p>
                    <div class="button-container">
                        <button class="btn custom-btn me-2">MUA NGAY</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Phân trang -->
    <nav aria-label="Page navigation example" class="pagination-container">
        <ul class="pagination">
            <li class="page-item disabled" data-page="prev">
                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Trước</a>
            </li>
            <li class="page-item" aria-current="page" data-page="1">
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

<%@include file="includes/footer.jsp"%>
</body>
</html>
