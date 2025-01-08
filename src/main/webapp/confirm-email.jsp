<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 1/8/2025
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp"%>
<html>
<head>
    <%@include file="includes/link/headLink.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Xác nhận Email</title>
</head>
<body>
<div class="container my-5">
    <!-- Lấy giá trị error và username từ request scope -->
    <c:set var="error" value="${not empty requestScope.error ? requestScope.error : ''}" />

    <!-- Hiển thị thông báo nếu có lỗi -->
    <c:if test="${not empty error}">
        <script type="text/javascript">
            Swal.fire({
                icon: 'error',
                title: 'Thông báo',
                text: "${error}"
            });
        </script>
    </c:if>
    <form class="form-control" action="forget-password?method=confirmEmail" method="post">
        <label for="username"><strong>Nhập Username của bạn: </strong></label>
        <input id="username" name="username" placeholder="Vui lòng nhập username của bạn" type="text" class="form-control">
        <label for="email"><strong>Nhập Email của bạn: </strong></label>
        <input id="email" name="email" placeholder="Vui lòng nhập email của bạn" type="email" class="form-control">
        <input class="btn btn-primary mt-3" type="submit" value="Xác nhận">
    </form>
</div>
<%@include file="includes/link/headLink.jsp"%>
</body>
</html>
