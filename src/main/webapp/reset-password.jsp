<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp"%>
<html>
<head>
  <%@include file="includes/link/headLink.jsp"%>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <title>Cập nhật mật khẩu</title>
  <script type="text/javascript">
    // Hàm kiểm tra mật khẩu
    function checkPasswords() {
      var password1 = document.getElementById("password1").value;
      var password2 = document.getElementById("password2").value;

      // Kiểm tra nếu mật khẩu không khớp
      if (password1 !== password2) {
        document.getElementById("password2").style.backgroundColor = "red"; // Đổi màu nền
        return false; // Không gửi form
      } else {
        document.getElementById("password2").style.backgroundColor = ""; // Trả lại màu nền bình thường
        return true; // Gửi form
      }
    }
  </script>
</head>
<body>
<div class="container my-5">
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

  <form class="form-control" action="forget-password?method=resetPassword" method="post" onsubmit="return checkPasswords()">
    <label for="password1"><strong>Nhập mật khẩu mới: </strong></label>
    <input id="password1" name="password1" placeholder="Vui lòng nhập mật khẩu" type="password" class="form-control">

    <label for="password2"><strong>Nhập lại mật khẩu mới: </strong></label>
    <input id="password2" name="password2" placeholder="Vui lòng nhập lại mật khẩu" type="password" class="form-control">

    <input class="btn btn-primary mt-3" type="submit" value="Lưu">
  </form>
</div>
<%@include file="includes/link/headLink.jsp"%>
</body>
</html>
