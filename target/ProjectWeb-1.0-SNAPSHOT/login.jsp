<%@ page import="static com.oracle.wls.shaded.org.apache.xalan.xsltc.compiler.sym.error" %><%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 2:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp" %>
<%@include file="includes/navbar.jsp" %>
<html>
<head>
    <title> Đăng nhập </title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<link rel="stylesheet" href="css/login.css">
<div class="container ">
    <!-- Lấy giá trị error và username từ request scope -->
    <c:set var="error" value="${not empty requestScope.error ? requestScope.error : ''}"/>
    <c:set var="username" value="${not empty requestScope.username ? requestScope.username : ''}"/>

    <!-- Hiển thị thông báo nếu có lỗi -->
    <c:if test="${not empty error}">
        <script type="text/javascript">
            Swal.fire({
                title: 'Thông báo',
                text: "${error}"
            });
        </script>
    </c:if>

    <div class="form-section">
        <h2><fmt:message key="title"/></h2>
        <p class="text-center"><fmt:message key="ndlog"/></p>
        <div style="color: red;">
            ${error}
        </div>
        <div class="social-row">
            <a href="googleLogin" class="social-button btn-google-login" title="Continue with Google">
                <i class="fab fa-google"></i> <!-- Icon Google -->
                <span>Continue with Google</span>
            </a>
            <a href="facebookLogin" class="social-button btn-facebook-login" title="Continue with Facebook">
                <i class="fab fa-facebook-f"></i> <!-- Icon Facebook -->
                <span>Continue with Facebook</span>
            </a>
        </div>

        <div class="lines">
            <div class="line"></div>
            OR
            <div class="line"></div>
        </div>
        <form id="loginForm" method="post" action="login">
            <div class="mb-3">
                <input class="form-control" id="username" placeholder="Tài khoản *" required type="text" name="username"
                       aria-label="Username" value="${username}"/>
            </div>
            <div class="mb-3">
                <input class="form-control" id="password" placeholder="Mật khẩu *" required type="password"
                       name="password" aria-label="Mật khẩu"/>
            </div>
            <div class="text-center">
                <button class="btn btn-primary" type="submit"><fmt:message key="login"/></button>
            </div>
        </form>
        <a href="register.jsp" class="register-link"><fmt:message key="bcctk"/></a>
        <a href="forgotPass.jsp" class="register-link"><fmt:message key="qmk"/></a> <!-- Quên mk -->
    </div>

    <c:if test="${not empty requestScope.success}">
        <!-- The Modal -->
        <div class="modal fade" id="registrationSuccessModal" tabindex="-1"
             aria-labelledby="registrationSuccessModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header bg-success text-white">
                        <h4 class="modal-title" id="registrationSuccessModalLabel">Đăng ký thành công!</h4>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <p>${requestScope.success}</p>
                        <hr>
                        <p class="mb-0">Vui lòng kiểm tra hộp thư đến (và cả thư mục Spam/Junk) để tìm email kích
                            hoạt.</p>
                        <p>Sau khi kích hoạt, bạn có thể đăng nhập.</p>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đã hiểu</button>
                    </div>

                </div>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var myModalElement = document.getElementById('registrationSuccessModal');
                if (myModalElement) {
                    var myModal = new bootstrap.Modal(myModalElement, {
                        keyboard: true,
                    });
                    myModal.show();
                }
            });
        </script>
    </c:if>
</div>
<%@include file="includes/footer.jsp" %>
<%@include file="includes/link/footLink.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>








