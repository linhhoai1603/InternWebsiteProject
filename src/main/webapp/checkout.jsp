<%--
  Created by IntelliJ IDEA.
  User: mypc
  Date: 5/12/2025
  Time: 9:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <title>
        Checkout
    </title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="css/checkout.css">
</head>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>

<div class="container" role="main">
    <div class="site-header">
        <h1>VÔ VÀN VẢI</h1>
    </div>

    <!-- Shipping Information Section -->
    <section id="shipping-info-section" aria-label="Thông tin giao hàng" class="main-left">
        <nav id="breadcrumb-shipping" aria-label="breadcrumb" class="breadcrumb">
            <a href="shopping-cart.jsp" class="completed">Giỏ hàng</a>
            <span class="separator"><i class="fas fa-chevron-right"></i></span>
            <a href="#" class="active" style="pointer-events:none;">Thông tin giao hàng</a>
            <span class="separator inactive"><i class="fas fa-chevron-right"></i></span>
            <span class="inactive">Phương thức thanh toán</span>
        </nav>
        <h2>Thông tin giao hàng</h2>
        <!-- information section -->
        <form id="shipping-form">
            <input id="fullName" aria-label="Họ và tên" placeholder="Họ và tên" type="text"
                   value="${sessionScope.user.getFullName()}" required/>
            <div class="form-row-wrapper">
                <div class="form-row">
                    <div class="half">
                        <input id="email" aria-label="Email" placeholder="Email" type="email"
                               value="${sessionScope.user.email}" readonly/>
                    </div>
                    <div class="half" style="max-width: 200px;">
                        <input id="phone" aria-label="Số điện thoại" placeholder="Số điện thoại" type="tel"
                               value="${sessionScope.user.getNumberPhone()}" required/>
                    </div>
                </div>
            </div>
            <input id="address" aria-label="Địa chỉ (số nhà, tên đường)" placeholder="Địa chỉ (số nhà, tên đường)"
                   type="text" value="${sessionScope.user.address.detail}" required/>
            <div class="form-row-wrapper">
                <div class="form-row" style="gap:10px;">
                    <div class="third">
                        <label for="province">Tỉnh / thành</label>
                        <input type="text" id="province" aria-label="Tỉnh / thành" placeholder="Tỉnh / thành"
                               value="${sessionScope.user.address.province}" required/>
                    </div>
                    <div class="third">
                        <label for="district">Quận / huyện</label>
                        <input type="text" id="district" aria-label="Quận / huyện" placeholder="Quận / huyện"
                               value="${sessionScope.user.address.district}" required/>
                    </div>
                    <div class="third">
                        <label for="ward">Phường / xã</label>
                        <input type="text" id="ward" aria-label="Phường / xã" placeholder="Phường / xã"
                               value="${sessionScope.user.address.ward}" required/>
                    </div>
                </div>
            </div>

            <%-- Google Maps --%>
            <div style="margin-bottom: 15px;">
                <label for="google-maps-address-search">Tìm địa chỉ trên Google Maps:</label>
                <input id="google-maps-address-search" type="text" placeholder="Nhập địa chỉ để tìm kiếm..."/>
                <button type="button" id="btn-use-manual-address" class="btn-secondary"
                        style="margin-top:5px; display:none;">Nhập địa chỉ thủ công
                </button>
            </div>
            <div id="map" style="height: 300px; width: 100%; margin-bottom: 15px; display: none;"></div>
            <%-- Kết thúc phần Google Maps --%>

            <textarea id="shippingNotes" placeholder="Ghi chú (tùy chọn)" rows="3"
                      style="width:100%; border:1px solid #ddd; border-radius:6px; padding:10px; font-size:14px; font-family: Roboto, Arial, sans-serif; margin-bottom:15px;"></textarea>

            <div class="form-footer">
                <a href="shopping-cart.jsp" style="color:#3b7ddd;"><i class="fas fa-chevron-left"></i> Giỏ hàng</a>
                <button id="btn-to-payment" class="btn-primary" type="submit">Tiếp tục đến phương thức thanh toán
                </button>
            </div>
        </form>
    </section>

    <!-- Payment Method Section (Initially Hidden) -->
    <section id="payment-method-section" aria-label="Phương thức thanh toán" class="main-left hidden">
        <nav id="breadcrumb-payment" aria-label="breadcrumb" class="breadcrumb">
            <a href="shopping-cart.jsp" class="completed">Giỏ hàng</a>
            <span class="separator"><i class="fas fa-chevron-right"></i></span>
            <a href="checkout.jsp" id="breadcrumb-back-to-shipping" class="completed">Thông tin giao hàng</a>
            <span class="separator"><i class="fas fa-chevron-right"></i></span>
            <span class="active">Phương thức thanh toán</span>
        </nav>

        <div class="review-box">
            <div class="review-box-row">
                <span class="review-box-label">Liên hệ</span>
                <span id="review-email" class="review-box-value"></span>
                <span class="review-box-action"><a href="#" id="change-shipping-info-contact">Thay đổi</a></span>
            </div>
            <div class="review-box-row">
                <span class="review-box-label">Giao tới</span>
                <span id="review-address" class="review-box-value"></span>
                <span class="review-box-action"><a href="#" id="change-shipping-info-address">Thay đổi</a></span>
            </div>
            <div class="review-box-row" id="review-notes-row" style="display:none;">
                <span class="review-box-label">Ghi chú</span>
                <span id="review-shipping-notes" class="review-box-value"></span>
            </div>
        </div>
        <!-- payment -->
        <h2>Phương thức thanh toán</h2>
        <form id="payment-form">
            <div class="payment-option" data-value="cod">
                <input type="radio" id="payment-cod" name="paymentMethod" value="cod" checked>
                <label for="payment-cod">Thanh toán khi nhận hàng (COD)</label>
                <i class="fas fa-truck payment-option-icon"></i>
            </div>
            <div class="payment-option-details hidden" data-details-for="cod">
                <p>Bạn sẽ thanh toán bằng tiền mặt cho nhân viên giao hàng khi nhận được sản phẩm.</p>
            </div>

            <div class="payment-option" data-value="bank_transfer">
                <input type="radio" id="payment-bank" name="paymentMethod" value="bank_transfer">
                <label for="payment-bank">Chuyển khoản ngân hàng</label>
                <i class="fas fa-university payment-option-icon"></i>
            </div>
            <div class="payment-option-details hidden" data-details-for="bank_transfer">
                <p>Vui lòng chuyển khoản vào tài khoản sau với nội dung là Mã đơn hàng của bạn:</p>
                <p><strong>Ngân hàng:</strong> Techcombank<br>
                    <strong>Số tài khoản:</strong> 190xxxxxxxxxx<br>
                    <strong>Chủ tài khoản:</strong> SOUSTATE STORE</p>
                <p>Đơn hàng sẽ được xử lý sau khi chúng tôi xác nhận thanh toán.</p>
            </div>

            <h2 style="margin-top: 30px;">Địa chỉ thanh toán</h2>
            <div class="payment-option" data-value="same_as_shipping">
                <input type="radio" id="billing-same" name="billingAddressOption" value="same_as_shipping" checked>
                <label for="billing-same">Giống với địa chỉ giao hàng</label>
            </div>
            <div class="payment-option" data-value="different_billing">
                <input type="radio" id="billing-different" name="billingAddressOption" value="different_billing">
                <label for="billing-different">Sử dụng địa chỉ thanh toán khác</label>
            </div>

            <div id="different-billing-address-form" class="hidden"
                 style="margin-top:15px; padding-left: 10px; border-left: 2px solid #eee;">
                <input id="billingFullName" aria-label="Họ và tên (thanh toán)" placeholder="Họ và tên" type="text"/>
                <input id="billingAddress" aria-label="Địa chỉ (thanh toán)" placeholder="Địa chỉ (số nhà, tên đường)"
                       type="text"/>
                <div class="form-row-wrapper">
                    <div class="form-row" style="gap:10px;">
                        <div class="third">
                            <label for="billingProvince">Tỉnh / thành</label>
                            <input type="text" id="billingProvince" aria-label="Tỉnh / thành (thanh toán)"
                                   placeholder="Tỉnh / thành"/>
                        </div>
                        <div class="third">
                            <label for="billingDistrict">Quận / huyện</label>
                            <input type="text" id="billingDistrict" aria-label="Quận / huyện (thanh toán)"
                                   placeholder="Quận / huyện"/>
                        </div>
                        <div class="third">
                            <label for="billingWard">Phường / xã</label>
                            <input type="text" id="billingWard" aria-label="Phường / xã (thanh toán)"
                                   placeholder="Phường / xã"/>
                        </div>
                    </div>
                </div>
                <input id="billingPhone" aria-label="Số điện thoại (thanh toán)" placeholder="Số điện thoại"
                       type="tel"/>
            </div>

            <div class="form-footer">
                <a href="checkout.jsp" id="btn-back-to-shipping" style="color:#3b7ddd;"><i
                        class="fas fa-chevron-left"></i> Quay
                    lại thông tin giao hàng</a>
                <button id="btn-complete-order" class="btn-primary" type="submit">Hoàn tất đơn hàng</button>
            </div>
        </form>
    </section>

    <!-- Cart Summary (Right Pane) -->
    <aside aria-label="Thông tin giỏ hàng" class="main-right">
        <!-- Product 1 -->
        <c:choose>
            <c:when test="${not empty sessionScope.cart && not empty sessionScope.cart.cartItems}">
                <c:forEach var="item" items="${sessionScope.cart.cartItems}">
                    <div class="cart-item">
                        <div class="cart-item-img-wrapper">
                            <img alt="${item.style.name}" height="70"
                                 src="${not empty item.style.image ? item.style.image : 'images/placeholder.png'}"
                                 width="70"/>
                            <div aria-label="Số lượng ${item.quantity}"
                                 class="cart-item-quantity">${item.quantity}</div>
                        </div>
                        <div class="cart-item-info">
                            <p class="cart-item-name">${item.style.product.name}</p>
                            <p class="cart-item-variant">
                                <c:if test="${not empty item.style.product.name}">${item.style.product.name}</c:if>
                            </p>
                        </div>
                        <div aria-label="Giá <fmt:formatNumber value='${item.unitPrice}' type='currency' currencyCode='VND' />"
                             class="cart-item-price">
                            <fmt:formatNumber value="${item.unitPrice}" type="currency"
                                              currencyCode="VND" groupingUsed="true" maxFractionDigits="0"/>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p style="text-align: center; padding: 20px 0;">Giỏ hàng của bạn đang trống.</p>
            </c:otherwise>
        </c:choose>

        <!-- voucher -->
        <form aria-label="Mã giảm giá" class="discount-code" id="voucher-form" action="addVoucher" method="post">
            <input aria-label="Nhập mã giảm giá" placeholder="Mã giảm giá" type="text" id="voucher-code-input" name="voucherCodeInput"
                   value="${not empty sessionScope.cart.appliedVoucher ? sessionScope.cart.appliedVoucher.code : ''}" />
            <button type="submit" id="apply-voucher-btn">Sử dụng</button>
        </form>
        <c:if test="${not empty sessionScope.voucherMessage}">
            <div class="voucher-message ${sessionScope.voucherStatus == 'success' ? 'text-success' : 'text-danger'}"
                 style="font-size: 12px; margin-top: 5px; margin-bottom: 15px;">
                    ${sessionScope.voucherMessage}
            </div>
            <c:remove var="voucherMessage" scope="session"/>
            <c:remove var="voucherStatus" scope="session"/>
        </c:if>
        <div class="summary">
            <div class="summary-row">
                <span>Tạm tính</span>
                <span aria-label="Tạm tính">
                    <c:choose>
                        <c:when test="${not empty sessionScope.cart.totalPrice}">
                            <fmt:formatNumber value="${sessionScope.cart.totalPrice}" type="currency" currencyCode="VND"
                                              groupingUsed="true" maxFractionDigits="0"/>
                        </c:when>
                        <c:otherwise>0₫</c:otherwise>
                    </c:choose></span>
            </div>
            <c:set var="discountAmountJSTL" value="${sessionScope.cart.getDiscountAmount()}" />
            <div class="summary-row" id="discount-row" style="${discountAmountJSTL > 0 ? 'display: flex;' : 'display: none;'}">
                <span>Giảm giá</span>
                <span id="discount-amount-display" class="text-success">
                    <c:if test="${discountAmountJSTL > 0}">
                        - <fmt:formatNumber value="${discountAmountJSTL}" type="currency" currencyCode="VND" groupingUsed="true" maxFractionDigits="0"/>
                    </c:if>
                </span>
            </div>

            <div class="summary-row">
                <span>Phí vận chuyển</span>
                <span id="shipping-fee-display" aria-label="Phí vận chuyển chưa xác định">..</span>
            </div>
            <div class="summary-row total">
                <span>Tổng cộng</span>
                <span>
                   <span class="currency">VND</span>
                   <span id="total-price-display">
                       <c:choose>
                           <c:when test="${not empty sessionScope.cart.getLastPrice()}">
                               <fmt:formatNumber
                                       value="${sessionScope.cart.getLastPrice()}"
                                       type="currency" currencyCode="VND" groupingUsed="true"
                                       maxFractionDigits="0"/>
                           </c:when>
                           <c:otherwise>0₫</c:otherwise>
                       </c:choose>
                   </span>
                </span>
            </div>
        </div>
    </aside>
</div>

<script src="js/checkout.js"></script>
<%-- Google Maps API Script --%>
</body>
</html>