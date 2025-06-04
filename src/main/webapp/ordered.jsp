<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Lịch sử đơn hàng</title>
    <link rel="stylesheet" href="css/view_orders.css">
</head>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<!-- Content -->
<div class="container-fluid order-history-page">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 order-history-container">
                <h3 class="order-history-header"><fmt:message key="dhdh_header"/></h3>

                <c:if test="${empty requestScope.orders}">
                    <div class="no-orders-message">
                        <h4><fmt:message key="bccdh"/></h4>
                        <a href="products.jsp" class="btn btn-warning mt-3"><fmt:message key="ttms"/></a>
                    </div>
                </c:if>

                <c:if test="${not empty requestScope.orders}">
                    <!-- Danh sách đơn hàng -->
                    <table class="table table-bordered table-striped orders-table">
                        <thead class="table-dark">
                        <tr>
                            <th scope="col"><fmt:message key="mdh"/></th>
                            <th scope="col"><fmt:message key="ngaydat"/></th>
                            <th scope="col"><fmt:message key="sum"/></th>
                            <th scope="col"><fmt:message key="trang"/></th>
                            <th scope="col" style="width: 50%;"><fmt:message key="chi"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="o" items="${requestScope.orders}">
                            <tr>
                                <td>#${o.id}</td>
                                <td>
                                    <c:set var="timePattern" value="yyyy-MM-dd'T'HH:mm:ss"/>
                                    <c:catch var="parseException">
                                        <fmt:parseDate value="${o.timeOrdered}" pattern="${timePattern}" var="parsedDateTime" type="both"/>
                                    </c:catch>
                                    <c:if test="${empty parseException && not empty parsedDateTime}">
                                        <fmt:formatDate value="${parsedDateTime}" pattern="dd/MM/yyyy HH:mm:ss" />
                                    </c:if>
                                    <c:if test="${not empty parseException || empty parsedDateTime}">
                                        ${o.timeOrdered}
                                    </c:if>
                                </td>
                                <td class="price">${o.lastPrice}</td>
                                <td>
                                    <c:set var="statusClass" value=""/>
                                    <c:choose>
                                        <c:when test="${o.status == 'Chờ xác nhận'}"><c:set var="statusClass" value="status-pending"/></c:when>
                                        <c:when test="${o.status == 'Đang xử lý'}"><c:set var="statusClass" value="status-processing"/></c:when>
                                        <c:when test="${o.status == 'Đã giao hàng'}"><c:set var="statusClass" value="status-shipped"/></c:when>
                                        <c:when test="${o.status == 'Đã giao' || o.status == 'Hoàn thành' || o.status == 'Completed'}"><c:set var="statusClass" value="status-completed"/></c:when>
                                        <c:when test="${o.status == 'Đã hủy'}"><c:set var="statusClass" value="status-cancelled"/></c:when>
                                        <c:when test="${o.status == 'Đã thanh toán VNPAY'}"><c:set var="statusClass" value="status-paid"/></c:when>
                                    </c:choose>
                                    <span class="order-status ${statusClass}">${o.status}</span>
                                </td>
                                <td>
                                    <c:if test="${not empty o.listOfDetailOrder}">
                                        <table class="table table-sm order-details-table"> <%-- Thêm class cho bảng con --%>
                                            <thead>
                                            <tr>
                                                <th><fmt:message key="tensp"/></th>
                                                <th><fmt:message key="loaisanpham"/></th>
                                                <th><fmt:message key="soluong"/></th>
                                                <th><fmt:message key="giatien"/></th>
                                                <th><fmt:message key="trongluong"/></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="detail" items="${o.listOfDetailOrder}">
                                                <tr>
                                                    <td>${detail.style.product.name}</td>
                                                    <td>${detail.style.name}</td>
                                                    <td>${detail.quantity}</td>
                                                    <td class="price">${detail.totalPrice}</td>
                                                    <td>
                                                        <c:if test="${not empty detail.weight && detail.weight > 0}">
                                                            ${detail.weight} kg
                                                        </c:if>
                                                    </td>
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
                </c:if>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
        }

        document.querySelectorAll(".price").forEach(el => {
            const originalPriceText = el.textContent.trim().replace("VND", "").replace(/\./g, "").replace(",", ".");
            if (originalPriceText && !isNaN(parseFloat(originalPriceText))) {
                el.textContent = formatCurrency(parseFloat(originalPriceText));
            }
        });
    });
</script>

<%@ include file="includes/footer.jsp" %>
<%@ include file="includes/link/footLink.jsp" %>
</body>
</html>
