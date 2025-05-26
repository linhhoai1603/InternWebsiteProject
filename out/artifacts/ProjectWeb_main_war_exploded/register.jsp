<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<%@include file="includes/navbar.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <link rel="stylesheet" href="css/register.css">
    <title>Đăng ký</title>
    <style>
        body, html {
            height: 100%;
        }

        .container {
            min-height: 100%; /* Use min-height instead of height for flexibility */
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 70px; /* Add padding if navbar is fixed */
            padding-bottom: 20px; /* Add padding at the bottom */
        }

        .form-section {
            width: 100%;
            max-width: 500px;
            padding: 20px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            background-color: #f8f9fa;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .alert {
            display: none; /* Keep server messages hidden initially */
        }

        .alert.show {
            display: block;
        }

        /* Style for JavaScript validation messages */
        .invalid-feedback {
            display: none; /* Hide by default */
            width: 100%;
            margin-top: 0.25rem;
            font-size: .875em; /* Smaller font size */
            color: #dc3545; /* Red color for errors */
        }

        /* Style to show the error message */
        .invalid-feedback.d-block {
            display: block; /* Use d-block to show */
        }

        /* Optional: Add style to highlight invalid input fields */
        .form-control.is-invalid {
            border-color: #dc3545;
        }

    </style>
</head>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>
<div class="container">
    <div class="row w-100 justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="form-section">
                <h2 class="text-center mb-4"><fmt:message key="reg_tittle"/></h2>
                <!--1) Server-side error -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger show" role="alert">
                        <c:out value="${error}"/>
                    </div>
                </c:if>

                <!-- 2) Server-side success -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success show" role="alert">
                        <c:out value="${success}"/>
                    </div>
                </c:if>

                <!-- 3) Registration Form -->
                <%-- Add novalidate to disable default browser validation --%>
                <form id="registrationForm" action="register" method="post" novalidate>
                    <!-- Email -->
                    <div class="form-group mb-3">
                        <label for="email" class="form-label">Email *</label>
                        <input
                                class="form-control"
                                id="email"
                                name="email"
                                required
                                type="email"
                        />
                        <%-- Placeholder for email error --%>
                        <div id="emailError" class="invalid-feedback"></div>
                    </div>

                    <!-- First Name -->
                    <div class="form-group mb-3">
                        <label for="firstName" class="form-label">First Name *</label>
                        <input
                                class="form-control"
                                id="firstName"
                                name="firstName"
                                type="text"
                        />
                        <%-- Placeholder for first name error --%>
                        <div id="firstNameError" class="invalid-feedback"></div>
                    </div>

                    <!-- Last Name -->
                    <div class="form-group mb-3">
                        <label for="lastname" class="form-label">Last Name *</label>
                        <input
                                class="form-control"
                                id="lastname"
                                name="lastname"
                                type="text"
                        />
                        <%-- Placeholder for last name error --%>
                        <div id="lastnameError" class="invalid-feedback"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="username" class="form-label">Username *</label>
                        <input
                                class="form-control"
                                id="username"
                                name="username"
                                required
                                type="text"
                        />
                        <%-- Placeholder for last name error --%>
                        <div id="usernameError" class="invalid-feedback"></div>
                    </div>

                    <!-- Phone Number -->
                    <div class="form-group mb-3">
                        <label for="phoneNumber" class="form-label">Phone Number *</label>
                        <input
                                class="form-control"
                                id="phoneNumber"
                                name="phoneNumber"
                                required
                                type="tel" <%-- Use type="tel" for phone numbers --%>
                        />
                        <%-- Placeholder for phone number error --%>
                        <div id="phoneNumberError" class="invalid-feedback"></div>
                    </div>

                    <!-- Password -->
                    <div class="form-group mb-3">
                        <label for="password" class="form-label"><fmt:message key="pss"/> *</label>
                        <input
                                class="form-control"
                                id="password"
                                name="password"
                                required
                                type="password"
                        />
                        <%-- Placeholder for password error --%>
                        <div id="passwordError" class="invalid-feedback"></div>
                    </div>


                    <!-- Submit Button -->
                    <div class="text-center mt-4">
                        <button class="btn btn-primary w-100" type="submit"><fmt:message key="regg"/></button>
                    </div>
                </form>

                <!-- Back Button -->
                <div class="text-center mt-3">
                    <a class="btn btn-secondary w-100" href="index.jsp"><fmt:message key="cbck"/></a>
                </div>

            </div>
        </div>
    </div>
</div>
<script src="js/reg-alert.js"/>

<!-- Link JS hoặc script cuối trang (nếu có) -->
<%@include file="includes/footer.jsp" %>
</body>
</html>
