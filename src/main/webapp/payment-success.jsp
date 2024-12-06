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
    <title>Thông báo thanh toán</title>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/payment-success.css">

<!-- Content -->
<div class="container mb-5">
    <div class="row">
        <div class="col-md-12">
            <h3 class="text-center mt-5 text-success">Thanh toán thành công</h3>
        </div>
        <div class="col-md-7 mt-5">
            <h4 style="color: #4fd0b6">Chi tiết đơn hàng</h4>
            <div class="row">
                <p class="col-md-4 text-center fw-bold">Sản phẩm</p>
                <p class="col-md-4 text-center fw-bold">Số lượng</p>
                <p class="col-md-4 text-center fw-bold">Tổng tiền</p>
                <hr />
            </div>
            <div class="row info-product">
                <p class="col-md-4 text-center">
                    <a href="detail-product.jsp" style="text-decoration: none">Vải lụa</a>
                </p>
                <p class="col-md-4 text-center">1</p>
                <p class="col-md-4 text-center">100,000đ</p>
                <hr />
            </div>
            <div class="row infor-product">
                <p class="col-md-4 text-center">
                    <a href="detail-product.jsp">Vải kaki</a>
                </p>
                <p class="col-md-4 text-center">1</p>
                <p class="col-md-4 text-center">150,000đ</p>
                <hr />
            </div>
            <div class="row infor-product">
                <p class="col-md-4 text-center">
                    <a href="detail-product.jsp">Vải nhung</a>
                </p>
                <p class="col-md-4 text-center">1</p>
                <p class="col-md-4 text-center">200,000đ</p>
                <hr />
            </div>
            <br />
            <div class="row">
                <h5 style="color: #4fd0b6">Chi tiết thanh toán</h5>
            </div>
            <div class="row">
                <p class="col-md-6 fw-bold text-center">Tổng tiền sản phẩm</p>
                <p class="col-md-6 fw-bold text-center">450,000đ</p>
                <hr style="margin-top: -5px" />
                <p class="col-md-6 fw-bold text-center">Giao nhận hàng</p>
                <p class="col-md-6 text-center">
                    30,000đ <span style="font-size: 13px">đồng giá</span>
                </p>
                <hr style="margin-top: -5px" />
                <p class="col-md-6 fw-bold text-center">Phương thức thanh toán</p>
                <p class="col-md-6 text-center">Trả tiền khi nhận hàng</p>
                <hr style="margin-top: -5px" />
                <p class="col-md-6 fw-bold text-center">Tổng cộng</p>
                <p class="col-md-6 fw-bold text-center">480,000đ</p>
                <hr style="margin-top: -5px" />
                <p class="col-md-6 fw-bold text-center">Lưu ý</p>
                <p class="col-md-6 text-center">Giao hàng vào lúc 9h sáng</p>
                <hr style="margin-top: -5px" />
            </div>
        </div>
        <div class="col-md-1"></div>
        <div class="col-md-4 border h-100">
            <h5 class="pt-3 text-success">
                Cảm ơn quý khách đã mua hàng, đơn hàng sẽ được giao tới trong 24h
                tới.
            </h5>
            <ul>
                <li>Mã đơn hàng: <b>1102</b></li>
                <li>Thời gian mua hàng: <b>13:00 11/5/2024</b></li>
                <li>Người mua hàng: <b>Nguyễn Văn A</b></li>
                <li>Tổng cộng: <b>480,000đ</b></li>
                <li>Phương thức thanh toán: <b>Trả tiền khi nhận hàng</b></li>
            </ul>
            <p></p>
        </div>
    </div>
</div>
<!-- End content -->

<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>