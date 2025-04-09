<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 2:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Giỏ hàng</title>
    <!-- SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>
<%@include file="includes/header.jsp" %>
<%@include file="includes/navbar.jsp" %>
<link rel="stylesheet" href="css/shopping-cart.css">
<c:if test="${sessionScope.cart == null}">
    <script>
        window.location.href = "home";
    </script>
</c:if>
<!-- Content -->
<div class="container-fluid">
    <div class="row" style="background-color: rgb(231, 231, 231); padding-top: 10px">
        <c:if test="${empty sessionScope.cart.items || sessionScope.cart.items.values().isEmpty()}">
            <h4 class="text-center"><fmt:message key="cart_empty_message"/></h4>
            <a href="products.jsp" class="btn btn-warning"><fmt:message key="cart_continue_shopping"/></a>
        </c:if>
        <c:if test="${not empty requestScope.error}">
            <script type="text/javascript">
                Swal.fire({
                    icon: 'error',
                    title: 'Có lỗi xảy ra',
                    text: "${requestScope.error}"
                });
            </script>
        </c:if>

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
                            <th scope="col"><fmt:message key="spp"/></th>
                            <th scope="col"><fmt:message key="g"/></th>
                            <th scope="col"><fmt:message key="soluong"/></th>
                            <th scope="col"><fmt:message key="tamtinh"/></th>
                            <th scope="col"><fmt:message key="x"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${sessionScope.cart.values}">
                            <tr>
                                <td>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <img src="${item.style.image}" alt="${item.style.product.description}"
                                                 style="width: 100%; height: 100%; text-align: center"/>
                                        </div>
                                        <div class="col-md-9">
                                            <h5>${item.style.product.name}</h5>
                                            <p><fmt:message key="color"/>: ${item.style.name}</p>
                                        </div>
                                    </div>
                                </td>
                                <td class="price">${item.style.product.price.lastPrice}</td>
                                <td>

                                    <form action="cart?method=updateQuantity" method="post">

                                        <input type="number" value="${item.quantity}" min="1"
                                               style="width: 50px; text-align: center" name="quantity"/>
                                        <input type="hidden" value="${item.style.id}" name="idStyle"/>
                                        <button type="submit"><fmt:message key="savee"/></button>
                                    </form>
                                </td>
                                <td class="price">${item.totalPrice}</td>
                                <td>
                                    <a class="rounded-circle text-danger"
                                       href="cart?method=remove&idStyle=${item.style.id}">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- end sản phẩm-->
                <!-- Thanh toán giỏ hàng -->
                <div class="col-md-3">
                    <table class="table border">
                        <thead>
                        <tr>
                            <td colspan="2" scope="col" style="font-weight: 700"><fmt:message
                                    key="cart_total_title"/></td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><fmt:message key="cart_subtotal"/></td>
                            <td class="text-right price">${sessionScope.cart.totalPrice}</td>
                        </tr>
                        <tr>
                            <td><fmt:message key="cart_shipping"/></td>
                            <td class="text-right price">${sessionScope.cart.shippingFee}</td>
                        </tr>

                        <tr>
                            <!-- thông tin khác -->
                            <td><fmt:message key="soluong"/></td>
                            <td class="text-right">${sessionScope.cart.totalQuantity}</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <form action="cart?method=applyVoucher" method="post">
                                    <i class="fa-solid fa-ticket"></i>&nbsp;<fmt:message key="discount_coupon"/> &nbsp;
                                    <input type="text" name="code" id="code" style="padding: 5px; width: 100%" required
                                           value="${sessionScope.cart.voucher.code}"/>
                                    <!-- Lấy giá trị thông báo từ request scope -->
                                    <c:set var="message"
                                           value="${not empty requestScope.message ? requestScope.message : ''}"/>

                                    <!-- Hiển thị thông báo nếu có message -->
                                    <c:if test="${not empty message}">
                                        <script type="text/javascript">
                                            var iconType = 'error';  // Mặc định là biểu tượng lỗi
                                            var title = 'Thông báo';  // Tiêu đề mặc định

                                            // Kiểm tra nếu message là "Giảm giá thành công!"
                                            if ("Giảm giá thành công!" === "${message}") {
                                                iconType = 'success';  // Đổi thành biểu tượng thành công
                                                title = 'Thành công';  // Tiêu đề cho thông báo thành công
                                            }

                                            // Hiển thị thông báo với SweetAlert
                                            Swal.fire({
                                                icon: iconType,  // Biểu tượng, có thể là 'error', 'success', 'warning', etc.
                                                title: title,  // Tiêu đề
                                                text: "${message}"  // Nội dung thông báo
                                            });
                                        </script>
                                    </c:if>
                                    <button type="submit" class="btn btn-primary"><fmt:message
                                            key="apply_button"/></button>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td><strong><fmt:message key="total_amount"/> </strong></td>
                            <td class="text-right price fw-bold">${sessionScope.cart.lastPrice}</td>
                        </tr>
                        <tr>
                            <td style="text-align: center" colspan="2">
                                <a href="payment-products?method=start" class="btn btn-warning"><fmt:message
                                        key="proceed_to_checkout"/></a>
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
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Hàm định dạng số tiền thành tiền Việt
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
        }

        // Định dạng giá gốc
        document.querySelectorAll(".price").forEach(el => {
            const originalPrice = el.textContent.trim().replace("VND", "").replace(/,/g, "");
            if (originalPrice) {
                el.textContent = formatCurrency(parseFloat(originalPrice));
            }
        });
    });


</script>
<%@include file="includes/footer.jsp" %>
<%@include file="includes/link/footLink.jsp" %>
</body>
</html>
