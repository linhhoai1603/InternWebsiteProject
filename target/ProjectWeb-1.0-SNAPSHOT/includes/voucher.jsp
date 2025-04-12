<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/6/2024
  Time: 2:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="includes/css/voucher.css">

<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>

<div class="container-fluid d-flex justify-content-center align-items-center">
    <!-- Thẻ Danh sách Voucher -->
    <div class="voucher-section">
        <h3 class="text-center text-white" style="background-color: #339C87; padding: 5px 600px"><fmt:message
                key="vouchers"/></h3>
        <div class="voucher-container d-flex flex-wrap justify-content-center">
            <!-- Voucher 1 -->
            <c:forEach var="voucher" items="${sessionScope.vouchers}">
                <div class="voucher-item">
                    <div class="voucher-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path d="M3 17a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V7c0-1.1-.9-2-2-2H5a2 2 0 0 0-2 2v10zm5.71-3L5 10l1.41-1.41L8.71 12 12 8.29 13.41 9.7 8.71 14zm7.29 0L14 10l1.41-1.41L17.71 12 21 8.29 22.41 9.7 17.71 14z"/>
                        </svg>
                    </div>
                    <div class="voucher-details">
                        <div class="voucher-description">
                            Giảm ngay <span class="product-price">${voucher.discountAmount}</span>
                        </div>
                        <div class="voucher-description">
                            cho đơn hàng lớn hơn <span class="product-price">${voucher.conditionAmount}</span>
                        </div>
                    </div>
                    <div class="voucher-actions">
                        <a href="#" class="voucher-details-link">Chi tiết</a>
                        <button class="copy-btn">Sao chép</button>
                    </div>
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