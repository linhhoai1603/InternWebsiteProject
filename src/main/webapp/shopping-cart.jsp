<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Giỏ hàng</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>
<%@include file="includes/header.jsp" %>
<%@include file="includes/navbar.jsp" %>
<link rel="stylesheet" href="css/shopping-cart.css">

<c:if test="${sessionScope.cart == null}">
    <jsp:include page="${pageContext.request.contextPath}/home"/>
</c:if>

<!-- Content -->
<div class="container-fluid">
    <div class="row" style="background-color: rgb(231, 231, 231); padding-top: 10px">
        <div class="col-md-1"></div>

        <!-- Giỏ hàng -->
        <div class="col-md-10">
            <div class="row">
                <!-- Sản phẩm trong giỏ hàng -->
                <div class="col-md-12">
                    <h4 class="mb-3">Cart</h4>
                    <c:if test="${empty sessionScope.cart.cartItems}">
                        <div class="alert alert-info text-center">
                            <fmt:message key="cart_empty_message"/>
                            <br>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-warning mt-2">
                                <fmt:message key="cart_continue_shopping"/>
                            </a>
                        </div>
                    </c:if>

                    <c:if test="${not empty sessionScope.cart.cartItems}">
                        <table class="table table-bordered bg-white">
                            <thead class="table-light">
                            <tr>
                                <th>
                                    <input type="checkbox" id="checkAll" />
                                </th>

                                <th>Image</th>
                                <th>Product</th>
                                <th>Style</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Unit Price</th>
                                <th>Added Date</th>
                                <th>Remove</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${sessionScope.cart.cartItems}">
                                <tr>
                                    <!-- Checkbox chọn -->
                                    <td>
                                        <input type="checkbox" class="item-checkbox" name="selectedItems" value="${item.style.id}">
                                    </td>
                                    <!-- Image -->
                                    <td>
                                        <img src="${item.style.image}" alt="${item.style.product.description}"
                                             style="width: 80px; height: 80px"/>
                                    </td>

                                    <!-- Product -->
                                    <td>${item.style.product.name}</td>

                                    <!-- Style -->
                                    <td>${item.style.name}</td>

                                    <!-- Price -->
                                    <td class="price">${item.style.product.price.lastPrice}</td>

                                    <!-- Quantity -->
                                    <td>
                                        <form action="update-cart-item" method="post" class="d-flex align-items-center">
                                            <input type="number" name="quantity" value="${item.quantity}" min="1"
                                                   style="width: 60px; text-align: center" class="form-control me-2"/>
                                            <input type="hidden" name="idItem" value="${item.id}"/>
                                            <button type="submit" class="btn btn-sm btn-outline-primary">
                                                <fmt:message key="savee"/>
                                            </button>
                                        </form>
                                    </td>

                                    <!-- Unit Price -->
                                    <td class="price">${item.unitPrice}</td>

                                    <!-- Added Date -->
                                    <td>${item.addedDate}</td>

                                    <!-- Remove -->
                                    <td>
                                        <a class="text-danger" href="delete-cart-item?idItem=${item.id}"
                                           onclick="return confirm('Bạn có chắc muốn xoá sản phẩm này?');">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="col-md-1"></div>
    </div>
</div>
    <!-- Thông tin tổng cộng + áp dụng voucher + thanh toán -->
    <div class="row justify-content-end mt-4">
        <div class="col-md-6">
            <div class="card p-3">
                <h5 class="mb-3">Thông tin đơn hàng</h5>

                <p><strong>Tổng số sản phẩm:</strong> <span class="">${sessionScope.cart.totalItems}</span></p>
                <p><strong>Tổng số lượng:</strong> ${sessionScope.cart.totalQuantity}</p>
                <p><strong>Tổng tiền:</strong> <span class="price">${sessionScope.cart.totalPrice}</span></p>

                <a href="checkout.jsp" class="btn btn-success w-100">Tiến hành thanh toán</a>
            </div>
        </div>
    </div>


<!-- End content -->

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Định dạng giá tiền VND
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(amount);
        }

        document.querySelectorAll(".price").forEach(el => {
            const raw = el.textContent.trim().replace(/[^0-9.-]+/g, '');
            if (raw) {
                el.textContent = formatCurrency(parseFloat(raw));
            }
        });
    });
    // Chọn / bỏ chọn tất cả sản phẩm
    document.getElementById("checkAll").addEventListener("change", function () {
        const checkboxes = document.querySelectorAll(".item-checkbox");
        checkboxes.forEach(cb => cb.checked = this.checked);
    });

    socket.onopen = () => console.log("WebSocket connected");
    socket.onclose = () => console.log("WebSocket closed");
</script>

<%@include file="includes/footer.jsp" %>
<%@include file="includes/link/footLink.jsp" %>
</body>
</html>
