<%--
 Created by IntelliJ IDEA.
 User: Le Dinh Hung
 Date: 12/15/2024
 Time: 9:48 PM
 To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Thông tin người dùng</title>
    <style>
        .success {
            color: green;
        }

        .error {
            color: red;
        }
         .current-address-display label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }
         .current-address-display p {
            margin-bottom: 5px;
        }
        .form-group label {
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>
<%@include file="includes/header.jsp" %>
<%@include file="includes/navbar.jsp" %>
<link rel="stylesheet" href="css/user.css">
<div class="container mt-5">
    <!-- Header -->
    <h3 class="text-center  mb-4 title"><fmt:message key="user_information"/></h3>
    <c:if test="${not empty message}">
    <h4 class="${messageType}">${message}</h4>
    </c:if>
    <!-- Form để chỉnh sửa thông tin người dùng -->

    <div class="row">
        <!-- Cột ảnh đại diện -->

        <div class="col-md-3 text-center">
            <div class="col-md-6 avatar-container">
                <form action="avatar" method="post" enctype="multipart/form-data" id="avatarForm">
                    <!-- Hiển thị ảnh người dùng -->
                    <img src="${sessionScope.user.image}" alt="User Avatar" id="userAvatar"
                         class="img-fluid rounded-circle">

                    <!-- Nút chọn ảnh -->
                    <label for="avatarInput" class="file-label w-100 mt-3">Sửa ảnh</label>
                    <input type="file" id="avatarInput" name="avatar" accept="image/*" class="file-input"
                           onchange="previewImageAndSubmit(event)">
                </form>
            </div>
        </div>


        <!-- Cột thông tin người dùng -->
        <div class="col-md-9">
            <form action="personal-inf" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email"
                           value="${sessionScope.user.email}"
                           readonly>
                </div>

                <div class="form-group">
                    <label for="firstname">First Name</label>
                    <input type="text" class="form-control" id="firstname" name="firstname" placeholder="Nhập họ"
                           value="${sessionScope.user.firstname}" required></div>

                <div class="form-group">
                    <label for="lastname">Last Name</label>
                    <input type="text" class="form-control" id="lastname" name="lastname" placeholder="Nhập tên"
                           value="${sessionScope.user.lastname}" required>
                </div>

                <div class="form-group">
                    <label for="phoneNumber"><fmt:message key="phone"/></label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber"
                           placeholder="Nhập số điện thoại" value="${sessionScope.user.phoneNumber}"
                           required>
                </div>

                <!-- Address Section -->
                <h5 class="mt-4">Địa chỉ</h5>

                <!-- Current Address Display -->
                <div class="current-address-display mb-4 p-3 border rounded">
                    <h6>Địa chỉ hiện tại:</h6>
                    <p class="mb-0">**Tỉnh/Thành phố:** ${sessionScope.user.address.province}</p>
                    <p class="mb-1">**Quận/Huyện:** ${sessionScope.user.address.district}</p>
                    <p class="mb-1">**Phường/Xã:** ${sessionScope.user.address.ward}</p>
                    <p class="mb-1">**Địa chỉ chi tiết:** ${sessionScope.user.address.detail}</p>
                </div>

                <!-- New Address Selection -->
                <h6>Cập nhật địa chỉ mới (chọn từ danh sách):</h6>
                <div class="form-group">
                    <label for="province">Tỉnh / Thành phố</label>
                    <select class="form-control" id="province" name="province">
                        <option value="">Chọn tỉnh/thành phố</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="district">Quận / Huyện</label>
                    <select class="form-control" id="district" name="district" disabled>
                        <option value="">Chọn quận/huyện</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="ward">Phường / Xã</label>
                    <select class="form-control" id="ward" name="ward" disabled>
                        <option value="">Chọn phường/xã</option>
                    </select>
                </div>

                 <div class="form-group">
                    <label for="detail">Địa chỉ chi tiết (Số nhà, tên đường...)</label>
                    <input type="text" class="form-control" id="detail" name="detail" placeholder="Nhập số nhà, tên đường...">
                </div>

                <!-- Nút lưu thông tin -->
                <button type="submit" class="btn mt-3" style="background: #339C87 ;color: white ">Lưu thông tin</button>
            </form>
        </div>
    </div>

    <script src="js/user.js"></script>
    <%@ include file="includes/footer.jsp" %>
    <%@ include file="includes/link/footLink.jsp" %>

</body>
</html>
