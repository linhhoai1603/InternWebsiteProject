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
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/payment.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- Create payment with col-md-6, input infor delivery, right col-md-6 infor product, both table-->
<div class="container">
  <div class="row mt-5">
    <p>Bạn có mã ưu đãi?<a id="voucher">&nbsp;Ấn vào đây để nhập mã?</a></p>
    <div id="inputVoucher">
      <h5>Nếu bạn có mã giảm giá, vui lòng điền vào phía bên dưới.</h5>
      <input type="text" placeholder="Mã ưu đãi" style="padding: 10px" />
      <button type="submit" class="btn btn-primary">Áp dụng</button>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6">
      <h4 style="color: #339c87" class="mt-4 mb-3">Thông tin giao hàng</h4>
      <form action="" class="form">
        <div class="row">
          <div class="col-md-6">
            <label class="fw-bold" for="name"
            >Họ và tên: <span class="text-red">*</span></label
            >
            <input type="text" class="form-control" id="name" name="name" />
          </div>
          <div class="col-md-6">
            <label class="fw-bold" for="phone"
            >Số điện thoại: <span class="text-red">*</span></label
            >
            <input
                    type="text"
                    class="form-control"
                    id="phone"
                    name="phone"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <label class="fw-bold" for="address"
            >Địa chỉ: <span class="text-red">*</span></label
            >
            <input
                    type="text"
                    class="form-control"
                    id="address"
                    name="address"
            />
          </div>
          <div class="col-md-6">
            <label class="fw-bold" for="otherPhone"
            >Số điện thoại khác: <span class="text-red">*</span></label
            >
            <input
                    type="text"
                    name="otherPhone"
                    id="otherPhone"
                    class="form-control"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-md-11">
            <label for="note" class="fw-bold">Ghi chú đơn hàng (tùy chọn):</label>
            <textarea
                    name="note"
                    id="note"
                    style="margin-left: 10px; height: 150px"
                    class="form-control"
                    placeholder="Ghi chú giao hàng"
            ></textarea>
          </div>
        </div>
      </form>
      <input type="checkbox" name="otherAddress" id="otherAddress" />
      <label for="otherAddress">Giao hàng tới địa chỉ khác</label>
      <div id="otherDelivery" style="margin-top: 10px">
        <form action="" id="form-otherAddress">
          <div class="row">
            <div class="col-md-6">
              <label class="fw-bold" for="fullName">Họ và tên</label>
              <input
                      type="text"
                      class="form-control"
                      id="fullName"
                      name="fullName"
              />
            </div>
            <div class="col-md-6">
              <label class="fw-bold" for="o-phone">Số điện thoại</label>
              <input
                      type="text"
                      class="form-control"
                      id="o-phone"
                      name="o-phone"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <label class="fw-bold" for="o-company">Tên công ty</label>
              <input
                      type="text"
                      class="form-control"
                      id="o-company"
                      name="o-company"
              />
            </div>
          </div>

          <div class="row">
            <div class="col-md-6">
              <p class="fw-bold">Quốc gia/ Khu vực</p>
              <p class="fw-bold" style="margin-left: 10px">
                Việt Nam
                <img
                        src="images/coToQuoc.webp"
                        alt="Cờ tổ quốc"
                        style="width: 30px; height: 30px"
                />
              </p>
            </div>
            <div class="col-md-6">
              <p class="fw-bold">Tỉnh/ Thành phố</p>
              <select name="city" id="city" class="form-control">
                <option value="">Chọn tỉnh/thành phố</option>
                <option value="An Giang">An Giang</option>
                <option value="Bà Rịa - Vũng Tàu">Bà Rịa - Vũng Tàu</option>
                <option value="Bắc Giang">Bắc Giang</option>
                <option value="Bắc Ninh">Bắc Ninh</option>
                <option value="Bến Tre">Bến Tre</option>
                <option value="Bình Định">Bình Định</option>
                <option value="Bình Dương">Bình Dương</option>
                <option value="Bình Phước">Bình Phước</option>
                <option value="Cà Mau">Cà Mau</option>
                <option value="Cần Thơ">Cần Thơ</option>
                <option value="Đà Nẵng">Đà Nẵng</option>
                <option value="Đắk Lắk">Đắk Lắk</option>
                <option value="Đắk Nông">Đắk Nông</option>
                <option value="Điện Biên">Điện Biên</option>
                <option value="Hà Giang">Hà Giang</option>
                <option value="Hà Nam">Hà Nam</option>
                <option value="Hà Nội">Hà Nội</option>
                <option value="Hà Tĩnh">Hà Tĩnh</option>
                <option value="Hải Dương">Hải Dương</option>
                <option value="Hải Phòng">Hải Phòng</option>
                <option value="Hòa Bình">Hòa Bình</option>
                <option value="Hưng Yên">Hưng Yên</option>
                <option value="Khánh Hòa">Khánh Hòa</option>
                <option value="Kiên Giang">Kiên Giang</option>
                <option value="Kon Tum">Kon Tum</option>
                <option value="Lạng Sơn">Lạng Sơn</option>
                <option value="Lào Cai">Lào Cai</option>
                <option value="Long An">Long An</option>
                <option value="Nam Định">Nam Định</option>
                <option value="Ninh Bình">Ninh Bình</option>
                <option value="Ninh Thuận">Ninh Thuận</option>
                <option value="Phú Thọ">Phú Thọ</option>
                <option value="Phú Yên">Phú Yên</option>
                <option value="Quảng Bình">Quảng Bình</option>
                <option value="Quảng Nam">Quảng Nam</option>
                <option value="Quảng Ngãi">Quảng Ngãi</option>
                <option value="Quảng Ninh">Quảng Ninh</option>
                <option value="Quảng Trị">Quảng Trị</option>
                <option value="Sóc Trăng">Sóc Trăng</option>
                <option value="Sơn La">Sơn La</option>
                <option value="Tây Ninh">Tây Ninh</option>
                <option value="Thái Bình">Thái Bình</option>
                <option value="Thái Nguyên">Thái Nguyên</option>
                <option value="Thanh Hóa">Thanh Hóa</option>
                <option value="Thừa Thiên - Huế">Thừa Thiên - Huế</option>
                <option value="Tiền Giang">Tiền Giang</option>
                <option value="Trà Vinh">Trà Vinh</option>
                <option value="Tuyên Quang">Tuyên Quang</option>
                <option value="Vĩnh Long">Vĩnh Long</option>
                <option value="Vĩnh Phúc">Vĩnh Phúc</option>
                <option value="Yên Bái">Yên Bái</option>
              </select>
            </div>
            <div class="row">
              <label for="o-spAddress">Địa chỉ cụ thể(Huyện/Xã/Thôn)</label>
              <input
                      type="text"
                      name="o-spAddress"
                      id="o-spAddress"
                      class="form-control"
                      style="margin-left: 10px"
              />
            </div>
            <div class="row">
              <label for="o-note" class="fw-bold"
              >Ghi chú đơn hàng (tùy chọn):</label
              >
              <textarea
                      name="o-note"
                      id="o-note"
                      style="margin-left: 10px; height: 150px"
                      class="form-control"
              ></textarea>
            </div>
          </div>
        </form>
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
            <div class="col-md-3 fw-bold text-center">Sản phẩm</div>
            <div class="col-md-3 fw-bold text-center">Tên</div>
            <div class="col-md-3 fw-bold text-center">Số lượng</div>
            <div class="col-md-3 fw-bold text-center">Tổng cộng</div>
          </div>
        </tr>
        </thead>
        <hr />
        <tbody>
        <tr>
          <div class="row">
            <div class="col-md-3 text-center">
              <img src="images/cart2.jpg" alt="" class="img-pay" />
            </div>
            <div class="col-md-3 text-center">Vải lụa</div>
            <div class="col-md-3 text-center">1</div>
            <div class="col-md-3 text-center">100,000đ</div>
          </div>
        </tr>
        <hr />
        <tr>
          <div class="row">
            <div class="col-md-3 text-center">
              <img src="images/cart1.jpg" alt="" class="img-pay" />
            </div>
            <div class="col-md-3 text-center">Vải kaki</div>
            <div class="col-md-3 text-center">1</div>
            <div class="col-md-3 text-center">150,000đ</div>
          </div>
        </tr>
        <hr />
        <tr>
          <div class="row">
            <div class="col-md-3 text-center">
              <img src="images/cart3.jpg" alt="" class="img-pay" />
            </div>
            <div class="col-md-3 text-center">Vải nhung</div>
            <div class="col-md-3 text-center">1</div>
            <div class="col-md-3 text-center">200,000đ</div>
          </div>
        </tr>
        <hr />
        <tr>
          <div class="row">
            <div class="col-md-3 fw-bold text-center">Tạm tính</div>
            <div class="col-md-6"></div>
            <div class="col-md-3 fw-bold text-center">450,000đ</div>
          </div>
          <div class="row">
            <div class="col-md-3 fw-bold text-center">Giao hàng</div>
            <div class="col-md-6"></div>
            <div class="col-md-3 fw-bold text-center">
               30,000đ
            </div>
          </div>
          <div class="row">
            <div class="col-md-3 fw-bold text-center text-primary">
              Tổng
            </div>
            <div class="col-md-6"></div>
            <div class="col-md-3 fw-bold text-center text-primary">
              480,000đ
            </div>
          </div>
        </tr>
        <hr />
        <tr>
          <h5 style="margin-left: 5px">Phương thức thanh toán</h5>
          <div class="row">
            <div class="col-md-5 text-center">
              <input type="radio" name="payment" id="payment-online" />
              <label for="payment-online">Thanh toán chuyển khoản</label>
            </div>
          </div>
          <div class="row" id="messageOnline" style="display: none">
            <div class="col-md-1"></div>
            <div class="col-md-10">
              <p>
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
                      checked
              />
              <label for="payment-cash">Thanh toán khi nhận hàng</label>
            </div>
            <div class="row" id="messageCash">
              <div class="col-md-1"></div>
              <div class="col-md-10">
                <p>Trả tiền mặt khi nhận hàng.</p>
              </div>
              <div class="col-md-1"></div>
            </div>
          </div>
        </tr>
        <tr>
          <div class="row">
            <div class="col-md-8"></div>
            <a
                    href="payment-success.jsp"
                    class="btn btn-warning col-md-4 text-white"
            >Đặt hàng</a
            >
          </div>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>
<!-- End payment -->
<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
<script src="js/payment.js"></script>
</body>
</html>