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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>
<c:if test="${requestScope.products == null}">
    <script>
        window.location.href = "../admin/admin-manager-products?method=getAllProducts";
    </script>
</c:if>
<!-- Lấy giá trị error và username từ request scope -->
<c:set var="message" value="${not empty requestScope.message ? requestScope.message : ''}" />

<!-- Hiển thị thông báo nếu có lỗi -->
<c:if test="${not empty message}">
    <script type="text/javascript">
        Swal.fire({
            title: 'Thông báo',
            text: "${message}"
        });
    </script>
</c:if>
<div class="container-fluid mt-4">
    <h2 class="header-title">Danh Sách Sản Phẩm</h2>
    <!-- Thanh công cụ gồm nút thêm sản phẩm và form tìm kiếm -->
    <div class="d-flex justify-content-between align-items-center my-3 me-5">
        <!-- Nút kích hoạt Modal -->
        <a class="btn btn-warning" href="admin-manager-products">Xem tất cả sản phẩm</a>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
            Thêm sản phẩm
        </button>

        <!-- Form tìm kiếm -->
        <form class="d-flex" action="admin-manager-products?method=searchProduct" method="POST">
            <input type="hidden" name="method" value="searchProduct">
            <input class="form-control me-2" type="search" name="inputName" placeholder="Tìm kiếm sản phẩm theo ID" aria-label="Search" required>
            <button class="btn btn-primary" type="submit">Tìm kiếm</button>
        </form>
    </div>

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
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.quantity}</td>
                <td>${product.dateAdded}</td>
                <td>${product.category.name}</td>
                <td>
                    <form id="detailForm" action="admin-manager-products" method="POST" style="display: inline;">
                        <input type="hidden" name="method" value="detailProduct">
                        <input type="hidden" name="id" value="${product.id}">
                        <button type="submit" class="btn btn-warning">Xem chi tiết</button>
                    </form>

                    <c:if test="${product.selling == 1}">
                    <!-- Form dừng bán -->
                    <form id="stopBuyForm" action="admin-manager-products" method="POST" style="display: inline;">
                        <input type="hidden" name="method" value="stopBuy">
                        <input type="hidden" name="id" value="${product.id}">
                        <button type="submit" class="btn btn-secondary">Ngừng bán</button>
                    </form>
                    </c:if>
                    <c:if test="${product.selling == 0}">
                    <!-- Form tiếp tục bán -->
                    <form id="startBuyForm" action="admin-manager-products" method="POST" style="display: inline;">
                        <input type="hidden" name="method" value="startBuy">
                        <input type="hidden" name="id" value="${product.id}">
                        <button type="submit" class="btn btn-success">Tiếp tục bán</button>
                    </form>
                    </c:if>
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
                <form id="productForm" action="admin-manager-products?method=addProduct" method="POST">
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
                            <label for="area" class="form-label">Diện tích</label>
                            <input type="number" class="form-control" id="area" name="area" required>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="selling" class="form-label">Trạng thái bán</label>
                            <select class="form-select" id="selling" name="selling" required>
                                <option value="active">Đang bán</option>
                                <option value="inactive">Ngừng bán</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="image" class="form-label">URL hình ảnh</label>
                            <input type="url" class="form-control" id="image" name="image" required>
                        </div>

                        <div class="mb-3">
                            <label for="specification" class="form-label">Thông số kỹ thuật</label>
                            <input type="text" class="form-control" id="specification" name="specification" required>
                        </div>

                        <div class="mb-3">
                            <label for="manufactureDate" class="form-label">Ngày sản xuất</label>
                            <input type="date" class="form-control" id="manufactureDate" name="manufactureDate">
                        </div>

                        <!-- Thong tin ve gia -->
                        <div class="mb-3">
                            <label for="price" class="form-label">Giá của sản phẩm: </label>
                            <input type="number" class="form-control" id="price" name="price">
                        </div>

                        <div class="mb-3">
                            <label for="discountPercent" class="form-label">Phần trăm giảm giá: </label>
                            <input type="number" class="form-control" id="discountPercent" name="discountPercent">
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

    <!-- Phân trang -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-3">
            <!-- Nút Previous -->
            <c:if test="${requestScope.currentPage > 1}">
                <li class="page-item">
                    <a class="page-link mx-2" href="admin-manager-products?page=${requestScope.currentPage-1}&option=${requestScope.option}"><<</a>
                </li>
            </c:if>

            <!-- Hiển thị trang -->
            <c:forEach var="i" begin="1" end="${requestScope.pageNumber}">
                <li class="page-item ${i == requestScope.currentPage ? 'active' : ''}">
                    <a class="page-link" href="admin-manager-products?page=${i}&option=${requestScope.option}">${i}</a>
                </li>
            </c:forEach>

            <!-- Nút Next -->
            <c:if test="${requestScope.currentPage < requestScope.pageNumber}">
                <li class="page-item">
                    <a class="page-link mx-2" href="admin-manager-products?page=${requestScope.currentPage+1}&option=${requestScope.option}">>></a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>