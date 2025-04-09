<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 11:12 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="link/headLink.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>

<footer class="text-white pt-5 pb-4 mt-5" style="background-color: #4FD0B6;">
    <div class="container text-md-left">
        <div class="row text-md-left">
            <!-- Liên hệ -->
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold"><fmt:message key="lienhe"/></h5>
                <p><fmt:message key="dia_chi"/></p>
                <p>Hotline: 0243 0000 111 - 039 5555 119</p>
                <p>Email: myphamchinhhang@gmail.com</p>
                <p>Website: thoitrang9.vnwordpress.net</p>
            </div>

            <!-- Chính sách chung -->
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold"><fmt:message key="chinhsach1"/></h5>
                <p><fmt:message key="chinhsach2"/></p>
                <p><fmt:message key="chinhsach3"/></p>
                <p><fmt:message key="chinhsach4"/></p>
                <p><fmt:message key="chinhsach5"/></p>
                <p><fmt:message key="chinhsach6"/></p>
                <p><fmt:message key="chinhsach7"/></p>
            </div>

            <!-- Hướng dẫn dịch vụ -->
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold"><fmt:message key="huongdan"/></h5>
                <p><fmt:message key="huongdan1"/></p>
                <p><fmt:message key="huongdan2"/></p>
                <p><fmt:message key="huongdan3"/></p>
                <p><fmt:message key="huongdan4"/></p>
                <p><fmt:message key="huongdan5"/></p>
                <p><fmt:message key="huongdan6"/></p>
            </div>

            <!-- Giờ làm việc -->
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold"><fmt:message key="giolam"/></h5>
                <p><fmt:message key="sdt"/></p>
                <p><fmt:message key="kythuat"/></p>
                <p><fmt:message key="khieunai"/></p>
                <p><fmt:message key="baohanh"/></p>
            </div>
        </div>

        <hr class="mb-4">

        <!-- Social Media Icons -->
        <div class="row align-items-center">
            <div class="col-md-7 col-lg-8">
                <p>&copy; <fmt:message key="banquyen"/></p>
            </div>

            <div class="col-md-5 col-lg-4">
                <div class="text-center text-md-right">
                    <ul class="list-unstyled list-inline">
                        <li class="list-inline-item">
                            <a href="#" class="btn-floating btn-sm text-white"><i class="fab fa-facebook"></i></a>
                        </li>
                        <li class="list-inline-item">
                            <a href="#" class="btn-floating btn-sm text-white"><i class="fab fa-instagram"></i></a>
                        </li>
                        <li class="list-inline-item">
                            <a href="#" class="btn-floating btn-sm text-white"><i class="fab fa-tiktok"></i></a>
                        </li>
                        <li class="list-inline-item">
                            <a href="#" class="btn-floating btn-sm text-white"><i class="fab fa-zalo"></i></a>
                        </li>
                        <li class="list-inline-item">
                            <a href="#" class="btn-floating btn-sm text-white"><i class="fab fa-youtube"></i></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<%@include file="link/footLink.jsp" %>