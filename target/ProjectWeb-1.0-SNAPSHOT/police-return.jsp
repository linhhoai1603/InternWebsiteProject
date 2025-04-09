<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 2:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Các mẫu thiết kế</title>
</head>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="translate.messages" scope="session"/>
<%@include file="includes/header.jsp" %>
<%@include file="includes/navbar.jsp" %>
<link rel="stylesheet" href="css/police-return.css">
<!--jQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!--content-->
<div class="container-fluid mt-3 mb-5">
    <div class="row">
        <div class="col-md-12">
            <h1 class="text-center"><fmt:message key="csdt"/></h1>
            <div class="row">
                <div class="col-md-1"></div>
                <p
                        class="ps-5 pe-5 text-center col-md-10"
                        style="font-style: italic"
                >
                    <fmt:message key="coqkd"/>
                </p>
                <div class="col-md-1"></div>
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                        <ul style="list-style-type: none">
                            <li>
                                <h4><fmt:message key="dk1"/></h4>
                                <ul>
                                    <li>
                                        <b><fmt:message key="dk2"/></b> <fmt:message key="nddk2"/>
                                    </li>
                                    <li>
                                        <b><fmt:message key="dk3"/></b> <fmt:message key="nddk3"/>
                                    </li>
                                    <li>
                                        <b><fmt:message key="dk4"/></b><fmt:message key="nddk4"/>
                                    </li>
                                    <li>
                                        <b><fmt:message key="dk5"/></b> <fmt:message key="nddk5"/>
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4><fmt:message key="return_reason_title"/></h4>
                                <ul>
                                    <li>
                                        <b><fmt:message key="return_reason_list_item_1"/></b> <fmt:message
                                            key="return_reason_list_item_1_1"/>
                                    </li>
                                    <li>
                                        <b><fmt:message key="return_reason_list_item_2"/></b> <fmt:message
                                            key="return_reason_list_item_2_2"/>
                                    </li>
                                    <li>
                                        <b><fmt:message key="return_reason_list_item_3"/></b><fmt:message
                                            key="return_reason_list_item_3_1"/>
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4><fmt:message key="return_process_title"/></h4>
                                <ul>
                                    <li>
                                        <b><fmt:message key="return_process_step_1"/></b> <fmt:message
                                            key="return_process_step_1_1"/>
                                    </li>
                                    <li>
                                        <b><fmt:message key="return_process_step_2"/></b><fmt:message
                                            key="return_process_step_2_1"/>
                                        trả.
                                    </li>
                                    <li>
                                        <b><fmt:message key="return_process_step_3"/></b><fmt:message
                                            key="return_process_step_3_1"/>
                                    </li>
                                    <li>
                                        <b><fmt:message key="return_process_step_4"/></b> <fmt:message
                                            key="return_process_step_4_1"/>
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4><fmt:message key="return_fee_title"/></h4>
                                <ul>
                                    <li>
                                        <b><fmt:message key="return_fee_exchange_label"/></b> <fmt:message
                                            key="return_fee_exchange_desc"/>
                                    </li>
                                    <li>
                                        <b><fmt:message key="return_fee_refund_label"/></b> <fmt:message
                                            key="return_fee_refund_desc"/>
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4><fmt:message key="return_no_apply_title"/></h4>
                                <ul>
                                    <li><fmt:message key="return_no_apply_item_1"/></li>
                                    <li>
                                        <fmt:message key="return_no_apply_item_2"/>
                                    </li>
                                    <li>
                                        <fmt:message key="return_no_apply_item_3"/>
                                    </li>
                                    <li>
                                        <fmt:message key="return_no_apply_item_4"/>
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4><fmt:message key="return_important_title"/></h4>
                                <ul>
                                    <li>
                                        <fmt:message key="return_important_item_1"/>
                                    </li>
                                    <li>
                                        <fmt:message key="return_important_item_2"/>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-1"></div>
                </div>
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-6 ms-5">
                        <input type="checkbox" name="readedPolicyReturn" id="readed"/>
                        <label for="readed" class="fw-bold"
                        ><fmt:message key="return_policy_agreement"/></label
                        >
                    </div>
                </div>
                <div
                        class="row"
                        id="folowReturn"
                        style="border: 1px solid black; border-top: #4fd0b6 5px solid"
                >
                    <h4 class="fw-bold text-center"><fmt:message key="return_procedure_title"/></h4>
                    <div class="ms-5">
                        <h6>
                            <b><fmt:message key="return_procedure_step1_label"/></b> <fmt:message
                                key="return_procedure_step1_desc"/>
                        </h6>
                        <h6>
                            <b><fmt:message key="return_procedure_step2_label"/></b> <fmt:message
                                key="return_procedure_step2_desc"/>
                        </h6>
                        <h6>
                            <b><fmt:message key="return_procedure_step3_label"/></b> <fmt:message
                                key="return_procedure_step3_desc"/>
                        </h6>
                        <h6><b><fmt:message key="return_procedure_step4_label"/></b> <fmt:message
                                key="return_procedure_step4_desc"/></h6>
                        <a href="https://zalo.me/0377314202"
                           style="
                    float: right;
                    margin-right: 30%;
                    font-style: italic;
                    font-size: 20px;
                  "
                           class="text-primary"><fmt:message key="return_procedure_contact_us"/></a>
                    </div>
                    <img
                            src="images/quyTrinhDoiTra.webp"
                            alt="Quy trình đổi trả hàng"
                            class="w-100"
                    />
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end content-->

<%@include file="includes/footer.jsp" %>
<%@include file="includes/link/footLink.jsp" %>
<script src="js/police-return.js"></script>
</body>
</html>