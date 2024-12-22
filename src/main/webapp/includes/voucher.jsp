<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/6/2024
  Time: 2:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="includes/css/voucher.css">
<div class="container-fluid d-flex justify-content-center align-items-center">
  <!-- Thẻ Danh sách Voucher -->
  <div class="voucher-section">
    <h3 class="text-center text-white" style="background-color: #339C87; padding: 5px 600px">Danh sách Voucher</h3>
    <div class="voucher-container d-flex flex-wrap justify-content-center">
      <!-- Voucher 1 -->
      <c:forEach var="voucher" items="${sessionScope.vouchers}">
        <div class="voucher-item">
          <h6>Voucher: <span class="voucher-code fw-bold text-danger">${voucher.code}</span></h6>
          <p>Giảm ngay <span class="product-price">${voucher.discountAmount}</span> cho đơn hàng lớn hơn <span class="product-price">${voucher.conditionAmount}</span></p>
          <button class="copy-btn">Sao chép</button>
        </div>
      </c:forEach>
    </div>
  </div>
</div>
<script defer>
  // Lấy tất cả các nút "Sao chép"
  const copyButtons = document.querySelectorAll('.copy-btn');

  copyButtons.forEach(button => {
    button.addEventListener('click', () => {
      // Lấy mã voucher
      const voucherCode = button.parentElement.querySelector('.voucher-code').textContent;

      // Sao chép mã voucher vào clipboard
      navigator.clipboard.writeText(voucherCode).then(() => {
        alert('Đã sao chép mã voucher: ' + voucherCode);
      }).catch(err => {
        console.error('Sao chép thất bại: ', err);
      });
    });
  });

</script>