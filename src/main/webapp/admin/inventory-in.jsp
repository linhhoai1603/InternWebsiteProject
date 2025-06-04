<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kiểm kho</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table-wrapper {
            max-height: 500px;
            overflow-y: auto;
        }
        .scroll-check {
            max-height: 200px;
            overflow-y: auto;
        }
        .icon-btn {
            width: 40px;
            height: 40px;
            padding: 0;
        }
        td table {
            border-collapse: separate;
            border-spacing: 8px 0;
        }
        td table td {
            background-color: #f9f9f9;
            padding: 4px 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            text-align: center;
            white-space: nowrap;
        }
    </style>
</head>
<body>
<h1 class="h3 text-dark">🎞 Kiểm kê kho</h1>

<div class="row mb-4 align-items-center">
    <div class="col-md-6">
        <div class="input-group">
            <span class="input-group-text">🔍</span>
            <input type="text" class="form-control" placeholder="Tìm hàng hóa theo mã hoặc tên (F3)">
            <button class="btn btn-outline-secondary icon-btn" type="button" title="Danh sách hàng">📋</button>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-8 mb-4">
        <div class="card">
            <div class="card-header bg-primary text-white">Danh sách sản phẩm</div>
            <div class="table-wrapper">
                <table class="table table-striped table-hover mb-0">
                    <thead class="table-light sticky-top">
                    <tr>
                        <th>Xóa</th>
                        <th>Mã hàng</th>
                        <th>Tên hàng</th>
                        <th>Tên kiểu vải</th>
                        <th>Số lượng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${requestScope.products}">
                        <tr data-product-id="${product.id}">
                            <td><button class="btn btn-sm btn-danger">🗑</button></td>
                            <td>${product.id}</td>
                            <td>${product.name}</td>
                            <td>
                                <c:forEach var="style" items="${product.styles}" varStatus="loop">
                                    <c:choose>
                                        <c:when test="${loop.index == 0}">
                                            <div>${style.name}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="margin-top: 12px;">${style.name}</div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </td>
                            <td>
                                <c:forEach var="style" items="${product.styles}">
                                    <input data-style-id="${style.id}" data-quantity="${style.quantity}" class="form-control form-control-sm mb-1 actual" type="number" value="0" min="0" oninput="calculateDiff(this)">
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <div class="card mb-3">
            <div class="card-header bg-secondary text-white">Thông tin đơn</div>
            <div class="card-body">
                <p><strong>Mã kiểm kho :</strong> <span id="inventoryCode">PN000044</span></p>
                <p><strong>Trạng thái:</strong> <span id="status-inventory" class="badge bg-success">Phiếu nhập hàng</span></p>
                <hr>
                <div class="mb-3">
                    <label for="nhaCungCap" class="form-label">Tên nhà cung cấp</label>
                    <input type="text" class="form-control" id="nhaCungCap" placeholder="Nhập tên nhà cung cấp">
                </div>

                <!-- Nhập số tiền hàng -->
                <div class="mb-3">
                    <label for="soTienHang" class="form-label">Số tiền hàng</label>
                    <input type="number" class="form-control" id="soTienHang" placeholder="Nhập số tiền hàng">
                </div>
                <div class="mb-3">
                    <label for="ghiChu" class="form-label">Ghi chú</label>
                    <textarea class="form-control" id="ghiChu" rows="3" placeholder="Ghi chú..."></textarea>
                </div>
                <button id="btnSave" class="btn btn-success w-100">Lưu</button>

            </div>
        </div>
    </div>
</div>
<script>
    function generateRandomInventoryCode() {
        const prefix = "PN"; // Hoặc tiền tố khác cho phiếu nhập
        const randomNumber = Math.floor(100000 + Math.random() * 900000); // Random 6-digit number
        return prefix + randomNumber;
    }

    document.addEventListener('DOMContentLoaded', function() {
        const inventoryCodeSpan = document.getElementById('inventoryCode');
        if (inventoryCodeSpan) {
            inventoryCodeSpan.innerText = generateRandomInventoryCode();
        }

        document.getElementById('btnSave').addEventListener('click', function () {
            if (!confirm("Bạn có muốn lưu không?")) return;

            // Collect data from the form
            // API expects 'deciption' with typo
            const deciption = document.getElementById('ghiChu').value.trim(); // Get ghiChu as deciption
            const status = document.getElementById('status-inventory').innerText.trim(); // Get status text
            // Fields like code, supplier, totalAmount, type are not used by /api/create-inventory-in based on provided code
            // const inventoryCode = document.getElementById('inventoryCode').innerText; // Not used by this API
            // const supplier = document.getElementById('nhaCungCap').value.trim(); // Not used by this API
            // const totalAmount = document.getElementById('soTienHang').value.trim(); // Not used by this API
            // const inventoryType = 1; // Not used by this API

            const productsData = [];

            // Duyệt tất cả các hàng sản phẩm để thu thập chi tiết
            document.querySelectorAll('tbody tr[data-product-id]').forEach(row => {
                const productId = row.getAttribute('data-product-id');
                const inputElements = row.querySelectorAll('input[data-style-id]');

                const styleItems = [];
                let totalQuantityForProduct = 0; // Calculate total quantity imported for this product

                inputElements.forEach(input => {
                    const styleId = input.getAttribute('data-style-id');
                    const quantityImported = parseInt(input.value) || 0; // Số lượng nhập cho kiểu vải

                    // Prepare style item matching API expectation: {idStyle: ..., imported: ...}
                    styleItems.push({
                        idStyle: parseInt(styleId),
                        imported: quantityImported // Tên trường 'imported' theo API
                    });

                    totalQuantityForProduct += quantityImported; // Add to product total
                });

                // Prepare product data matching API expectation: {idProduct: ..., quantityImported: ..., style: [...]}
                if (styleItems.length > 0) {
                     productsData.push({
                         idProduct: parseInt(productId),
                         quantityImported: totalQuantityForProduct, // Tổng số lượng nhập cho sản phẩm
                         style: styleItems // Mảng các kiểu vải
                     });
                }
            });

            // Prepare JSON payload matching API structure
            const payload = {
                deciption: deciption, // Tên trường 'deciption' theo API
                status: status,
                products: productsData
            };

            // Send data to server using Fetch API to the API endpoint
            fetch('/ProjectWeb/api/create-inventory-in', { // Correct API endpoint
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload)
            })
            .then(response => response.json())
            .then(data => {
                 if (data && data.status === 'ok') {
                     alert('Đã lưu thành công!');
                     // Optional: Redirect or update UI on success
                     // window.location.reload(); // Example: reload page on success
                 } else if (data && data.error) {
                     alert('Lỗi từ server: ' + data.error);
                 } else {
                     alert("Unexpected response from server.");
                 }
            })
            .catch(error => {
                console.error('Lỗi:', error);
                alert('Đã xảy ra lỗi khi gửi dữ liệu!');
            });
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
