<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp" %>
<%@include file="includes/navbar.jsp" %>
<html>
<head>
    <title>Đăng nhập</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<link rel="stylesheet" href="css/login.css">
<div class="container">
    <c:set var="error" value="${not empty requestScope.error ? requestScope.error : ''}"/>
    <c:set var="username" value="${not empty requestScope.username ? requestScope.username : ''}"/>

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
        <div style="color: red;">${error}</div>

        <form id="loginForm" method="post" action="login-user">
            <div class="social-row">
                <a href="googleLogin" class="social-button btn-google-login" title="Continue with Google">
                    <i class="fab fa-google"></i>
                    <span>Continue with Google</span>
                </a>
                <a href="facebookLogin" class="social-button btn-facebook-login" title="Continue with Facebook">
                    <i class="fab fa-facebook-f"></i>
                    <span>Continue with Facebook</span>
                </a>
            </div>
            <div class="lines">
                <div class="line"></div>
                OR
                <div class="line"></div>
            </div>

            <div class="mb-3">
                <input class="form-control" id="username" placeholder="Tài khoản *" required type="text"
                       name="username" value="${username}"/>
            </div>
            <div class="mb-3">
                <input class="form-control" id="password" placeholder="Mật khẩu *" required type="password"
                       name="password"/>
            </div>

            <div class="mb-3">
                <!-- reCAPTCHA div -->
                <div id="recaptcha-placeholder"></div>
            </div>

            <div class="text-center">
                <button class="btn btn-primary" type="submit"><fmt:message key="login"/></button>
            </div>
        </form>

        <a href="register.jsp" class="register-link"><fmt:message key="bcctk"/></a>
        <a href="forgotPass.jsp" class="register-link"><fmt:message key="qmk"/></a>

        <c:if test="${not empty requestScope.success}">
            <!-- Modal đăng ký thành công -->
            <div class="modal fade" id="registrationSuccessModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-success text-white">
                            <h4 class="modal-title">Đăng ký thành công!</h4>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p>${requestScope.success}</p>
                            <hr>
                            <p>Vui lòng kiểm tra email để kích hoạt tài khoản.</p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" data-bs-dismiss="modal">Đã hiểu</button>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var myModal = new bootstrap.Modal(document.getElementById('registrationSuccessModal'));
                    myModal.show();
                });
            </script>
        </c:if>
    </div>
</div>

<%@include file="includes/footer.jsp" %>
<%@include file="includes/link/footLink.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<%-- Thêm script để render reCAPTCHA --%>
<script>
    var onloadCallback = function() {
        console.log("onloadCallback is executing!");
        // Render the recaptcha button
        grecaptcha.render('recaptcha-placeholder', {
            'sitekey' : '${siteKey}'
        });
    };
</script>

</body>
</html>
