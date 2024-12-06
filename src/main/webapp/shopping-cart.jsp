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
  <title>Giỏ hàng</title>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/shopping-cart.css">

<!-- Content -->
<div class="container-fluid">
  <div class="row" style="background-color: rgb(231, 231, 231); padding-top: 10px">
    <div class="col-md-1"></div>
    <!-- Empty div-->
    <!-- Danh mục sản phẩm trong giỏ hàng -->
    <div class="col-md-10">
      <!-- content of cart -->
      <div class="row">
        <!-- sản phẩm trong giỏ hàng-->
        <div class="col-md-7">
          <table class="table border">
            <thead>
            <tr>
              <th scope="col">Sản phẩm</th>
              <th scope="col">Giá</th>
              <th scope="col">Số lượng</th>
              <th scope="col">Tạm tính</th>
              <th scope="col">Xóa</th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td>
                <div class="row">
                  <div class="col-md-3">
                    <img src="images/cart2.jpg" alt="" style="width: 100%; height: 100%; text-align: center" />
                  </div>
                  <div class="col-md-9">
                    <h5>Vải lụa</h5>
                    <p>Màu sắc: Trắng</p>
                  </div>
                </div>
              </td>
              <td>100.000đ</td>
              <td>
                <input type="number" value="1" min="1" style="width: 50px; text-align: center" />
              </td>
              <td>100.000đ</td>
              <td>
                <button class="rounded-circle text-danger">
                  <i class="fa-solid fa-trash"></i>
                </button>
              </td>
            </tr>
            <tr>
              <td>
                <div class="row">
                  <div class="col-md-3">
                    <img src="images/cart1.jpg" alt="" style="width: 100%; height: 100%" />
                  </div>
                  <div class="col-md-9">
                    <h5>Vải kaki</h5>
                    <p>Màu sắc: Xanh</p>
                  </div>
                </div>
              </td>
              <td>150.000đ</td>
              <td>
                <input type="number" value="1" min="1" style="width: 50px; text-align: center" />
              </td>
              <td>150.000đ</td>
              <td>
                <button class="rounded-circle text-danger">
                  <i class="fa-solid fa-trash"></i>
                </button>
              </td>
            </tr>
            <tr>
              <td>
                <div class="row">
                  <div class="col-md-3">
                    <img src="images/cart3.jpg" alt="" style="width: 100%; height: 100%" />
                  </div>
                  <div class="col-md-9">
                    <h5>Vải nhung</h5>
                    <p>Màu sắc: Đen</p>
                  </div>
                </div>
              </td>
              <td>200.000đ</td>
              <td>
                <input type="number" value="1" min="1" style="width: 50px; text-align: center" />
              </td>
              <td>200.000đ</td>
              <td>
                <button class="rounded-circle text-danger">
                  <i class="fa-solid fa-trash"></i>
                </button>
              </td>
            </tr>
            </tbody>
          </table>
        </div>
        <!-- end sản phẩm-->
        <!-- Thanh toán giỏ hàng -->
        <div class="col-md-3">
          <table class="table border">
            <thead>
            <tr>
              <td colspan="2" scope="col" style="font-weight: 700">CỘNG GIỎ HÀNG</td>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td>Tạm tính</td>
              <td class="text-right">450,000đ</td>
            </tr>
            <tr>
              <td>Giao hàng</td>
              <td class="text-right">Đồng giá 30,000đ</td>
            </tr>
            <tr>
              <td>Tổng</td>
              <td class="text-right">480,000đ</td>
            </tr>
            <tr>
              <td colspan="2" class="text-primary">
                <i class="fa-solid fa-ticket"></i>&nbsp;Phiếu ưu đãi
              </td>
            </tr>
            <tr>
              <td colspan="2">
                <input type="text" name="voucher" id="voucher" placeholder="Mã ưu đãi" style="padding: 5px; width: 100%" />
              </td>
            </tr>
            <tr>
              <td colspan="2">
                <button class="btn btn-primary">Áp dụng</button>
              </td>
            </tr>
            <tr>
              <td style="text-align: center" colspan="2">
                <a href="payment.jsp" class="btn btn-warning">TIẾN HÀNH THANH TOÁN</a>
              </td>
            </tr>
            </tbody>
          </table>
        </div>
        <!-- end thanh toán giỏ hàng -->
      </div>
    </div>
    <div class="col-md-1"></div>
    <!-- Empty div-->
  </div>
</div>
<!-- End content -->

<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>
