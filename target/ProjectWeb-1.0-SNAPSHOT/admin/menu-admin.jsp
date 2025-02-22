<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/6/2024
  Time: 3:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
  *{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  .slide{
    height: 100%;
    width: 200px;
    position: absolute;
    background-color: #339C87;
    transition: 0.5s ease;
    transform: translateX(-200px);
  }
  h1{
    color: aliceblue;
    font-weight: 800;
    text-align: right;
    padding: 15px 0px;
    padding-right: 20px;
    pointer-events: none;
  }
  ul li {
    list-style: none;
  }

  ul li a i {
    width: 40px;
    text-align: center;
  }
  .toggle{
    position: absolute;
    height: 30px;
    width: 30px;
    top: 20px;
    Left: 15px;
    z-index: 1;
    cursor: pointer;
    border-radius: 2px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0,0,0,0.3);
  }
  .toggle .common{
    position: absolute;
    height: 2px;
    width: 20px;
    background-color: #339C87;
    border-radius: 50px;
    transition: 0.3s ease;
  }
  .toggle .top_line{
    top: 30%;
    Left: 50%;
    transform: translate(-50%,-50%);
  }

  .toggle .middle_line{
    top: 50%;
    Left: 50%;
    transform: translate(-50%,-50%);
  }
  .toggle .bottom_line{
    top: 70%;
    Left: 50%;
    transform: translate(-50%,-50%);
  }
  input:checked ~ .toggle .top_line{
    Left: 2px;
    top: 14px;
    width: 25px;
    transform: rotate(45deg);
  }

  input:checked ~ .toggle .bottom_line{
    Left: 2px;
    top: 14px;
    width: 25px;
    transform: rotate(-45deg);
  }
  input:checked ~ .toggle .middle_line{
    opacity: 0;
    transform: translateX(20px);
  }
  input:checked ~ .slide{
    transform: translateX(0);
    box-shadow: 0 0 15px rgba(0,0,0,0.5);
  }
  div ul li a {
    color: white;
    text-decoration: none;
  }

</style>

<!-- Menu toggle (checkbox) -->
<label class="h-auto">
  <input type="checkbox" style="display: none">
  <div class="toggle">
    <span class="top_line common"></span>
    <span class="middle_line common"></span>
    <span class="bottom_line common"></span>
  </div>

  <!-- Slide menu -->
  <div class="slide">
    <h1>Menu</h1>
    <ul>
      <li><a href="dashboard"><i class="fa-solid fa-chart-line"></i>Dashboard</a></li>
      <li><a href="management-users.jsp"><i class="fa-solid fa-users"></i>Người dùng</a></li>
      <li><a href="management-products.jsp"><i class="fa-solid fa-clone"></i>Sản phẩm</a></li>
      <li><a href="manager-order"><i class="fa-solid fa-cart-shopping"></i>Đơn hàng</a></li>
      <li><a href="manager-deliveries"><i class="fa-solid fa-truck-fast"></i>Vận chuyển</a></li>
      <li><a href="manager-voucher"><i class="fa-solid fa-ticket"></i>Mã giảm giá</a></li>
      <li><a href="manager-message"><i class="fa-regular fa-message"></i>Tin nhắn</a></li>
    </ul>
  </div>
</label>

