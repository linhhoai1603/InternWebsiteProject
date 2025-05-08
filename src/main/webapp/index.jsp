<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 11:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/link/headLink.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
          integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <style>
        body {
            background-color: #ffffffc7;
        }
    </style>
</head>
<body>
<fmt:setLocale value="${sessionScope.locale}" scope="session"/>
<fmt:setBundle basename="messages" scope="session"/>

<c:if test="${sessionScope.productHotSelling == null}">
    <jsp:include page="/home"/>
</c:if>
<jsp:include page="includes/header.jsp"/>
<jsp:include page="includes/navbar.jsp"/>
<jsp:include page="includes/slides.jsp"/>
<jsp:include page="includes/content.jsp"/>
<jsp:include page="includes/voucher.jsp"/>
<jsp:include page="includes/footer.jsp"/>

<jsp:include page="includes/link/footLink.jsp"/>
</body>
</html>
