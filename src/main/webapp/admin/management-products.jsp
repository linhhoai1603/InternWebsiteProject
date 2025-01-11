<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/6/2024
  Time: 3:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản Lý Sản Phẩm</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>
<c:if test="${requestScope.products == null}">
    <script>
        window.location.href = "../admin/admin-manager-products?method=getAllProducts";
    </script>

</c:if>
<div class="container-fluid mt-4">
    <h2 class="center-text mb-4 text-center" style="color: #2c8b73">Danh Sách Sản Phẩm</h2>
    <!-- Nút kích hoạt Modal -->
    <button type="button" class="btn btn-primary float-end my-3 me-5" data-bs-toggle="modal" data-bs-target="#addProductModal">
        Thêm sản phẩm
    </button>
    <!-- Bảng thông tin sản phẩm -->
    <table class="table custom-table">
        <thead>
        <tr>
            <th>Mã Sản Phẩm</th>
            <th>Tên Sản Phẩm</th>
            <th>Số Lượng Còn Lại</th>
            <th>Ngày Thêm</th>
            <th>Danh Mục</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${requestScope.products}">
            <!-- Ví dụ sản phẩm 1 -->
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.quantity}</td>
                <td>${product.dateAdded}</td>
                <td>${product.category.name}</td>
                <td>
                    <a class="btn btn-warning" href="admin/admin-manager-products?method=detailProduct">Xem chi tiết</a>
                    <a class="btn btn-secondary" href="admin/admin-manager-products?method=stopBuy">Ngừng bán</a>
                    <a class="btn btn-danger" href="admin/admin-manager-products?method=delete">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <!-- Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Thêm sản phẩm mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="productForm" action="/submit-product" method="POST">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="name" class="form-label">Tên sản phẩm</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>

                        <div class="mb-3">
                            <label for="quantity" class="form-label">Số lượng</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" required>
                        </div>

                        <div class="mb-3">
                            <label for="category" class="form-label">Mã danh mục</label>
                            <input type="number" class="form-control" id="category" name="category" required>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="manufactureDate" class="form-label">Ngày sản xuất</label>
                            <input type="date" class="form-control" id="manufactureDate" name="manufactureDate" rows="3" required>
                        </div>

                        <div class="mb-3">
                            <label for="specifications" class="form-label">Thông số kỹ thuật</label>
                            <textarea class="form-control" id="specifications" name="specifications"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@include file="../includes/link/footLink.jsp"%>
</body>
</html>