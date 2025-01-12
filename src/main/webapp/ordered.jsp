<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<html>
<head>
  <title>Đơn hàng đã mua</title>
</head>
<body>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<link rel="stylesheet" href="css/shopping-cart.css">

<!-- Content -->
<div class="container-fluid">
  <div class="row" style="background-color: rgb(231, 231, 231); padding-top: 10px">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-10">
          <c:if test="${empty requestScope.orders}">
            <div class="text-center my-4">
              <h4>Bạn chưa có đơn hàng nào!</h4>
              <a href="products.jsp" class="btn btn-warning mt-3">Tiếp tục mua sắm</a>
            </div>
          </c:if>

          <!-- Danh sách đơn hàng -->
          <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
              <th scope="col">Mã đơn hàng</th>
              <th scope="col">Ngày đặt</th>
              <th scope="col">Tổng tiền</th>
              <th scope="col">Trạng thái</th>
              <th scope="col">Chi tiết</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="o" items="${requestScope.orders}">
              <tr>
                <td>${o.id}</td>
                <td>${o.timeOrdered}</td>
                <td class="price">${o.lastPrice}</td>
                <td>${o.status}</td>
                <td>
                  <!-- Hiển thị chi tiết đơn hàng trực tiếp -->
                  <c:if test="${not empty o.listOfDetailOrder}">
                    <table class="table">
                      <thead class="thead-dark">
                      <tr>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Giá tiền</th>
                        <th>Trọng lượng</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="detail" items="${o.listOfDetailOrder}">
                        <tr>
                          <td>${detail.style.name}</td>
                          <td>${detail.quantity}</td>
                          <td>${detail.totalPrice}</td>
                          <td>${detail.weight} kg</td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
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
</script>

<%@ include file="includes/footer.jsp" %>
<%@ include file="includes/link/footLink.jsp" %>
</body>
</html>
