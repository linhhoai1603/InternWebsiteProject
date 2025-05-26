<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi Tiết Sản Phẩm</title>
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>
<div class="container-fluid mt-4">
    <h2 class="center-text mb-4 text-center">Chi Tiết Sản Phẩm</h2>

    <form action="admin-manager-detail-product" method="post">
        <input type="hidden" name="idProduct" value="${requestScope.product.id}">
        <input type="hidden" name="idTechnical" value="${requestScope.product.technicalInfo.id}">
        <input type="hidden" name="idPrice" value="${requestScope.product.price.id}">
        <input type="hidden" name="method" value="updateProduct">

        <!-- Các thông tin sản phẩm hiện tại -->
        <h4>Thông tin sản phẩm</h4>
        <div class="form-group">
            <label for="name"><strong>Tên sản phẩm</strong></label>
            <input type="text" class="form-control" id="name" name="name" value="${requestScope.product.name}" required>
        </div>

        <div class="form-group">
            <label for="quantity"><strong>Số lượng</strong></label>
            <input type="number" class="form-control" id="quantity" name="quantity" value="${requestScope.product.quantity}" required>
        </div>

        <div class="form-group">
            <label for="category"><strong>Danh mục</strong></label>
            <input type="text" class="form-control" id="category" name="category" value="${requestScope.product.category.name}" readonly>
        </div>

        <div class="form-group">
            <label for="description"><strong>Mô tả</strong></label>
            <textarea class="form-control" id="description" name="description" required>${requestScope.product.description}</textarea>
        </div>

        <!-- Thông tin giá -->
        <h4>Thông Tin Giá</h4>
        <div class="form-group">
            <label for="price"><strong>Giá Tiền</strong></label>
            <input type="number" class="form-control price" id="price" name="price" value="${requestScope.product.price.price}" required>
        </div>

        <div class="form-group">
            <label for="discountPercent"><strong>Phần Trăm Giảm Giá</strong></label>
            <input type="number" class="form-control" id="discountPercent" name="discountPercent" value="${requestScope.product.price.discountPercent}" required>
        </div>

        <div class="form-group">
            <label for="lastPrice"><strong>Giá Sau Giảm</strong></label>
            <input type="number" class="form-control price" id="lastPrice" name="lastPrice" value="${requestScope.product.price.lastPrice}" readonly>
        </div>

        <!--Thông tin kỹ thuật-->
        <h4>Kỹ thuật</h4>
        <div class="form-group">
            <label for="manufacture_date"><strong>Ngày sản xuất</strong></label>
            <input type="date" class="form-control" id="manufacture_date" name="manufacture_date" value="${requestScope.product.technicalInfo.manufactureDate}" required>
        </div>

        <div class="form-group">
            <label for="technical_specifications"><strong>Thông số kỹ thuật</strong></label>
            <textarea class="form-control" id="technical_specifications" name="technical_specifications" required>${requestScope.product.technicalInfo.specification}</textarea>
        </div>

        <div class="row">
            <button type="submit" class="btn btn-primary my-3">Lưu Thay Đổi</button>
            <a class="btn btn-warning" href="management-products.jsp">Quay lại</a>
        </div>
    </form>


    <!-- Bảng kiểu vải sẽ không thay đổi -->

        <div class="container mt-5">
            <h2 class="text-center mb-4" style="color: #2c8b73">Thông Tin Các Kiểu Vải</h2>

            <!-- Thêm kiểu vải Button -->
            <button class="btn btn-primary float-end my-3" data-bs-toggle="modal" data-bs-target="#addFabricModal">Thêm Kiểu Vải</button>

            <!-- Modal thêm kiểu vải -->
            <div class="modal fade" id="addFabricModal" tabindex="-1" aria-labelledby="addFabricModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addFabricModalLabel">Thêm Kiểu Vải</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Form thêm kiểu vải -->
                            <form action="admin-manager-detail-product" method="post">
                                <input type="hidden" name="method" value="addStyle">
                                <input type="hidden" name="idProduct" value="${requestScope.product.id}">

                                <!-- Nhập tên kiểu vải -->
                                <div class="mb-3">
                                    <label for="fabricName" class="form-label">Tên Kiểu Vải</label>
                                    <input
                                            type="text"
                                            class="form-control"
                                            id="fabricName"
                                            name="fabricName"
                                            placeholder="Nhập tên kiểu vải"
                                            maxlength="100"
                                            required>
                                </div>

                                <!-- Nhập URL hình ảnh -->
                                <div class="mb-3">
                                    <label for="fabricImage" class="form-label">Hình Ảnh (URL)</label>
                                    <input
                                            type="url"
                                            class="form-control"
                                            id="fabricImage"
                                            name="fabricImage"
                                            placeholder="https://example.com/image.jpg"
                                            required>
                                    <!-- Gợi ý cách nhập đúng URL -->
                                    <small class="form-text text-muted">
                                        Nhập đường dẫn URL đầy đủ, ví dụ: https://example.com/image.jpg
                                    </small>
                                </div>

                                <!-- Nhập số lượng -->
                                <div class="mb-3">
                                    <label for="fabricQuantity" class="form-label">Số Lượng</label>
                                    <input
                                            type="number"
                                            class="form-control"
                                            id="fabricQuantity"
                                            name="fabricQuantity"
                                            placeholder="Nhập số lượng"
                                            min="1"
                                            required>
                                </div>

                                <!-- Nút hành động -->
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Thêm Kiểu Vải</button>
                                    <button type="reset" class="btn btn-secondary">Làm Lại</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>

            <!-- Bảng các kiểu vải -->
            <table class="table custom-table my-3">
                <thead>
                <tr>
                    <th>Tên Kiểu Vải</th>
                    <th>Hình Ảnh</th>
                    <th>Số lượng</th>
                    <th>Hành động</th>
                    <th>Xóa </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="style" items="${requestScope.product.styles}">
                    <tr>
                        <form action="admin-manager-detail-product" method="post">
                            <td>
                                <input type="text" name="nameStyle" value="${style.name}" class="form-control">
                            </td>
                            <td>
                                <img src="${style.image}" width="50">
                            </td>
                            <td>
                                <input type="number" name="quantity" value="${style.quantity}" class="form-control">
                            </td>
                            <td>
                                <input type="hidden" name="id" value="${requestScope.product.id}">
                                <input type="hidden" name="method" value="updateStyle">
                                <input type="hidden" name="styleId" value="${style.id}">
                                <button type="submit" class="btn btn-warning">Lưu thay đổi</button>
                            </td>
                        </form>
                        <td>
                            <!-- Form Xóa kiểu vải -->
                            <form action="admin-manager-detail-product" method="post" style="display: inline;">
                                <input type="hidden" name="id" value="${requestScope.product.id}">
                                <input type="hidden" name="method" value="deleteStyle">
                                <input type="hidden" name="styleId" value="${style.id}">
                                <button type="submit" class="btn btn-danger">Xóa</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>



</div>

<!-- Thêm JavaScript để định dạng tiền VNĐ -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Hàm định dạng số tiền thành tiền Việt
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
        }

        // Định dạng giá gốc
        document.querySelectorAll(".price").forEach(el => {
            const originalPrice = el.value.trim().replace("VND", "").replace(/,/g, "");
            if (originalPrice) {
                el.textContent = formatCurrency(parseFloat(originalPrice));
            }
        });
    });
</script>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
