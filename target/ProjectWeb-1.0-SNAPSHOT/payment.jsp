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
  <title>Thanh toán</title>
  <!-- SweetAlert -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/payment.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- Create payment with col-md-6, input infor delivery, right col-md-6 infor product, both table-->
<div class="container">
  <div class="row mt-5">
    <p >Bạn có mã ưu đãi?<a id="voucher" class="text-primary">&nbsp;Ấn vào đây để nhập mã?</a></p>
    <!-- Lấy giá trị thông báo từ request scope -->
    <c:set var="message" value="${not empty requestScope.message ? requestScope.message : ''}" />

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

    <div id="inputVoucher">
      <h5>Nếu bạn có mã giảm giá, vui lòng điền vào phía bên dưới.</h5>
      <form action="payment-products?method=applyVoucher" method="post">
        <input name="code" type="text" placeholder="Mã ưu đãi" style="padding: 10px" />
        <button type="submit" class="btn btn-primary">Áp dụng</button>
      </form>
    </div>
  </div>
  <form action="order" method="post">
  <div class="row">
    <div class="col-md-6">
      <h4 style="color: #339c87" class="mt-4 mb-3">Thông tin giao hàng</h4>

        <!-- Thông tin giao hàng chính -->
        <div class="row">
          <div class="col-md-6">
            <label class="fw-bold" for="name">Họ và tên: <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="name" name="name" value="${sessionScope.user.fullName}" />
          </div>
          <div class="col-md-6">
            <label class="fw-bold" for="phone">Số điện thoại: <span class="text-red">*</span></label>
            <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.user.numberPhone}" />
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <label class="fw-bold" for="address">Địa chỉ: <span class="text-red">*</span></label>
            <input type="text" class="form-control" id="address" name="address" value="${sessionScope.user.address.street}/${sessionScope.user.address.commune}/${sessionScope.user.address.city}/${sessionScope.user.address.province}" />
          </div>
          <div class="col-md-6">
            <label class="fw-bold" for="otherPhone">Số điện thoại nhận hàng: <span class="text-red">*</span></label>
            <input type="text" name="otherPhone" id="otherPhone" class="form-control" placeholder="Nhập số điện thoại nhận hàng"/>
          </div>
        </div>


        <!-- Checkbox và thông tin giao hàng khác -->
        <div class="row mt-3">
          <div class="col-md-12">
            <input type="checkbox" name="otherAddress" id="otherAddress" onclick="toggleOtherAddress()" value = "1" />
            <label for="otherAddress">Giao hàng tới địa chỉ khác</label>
          </div>
        </div>
        <div id="otherDelivery" style="display: none; margin-top: 10px">
          <div class="row">
            <div class="col-md-6">
              <label class="fw-bold" for="fullName">Họ và tên</label>
              <input type="text" class="form-control" id="fullName" name="o-fullName" placeholder="Nhập họ và tên" />
            </div>
            <div class="col-md-6">
              <label class="fw-bold" for="o-phone">Số điện thoại</label>
              <input type="text" class="form-control" id="o-phone" name="o-phone" placeholder="Nhập số điện thoại" />
            </div>
          </div>
          <div class="row mt-3">
            <div class="col-md-6">
              <label class="fw-bold" for="o-street">Đường</label>
              <input type="text" name="o-street" id="o-street" class="form-control" placeholder="Nhập tên đường" />
            </div>
            <div class="col-md-6">
              <label class="fw-bold" for="o-commune">Xã</label>
              <input type="text" name="o-commune" id="o-commune" class="form-control" placeholder="Nhập tên xã" />
            </div>
          </div>
          <div class="row mt-3">
            <div class="col-md-6">
              <label class="fw-bold" for="o-city">Huyện</label>
              <input type="text" name="o-city" id="o-city" class="form-control" placeholder="Nhập tên huyện" />
            </div>
            <div class="col-md-6">
              <label class="fw-bold" for="o-province">Tỉnh</label>
              <input type="text" name="o-province" id="o-province" class="form-control" placeholder="Nhập tên tỉnh" />
            </div>
          </div>

        </div>
        <div class="row mt-2">
          <div class="col-md-11">
            <label for="note" class="fw-bold">Ghi chú đơn hàng (tùy chọn):</label>
            <textarea name="note" id="note" style="margin-left: 10px; height: 150px" class="form-control" placeholder="Ghi chú giao hàng"></textarea>
          </div>
        </div>
    </div>
    <div
            class="col-md-6"
            style="border: 1px solid black; border-top: 5px solid #339c87"
    >
      <h4 style="color: #339c87" class="mt-4 mb-3">Thông tin sản phẩm</h4>
      <table class="table">
        <thead>
        <tr>
          <div class="row">
            <div class="col-md-4 fw-bold text-center">Sản phẩm</div>
            <div class="col-md-2 fw-bold text-center">Tên</div>
            <div class="col-md-2 fw-bold text-center">Giá sản phẩm</div>
            <div class="col-md-2 fw-bold text-center">Số lượng</div>
            <div class="col-md-2 fw-bold text-center">Tổng cộng</div>
          </div>
        </tr>
        </thead>
        <hr />
        <tbody>
      <c:forEach var="item" items="${sessionScope.cart.values}">
        <tr>
          <div class="row">
            <div class="col-md-4 text-center">
              <img src="${item.style.image}" alt="" class="Images of product" height="100%" width="70%"/>
            </div>
            <div class="col-md-2 text-center">${item.style.product.name}</div>
            <div class="col-md-2 text-center">${item.quantity}</div>
            <div class="col-md-2 text-center price">${item.style.product.price.lastPrice}</div>
            <div class="col-md-2 text-center price">${item.totalPrice}</div>
          </div>
        </tr>
        <hr />
      </c:forEach>
      <!-- Thong tin thanh toan-->
        <hr />
        <tr>
          <div class="row">
            <div class="col-md-3 fw-bold text-center">Tạm tính</div>
            <div class="col-md-6"></div>
            <div class="col-md-3 fw-bold text-center price">${sessionScope.cart.totalPrice}</div>
          </div>
          <div class="row">
            <div class="col-md-3 fw-bold text-center">Giao hàng</div>
            <div class="col-md-6"></div>
            <div class="col-md-3 fw-bold text-center price">
                ${sessionScope.cart.shippingFee}
            </div>
          </div>
          <div class="row">
            <div class="col-md-3 fw-bold text-center text-primary">
              Tổng
            </div>
            <div class="col-md-6"></div>
            <div class="col-md-3 fw-bold text-center text-primary price">
              ${sessionScope.cart.lastPrice}
            </div>
          </div>
        </tr>
        <hr />
        <tr>
          <h5 style="margin-left: 5px">Phương thức thanh toán</h5>
          <div class="row">
            <div class="col-md-5 text-center">
              <input type="radio" name="payment" id="payment-online" value="online"/>
              <label for="payment-online">Thanh toán chuyển khoản</label>
            </div>
          </div>
          <div class="row" id="messageOnline" style="display: none">
            <div class="col-md-1"></div>
            <div class="col-md-10">
              <p class="text-warning">
                Thực hiện thanh toán vào ngay tài khoản ngân hàng của
                chúng tôi. Vui lòng sử dụng Mã đơn hàng của bạn trong phần
                Nội dung thanh toán. Đơn hàng sẽ đươc giao sau khi tiền đã
                chuyển.
              </p>
            </div>
            <div class="col-md-1"></div>
          </div>
        </tr>
        <tr>
          <div class="row">
            <div class="col-md-5 text-center">
              <input
                      type="radio"
                      name="payment"
                      id="payment-cash"
                      value="cash"
                      checked
              />
              <label for="payment-cash">Thanh toán khi nhận hàng</label>
            </div>
            <div class="row" id="messageCash">
              <div class="col-md-1"></div>
              <div class="col-md-10">
                <p class="text-warning">Trả tiền mặt khi nhận hàng.</p>
              </div>
              <div class="col-md-1"></div>
            </div>
          </div>
        </tr>
        <tr>
          <div class="row">
            <div class="col-md-8"></div>
            <input
                    type="submit"
                    class="btn btn-warning col-md-4 text-white" value="Đặt hàng">
          </div>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
  </form>
</div>
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
  function toggleOtherAddress() {
    const checkbox = document.getElementById("otherAddress");
    const otherDelivery = document.getElementById("otherDelivery");
    otherDelivery.style.display = checkbox.checked ? "block" : "none";
  }
</script>
<!-- End payment -->
<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
<script src="js/payment.js"></script>
</body>
</html>