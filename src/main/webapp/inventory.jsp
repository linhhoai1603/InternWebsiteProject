<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <th>Xóa</th><th>Mã hàng</th><th>Tên hàng</th><th>Tên kiểu vải</th>
            <th>Tồn kho</th><th>Thực tế</th><th>Sai lệch</th><th>Tổng sai lệch</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td><button class="btn btn-sm btn-danger">🗑</button></td>
            <td>NAM010</td>
            <td>Cà vạt nam Hàn Quốc</td>
            <td>
              <div>kiểu 1</div>
              <div style="margin-top: 12px;">kiểu 1</div>
              <div style="margin-top: 12px;">kiểu 1</div>
            </td>
            <td>
              <div class="stock">5</div>
              <div class="stock" style="margin-top: 12px;">6</div>
              <div class="stock" style="margin-top: 12px;">8</div>
            </td>
            <td>
              <input class="form-control form-control-sm mb-1 actual" type="number" value="4" min="0">
              <input class="form-control form-control-sm mb-1 actual" type="number" value="1" min="0">
              <input class="form-control form-control-sm actual" type="number" value="5" min="0">
            </td>
            <td>
              <div class="diff">1</div>
              <div class="diff" style="margin-top: 12px;">5</div>
              <div class="diff" style="margin-top: 12px;">3</div>
            </td>
            <td class="total-diff">9</td>
          </tr>
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
        <p><strong>Trạng thái:</strong> <span class="badge bg-success">Phiếu tạm</span></p>
        <hr>
        <p><strong>Tổng số lượng thực tế :</strong> 0</p>

        <div class="card mb-3">
          <div class="card-header bg-warning text-dark p-2">Các sản phẩm được kiểm</div>
          <div class="scroll-check">
            <table class="table table-bordered table-sm mb-0">
              <thead class="table-light sticky-top">
              <tr><th>Tên sản phẩm</th></tr>
              </thead>
              <tbody>
              <tr><td>Cà vạt nam Hàn Quốc</td></tr>
              <tr><td>Áo sơ mi trắng</td></tr>
              <tr><td>Quần tây đen</td></tr>
              <tr><td>Giày da công sở</td></tr>
              <tr><td>Khăn choàng cổ</td></tr>
              <tr><td>Áo hoodie unisex</td></tr>
              </tbody>
            </table>
          </div>
        </div>

        <div class="mb-3">
          <label for="ghiChu" class="form-label">Ghi chú</label>
          <textarea class="form-control" id="ghiChu" rows="3" placeholder="Ghi chú..."></textarea>
        </div>
        <button class="btn btn-success w-100">Lưu</button>
      </div>
    </div>
  </div>
</div>

<script>
  const stockCells = document.querySelectorAll('.stock');
  const actualInputs = document.querySelectorAll('.actual');
  const diffCells = document.querySelectorAll('.diff');
  const totalDiff = document.querySelector('.total-diff');

  function updateDiffs() {
    let total = 0;
    actualInputs.forEach((input, index) => {
      const stock = parseInt(stockCells[index].textContent);
      let actual = parseInt(input.value);
      if (actual > stock) {
        actual = stock;
        input.value = stock;
      }
      const diff = stock - actual;
      diffCells[index].textContent = diff;
      total += diff;
    });
    totalDiff.textContent = total;
  }

  actualInputs.forEach(input => {
    input.addEventListener('input', updateDiffs);
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
