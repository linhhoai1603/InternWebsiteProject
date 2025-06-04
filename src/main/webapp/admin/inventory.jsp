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
        <p><strong>Mã kiểm kho :</strong> PN000044</p>
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

<script>
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


    document.getElementById("btnSave").addEventListener("click", function () {
    if (!confirm("Bạn có muốn lưu không?")) return;

    const description = document.getElementById("ghiChu").value;
    const status = document.getElementById("status-inventory").value;
    const data = [];

    // Duyệt tất cả các hàng sản phẩm
    document.querySelectorAll("tr[data-product-id]").forEach(row => {
    const productId = parseInt(row.dataset.productId);
    const items = [];

    // Duyệt qua các input thực tế trong hàng đó
    row.querySelectorAll("input.actual").forEach(input => {
    const styleId = parseInt(input.dataset.styleId);
    const tonkho = parseInt(input.dataset.quantity);
    const thucte = parseInt(input.value);

    items.push({
    id: styleId,
    tonkho: tonkho,
    thucte: thucte
  });
  });

    data.push({
    id: productId,
    items: items
  });
  });

    // Gửi dữ liệu đến server
    fetch("/api/create-inventory", {
    method: "POST",
    headers: {
    "Content-Type": "application/json"
  },
    body: JSON.stringify({
    status : status,
    description: description,
    products: data
  })
  })
    .then(res => {
    if (res.ok) {
    alert("Lưu thành công!");
  } else {
    alert("Có lỗi khi lưu dữ liệu!");
  }
  })
    .catch(err => {
    console.error(err);
    alert("Không thể kết nối đến server.");
  });
  });



</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
