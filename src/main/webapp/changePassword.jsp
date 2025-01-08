<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Đổi Mật Khẩu</title>
    <%@include file="includes/link/headLink.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<!-- Quay lại trang chủ -->
<a href="index.jsp"><-- Trang chủ</a>

<div class="container py-5">
    <c:set var="error" value="${not empty requestScope.error ? requestScope.error : ''}" />
    <c:set var="success" value="${not empty requestScope.success ? requestScope.success : ''}" />


    <!-- Hiển thị thông báo lỗi -->
    <c:if test="${not empty error}">
        <script type="text/javascript">
            Swal.fire({
                icon: 'error',
                title: 'Thông báo',
                text: "${error}"
            });
        </script>
    </c:if>
    <c:if test="${not empty success}">
        <script type="text/javascript">
            Swal.fire({
                icon: 'success',
                title: 'Thông báo',
                text: "${success}"
            });
        </script>
    </c:if>

    <h2 class="text-center mb-4">Đổi Mật Khẩu</h2>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <form method="post" action="change-password">
                <!-- Mật khẩu hiện tại -->
                <div class="mb-3">
                    <label for="currentPassword" class="form-label">Mật khẩu hiện tại</label>
                    <input type="password" name="current_pass" class="form-control" id="currentPassword" placeholder="Nhập mật khẩu hiện tại" required>
                </div>
                <!-- Mật khẩu mới -->
                <div class="mb-3">
                    <label for="newPassword" class="form-label">Mật khẩu mới</label>
                    <input type="password" name="new_pass1" class="form-control" id="newPassword" placeholder="Nhập mật khẩu mới" required>
                </div>
                <!-- Xác nhận mật khẩu mới -->
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                    <input type="password" name="new_pass2" class="form-control" id="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                </div>
                <!-- Nút gửi -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Đổi Mật Khẩu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="includes/link/footLink.jsp"%>
</body>
</html>