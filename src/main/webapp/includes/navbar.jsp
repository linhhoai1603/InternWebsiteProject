<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 11:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="link/headLink.jsp" %>
<link rel="stylesheet" href="includes/css/navbar.css">

<nav class="navbar navbar-expand-lg" style="background-color: #4fd0b6; height: 50px">
    <div class="container-fluid ">
        <a class="nav-link text-white" href="index.jsp" style="text-decoration: none; font-size: 18px; padding: 15px 20px;"">Trang chủ</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link text-white" href="products.jsp">Sản phẩm</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/may-mac">Vải
                    may mặc</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="product-fabric">Vải nội thất</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" id="accessoryDropdown"
                       data-bs-toggle="dropdown">Phụ kiện may mặc</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="button-up.jsp">NÚT ÁO</a></li>
                        <li><a class="dropdown-item" href="zipstar-product.jsp">DÂY KÉO</a></li>
                    </ul>
                </li>
                <li class="nav-item"><a class="nav-link text-white" href="design-product.jsp">Các mẫu thiết kế</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="contact.jsp">Liên hệ</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="police-return.jsp">Chính sách đổi trả</a></li>
            </ul>
        </div>
    </div>
</nav>
<script>
    let lastScrollTop = 0;
    const navbar = document.querySelector(".navbar");
    const header = document.querySelector("header"); // Giả sử header là phần trên navbar

    window.addEventListener("scroll", function () {
        let scrollTop = window.scrollY || document.documentElement.scrollTop;

        if (scrollTop === 0) {
            // Nếu quay lại đầu trang -> Đặt navbar về dưới header
            navbar.style.position = "relative";
            navbar.style.top = "0";
        } else if (scrollTop > lastScrollTop) {
            // Nếu cuộn xuống -> Giữ navbar cố định trên màn hình
            navbar.style.position = "fixed";
            navbar.style.top = "0";
            navbar.style.width = "100%";
            navbar.style.transition = "top 0.3s";
        } else {
            // Nếu cuộn lên -> Ẩn navbar
            navbar.style.top = "-60px";
        }

        lastScrollTop = scrollTop;
    });

</script>
<%@include file="link/footLink.jsp" %>
