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
            <th>Tồn kho</th>
            <th>Thực tế</th>
            <th>Sai lệch</th>
            <th>Tổng sai lệch</th>
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
                <c:forEach var="style" items="${product.styles}" varStatus="loop">
                  <c:choose>
                    <c:when test="${loop.index == 0}">
                      <div class="stock">${style.quantity}</div>
                    </c:when>
                    <c:otherwise>
                      <div class="stock" style="margin-top: 12px;">${style.quantity}</div>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </td>
              <td>
                <c:forEach var="style" items="${product.styles}">
                  <input data-style-id="${style.id}" data-quantity="${style.quantity}" class="form-control form-control-sm mb-1 actual" type="number" value="0" min="0" oninput="calculateDiff(this)">
                </c:forEach>
              </td>
              <td>
                <c:forEach var="style" items="${product.styles}" varStatus="loop">
                  <c:choose>
                    <c:when test="${loop.index == 0}">
                      <div class="diff">0</div>
                    </c:when>
                    <c:otherwise>
                      <div class="diff" style="margin-top: 12px;">0</div>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </td>
              <td class="total-diff">0</td>
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
        <p><strong>Trạng thái:</strong> <span id="status-inventory" class="badge bg-success">Phiếu tạm</span></p>
        <hr>
        <p><strong>Tổng số lượng thực tế :</strong> <span id="totalActualQuantity">0</span></p>
        <p><strong>Tổng số lượng sai lêch :</strong> <span id="totalLossQuantity">0</span></p>

        <div class="card mb-3">
          <div class="card-header bg-warning text-dark p-2">Các sản phẩm được kiểm</div>
          <div class="scroll-check">
            <table class="table table-bordered table-sm mb-0">
              <thead class="table-light sticky-top">
              <tr><th>Tên sản phẩm</th></tr>
              </thead>
              <tbody>
              <c:forEach var="product" items="${requestScope.products}">
                <tr><td>${product.name}</td></tr>
              </c:forEach>

              </tbody>
            </table>
          </div>
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

<!-- Modal Xác nhận -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">Xác nhận lưu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn lưu phiếu kiểm kê này không?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary" id="confirmSave">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Thành công -->
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="successModalLabel">Thành công</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <i class="fas fa-check-circle text-success" style="font-size: 48px;"></i>
                <p class="mt-3">Đã lưu phiếu kiểm kê thành công!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script>
  function generateRandomInventoryCode() {
    const prefix = "PN";
    const randomNumber = Math.floor(100000 + Math.random() * 900000); // Random 6-digit number
    return prefix + randomNumber;
  }

  document.addEventListener('DOMContentLoaded', function() {
    const inventoryCodeSpan = document.getElementById('inventoryCode');
    if (inventoryCodeSpan) {
      inventoryCodeSpan.innerText = generateRandomInventoryCode();
    }

    // Thêm Font Awesome
    const fontAwesome = document.createElement('link');
    fontAwesome.rel = 'stylesheet';
    fontAwesome.href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css';
    document.head.appendChild(fontAwesome);

    function calculateDiff(inputElement) {
      // Lấy dòng sản phẩm chứa phần tử input này
      var row = inputElement.closest('tr');

      // Tìm phần tử Tồn kho trong dòng sản phẩm
      var stockElements = row.querySelectorAll('.stock');
      // Tìm phần tử Thực tế trong dòng sản phẩm
      var actualElements = row.querySelectorAll('.actual');
      // Tìm phần tử Sai lệch trong dòng sản phẩm
      var diffElements = row.querySelectorAll('.diff');
      // Tìm phần tử Tổng sai lệch trong dòng sản phẩm
      var totalDiffElement = row.querySelector('.total-diff');

      let totalDiff = 0;

      // Lặp qua tất cả các kiểu vải trong sản phẩm
      for (let i = 0; i < stockElements.length; i++) {
        let stock = parseInt(stockElements[i].innerText);
        let actual = parseInt(actualElements[i].value) || 0;

        // Ngăn không cho nhập số âm vào ô "Thực tế"
        if (actual < 0) {
          actual = 0;  // Nếu có số âm, thay đổi về 0
          actualElements[i].value = actual; // Cập nhật giá trị ô "Thực tế" về 0
        }

        // Tính sai lệch cho từng kiểu vải
        let diff = stock - actual;
        diffElements[i].innerText = diff >= 0 ? diff : 0; // Nếu sai lệch âm, gán bằng 0

        // Cộng dồn sai lệch vào tổng sai lệch
        totalDiff += diff >= 0 ? diff : 0;
      }

      // Cập nhật tổng sai lệch cho dòng sản phẩm
      totalDiffElement.innerText = totalDiff;
    }

    function updateTotalActualQuantity() {
      // Lấy tất cả các phần tử "Thực tế"
      var actualElements = document.querySelectorAll('.actual');

      // Tính tổng số lượng thực tế
      var totalActual = 0;
      actualElements.forEach(function (element) {
        totalActual += parseInt(element.value) || 0;  // Nếu không phải số hợp lệ, dùng 0
      });

      // Cập nhật tổng số lượng thực tế vào phần tử hiển thị
      document.getElementById('totalActualQuantity').innerText = totalActual;
    }

    // Xử lý nút lưu
    document.getElementById('btnSave').addEventListener('click', function() {
        const confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
        confirmModal.show();
    });

    // Xử lý xác nhận lưu
    document.getElementById('confirmSave').addEventListener('click', function() {
        const confirmModal = bootstrap.Modal.getInstance(document.getElementById('confirmModal'));
        confirmModal.hide();

        const status = document.getElementById("status-inventory").innerText.trim();
        const description = document.getElementById("ghiChu").value;

        const productsData = [];

        document.querySelectorAll("tr[data-product-id]").forEach(row => {
            const productId = parseInt(row.dataset.productId);
            const styleItems = [];
            let productTotalStockQuantity = 0;
            let productTotalActualQuantity = 0;

            row.querySelectorAll("input.actual").forEach(input => {
                const styleId = parseInt(input.dataset.styleId);
                const stockQuantity = parseInt(input.dataset.quantity);
                const actualQuantity = parseInt(input.value) || 0;

                productTotalStockQuantity += stockQuantity;
                productTotalActualQuantity += actualQuantity;

                styleItems.push({
                    idStyle: styleId,
                    stockQuantity: stockQuantity,
                    actualQuantity: actualQuantity
                });
            });

            let quantityLoss = 0;
            styleItems.forEach(item => {
                const diff = item.stockQuantity - item.actualQuantity;
                if (diff > 0) {
                    quantityLoss += diff;
                }
            });

            if (styleItems.length > 0) {
                productsData.push({
                    idProduct: productId,
                    quantityBefore: productTotalStockQuantity,
                    quantityLoss: quantityLoss,
                    style: styleItems
                });
            }
        });

        const payload = {
            deciption: description,
            status: status,
            products: productsData
        };

        fetch("/ProjectWeb/api/create-inventory", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(payload)
        })
        .then(res => res.json())
        .then(data => {
            if (data.message === "Inventory data saved successfully!") {
                const successModal = new bootstrap.Modal(document.getElementById('successModal'));
                successModal.show();
            } else {
                alert(data.message || "Unexpected response from server.");
            }
        })
        .catch(err => {
            console.error('Error:', err);
            alert("Không thể kết nối đến server hoặc xảy ra lỗi khi gửi dữ liệu.");
        });
    });
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
