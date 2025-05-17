<%--
  Created by IntelliJ IDEA.
  User: mypc
  Date: 5/14/2025
  Time: 9:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }

        .voucher-header {
            background-color: #339C87;
            color: white;
            text-align: center;
            padding: 15px;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .coupon {
            border-radius: 15px;
            box-shadow: 3px 5px 10px #d6d5d555;
            background: linear-gradient(135deg, #f8bbd0, #f48fb1);
            border: 2px dashed #e91e63;
            padding: 10px;
            position: relative;
        }

        .ribbon {
            position: absolute;
            top: -7px;
            left: -7px;
            background: #e91e63;
            color: white;
            padding: 3px 10px;
            font-size: 12px;
            font-weight: bold;
            border-radius: 0 7px 7px 0;
            z-index: 999;
        }

        .logo-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }

        .coupon h1 {
            font-size: 2rem;
            margin-bottom: 0;
            line-height: 1;
        }

        .coupon .off span {
            font-size: 0.8rem;
            align-self: flex-end;
            margin-bottom: 0.2rem;
            line-height: 1;
        }

        .coupon .promo-line {
            padding-top: 3px;
            padding-bottom: 3px;
            font-size: 0.8rem;
            margin-top: 5px;
        }

        .code {
            border: 1px solid #28a745;
            padding: 2px 6px;
            font-size: 0.8rem;
            border-radius: .2rem;
            background-color: white;
            color: #333;
        }

        .code:hover {
            background: green;
            color: #fff;
            cursor: pointer;
        }

        .coupon .promo-line a, .coupon .promo-line button {
            font-size: 0.75rem;
        }

        .coupon .promo-line .copy-btn {
            background-color: #e91e63;
            color: white;
            border: none;
            padding: 3px 6px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .coupon .promo-line .copy-btn:hover {
            background-color: #c2185b;
        }

        .coupon .promo-line .voucher-details-link {
            color: #e91e63;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
            line-height: normal;
        }

        .coupon .promo-line .voucher-details-link:hover {
            text-decoration: underline;
        }

        .carousel-item {
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="voucher-header">VOUCHERS</div>
    <c:if test="${empty sessionScope.vouchers}">
        <div class="alert alert-info text-center" role="alert">
            Hiện tại không có voucher nào.
        </div>
    </c:if>
    <!-- voucher -->
    <div id="voucherCarousel" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <c:forEach items="${sessionScope.vouchers}" var="voucher" varStatus="loop">
                <c:if test="${loop.index % 3 == 0}">
                    <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                    <div class="d-flex justify-content-center row">
                </c:if>
                <div class="col-md-4">
                    <div class="coupon">
                        <div class="ribbon">SALE</div>
                        <div class="row no-gutters">
                            <div class="col-md-4 border-right logo-container">
                                <div class="d-flex flex-column align-items-center">
                                    <img src="images/logo.png" alt="Logo" style="width: 50px; height: 50px"/>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="p-2">
                                    <div class="d-flex flex-row justify-content-end off">
                                        <h1><fmt:formatNumber value="${voucher.discountValue}" type="number"
                                                              groupingUsed="true"/></h1>
                                        <span class="ml-1">OFF</span>
                                    </div>
                                    <div class="d-flex flex-row justify-content-between align-items-center promo-line">
                                        <div>
                                            <span><b>Code:</b></span>
                                            <span class="border border-success rounded code ml-1">${voucher.code}</span>
                                        </div>
                                        <div>
                                            <a href="#" class="voucher-details-link mr-3" data-bs-toggle="modal"
                                               data-bs-target="#voucherDetailModal"
                                               data-code="${fn:escapeXml(voucher.code)}"
                                               data-discount="${fn:escapeXml(voucher.discountValue)}"
                                               data-condition-min-spend="Áp dụng cho đơn hàng từ ${fn:escapeXml(voucher.minimumSpend)}."
                                               data-condition-no-combo="Không áp dụng chung với các khuyến mãi khác."
                                               data-condition-end-date="Hạn sử dụng: <fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy"/>"
                                               data-description="${fn:escapeXml(voucher.description)}">Chi tiết</a>
                                            <button class="copy-btn">Sao chép</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <c:if test="${(loop.index + 1) % 3 == 0 || loop.last}">
                    </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <a class="carousel-control-prev" href="#voucherCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#voucherCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>
<!-- Voucher Details Modal -->
<div class="modal fade" id="voucherDetailModal" tabindex="-1" role="dialog" aria-labelledby="voucherDetailModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="voucherDetailModalLabel">Chi Tiết Voucher</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <p><strong>Mã Voucher:</strong> <span id="modalVoucherCode"></span></p>
                <p><strong>Giảm giá:</strong> <span id="modalVoucherDiscount"></span></p>
                <p><strong>Điều kiện áp dụng:</strong></p>
                <ul id="modalVoucherConditions" style="padding-left: 20px;">
                </ul>
                <p><strong>Mô tả:</strong> <span id="modalVoucherDescription"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function () {
        console.log("Bắt đầu");
        $('#voucherDetailModal').on('show.bs.modal', function (event) {
            console.log("Modal show.bs.modal event triggered!");

            // Lấy nút kích hoạt modal
            var button = $(event.relatedTarget);
            console.log("Nút kích hoạt:", button);

            // Kiểm tra nếu button không tồn tại
            if (!button.length) {
                console.error("Không tìm thấy nút kích hoạt modal.");
                return;
            }

            // Lấy dữ liệu từ các thuộc tính data-* của link
            var code = button.data('code');
            var discount = button.data('discount');
            if (!isNaN(discount)) {
                discount = parseFloat(discount).toLocaleString('vi-VN');
            }
            var description = button.data('description');
            console.log("Code:", code, "Discount:", discount, "Description:", description);

            // Lấy từng điều kiện
            var condMinSpend = button.data('condition-min-spend');
            var condNoCombo = button.data('condition-no-combo');
            var condEndDate = button.data('condition-end-date');

            var modal = $(this);

            modal.find('#modalVoucherCode').text(code || "N/A");
            modal.find('#modalVoucherDiscount').text(
                (discount ? discount.toString() : "0") +
                (discount && (discount.toString().includes('%') || discount.toString().toLowerCase().includes('off')) ? '' : (discount ? ' OFF' : ''))
            );

            var conditionsListElement = modal.find('#modalVoucherConditions');
            conditionsListElement.empty();

            var conditionsToDisplay = [];
            if (condMinSpend) conditionsToDisplay.push(condMinSpend);
            if (condNoCombo) conditionsToDisplay.push(condNoCombo);
            if (condEndDate) conditionsToDisplay.push(condEndDate);

            if (conditionsToDisplay.length > 0) {
                conditionsToDisplay.forEach(function (condition) {
                    conditionsListElement.append($('<li>').text(condition));
                });
            } else {
                conditionsListElement.append('<li>Không có điều kiện áp dụng cụ thể.</li>');
            }

            modal.find('#modalVoucherDescription').text(description || "Không có mô tả chi tiết.");
        });

        function copyToClipboard(text) {
            var tempInput = document.createElement("textarea");
            tempInput.style.position = "absolute";
            tempInput.style.left = "-9999px";
            tempInput.value = text;
            document.body.appendChild(tempInput);
            tempInput.select();
            document.body.removeChild(tempInput);
        }

        $(document).on('click', '.copy-btn', function () {
            var codeElement = $(this).closest('.coupon').find('.code');
            if (codeElement.length) {
                var codeToCopy = codeElement.text().trim();
                copyToClipboard(codeToCopy);
            } else {
                console.error('Không tìm thấy mã voucher.');
            }
        });
    });
</script>
</body>
</html>