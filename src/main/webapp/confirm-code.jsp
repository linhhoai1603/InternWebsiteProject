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
  <title>Xác nhận mã code</title>
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
  <form class="form-control" action="forget-password?method=confirmCode" method="post">
    <label for="code"><strong>Nhập mã: </strong>(Mã gồm 6 ký tự được gửi qua Email của bạn.)</label>
    <input id="code" name="code" placeholder="Vui lòng nhập mã code" type="number" class="form-control">
    <input class="btn btn-primary mt-3" type="submit" value="Xác nhận">
  </form>
</div>
<%@include file="includes/link/headLink.jsp"%>
</body>
</html>
