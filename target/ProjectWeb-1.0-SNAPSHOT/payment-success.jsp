<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<html>
<head>
    <title>Thông báo thanh toán</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<link rel="stylesheet" href="css/payment-success.css">

<!-- Lấy giá trị error và username từ request scope -->
<c:set var="message" value="${not empty requestScope.message ? requestScope.message : ''}" />

<!-- Hiển thị thông báo nếu có lỗi -->
<c:if test="${not empty message}">
    <script type="text/javascript">
        Swal.fire({
            icon: 'success',
            title: 'Thông báo',
            text: "${message}"
        });
    </script>
</c:if>

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
            <!-- Lặp qua các sản phẩm trong đơn hàng -->
            <c:forEach var="item" items="${requestScope.ordered.cart.values}">
                <div class="row info-product">
                    <p class="col-md-4 text-center">
                        <a href="detail-product.jsp" style="text-decoration: none">${item.style.product.name} - ${item.style.name}</a>
                    </p>
                    <p class="col-md-4 text-center">${item.quantity}</p>
                    <p class="col-md-4 text-center price">${item.totalPrice}đ</p>
                    <hr />
                </div>
            </c:forEach>
            <br />
            <div class="row">
                <h5 style="color: #4fd0b6">Chi tiết thanh toán</h5>
            </div>
            <div class="row">
                <p class="col-md-6 fw-bold text-center">Tổng tiền sản phẩm</p>
                <p class="col-md-6 fw-bold text-center price">${requestScope.ordered.cart.totalPrice}đ</p>
                <hr style="margin-top: -5px" />
                <p class="col-md-6 fw-bold text-center">Giao nhận hàng</p>
                <p class="col-md-6 text-center price">${requestScope.ordered.cart.shippingFee}đ</p>
                <hr style="margin-top: -5px" />
                <p class="col-md-6 fw-bold text-center">Phương thức thanh toán</p>
                <p class="col-md-6 text-center">${requestScope.ordered.methodPayment}</p>
                <hr style="margin-top: -5px" />
                <p class="col-md-6 fw-bold text-center">Tổng cộng</p>
                <p class="col-md-6 fw-bold text-center price">${requestScope.ordered.cart.lastPrice}đ</p>
                <hr style="margin-top: -5px" />
                <p class="col-md-6 fw-bold text-center">Lưu ý</p>
                <p class="col-md-6 text-center">${requestScope.ordered.note}</p>
                <hr style="margin-top: -5px" />
            </div>
        </div>

        <!-- Thông tin đơn hàng -->
        <div class="col-md-1"></div>
        <div class="col-md-4 border h-100">
            <h5 class="pt-3 text-success">
                Cảm ơn quý khách đã mua hàng, đơn hàng sẽ được giao tới trong 24h tới.
            </h5>
            <ul>
                <li>Mã đơn hàng: <b>${requestScope.ordered.idOrder}</b></li>
                <li>Thời gian mua hàng: <b>${requestScope.ordered.timeOrdered}</b></li>
                <li>Người mua hàng: <b>${requestScope.ordered.personName}</b></li>
                <li>Địa chỉ nhận hàng: <b>${requestScope.ordered.address}</b></li>
                <li>Tổng cộng: <b class=" price">${requestScope.ordered.cart.lastPrice }</b></li>
            </ul>
        </div>
    </div>
</div>
<!-- End content -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Hàm định dạng số tiền thành tiền Việt
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
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
<%@ include file="includes/footer.jsp" %>
<%@ include file="includes/link/footLink.jsp" %>
</body>
</html>
