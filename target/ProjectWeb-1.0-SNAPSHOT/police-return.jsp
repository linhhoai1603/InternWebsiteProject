<%--
  Created by IntelliJ IDEA.
  User: hoai1
  Date: 12/4/2024
  Time: 2:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/link/headLink.jsp"%>
<html>
<head>
    <title>Các mẫu thiết kế</title>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<link rel="stylesheet" href="css/police-return.css">
<!--jQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!--content-->
<div class="container-fluid mt-3 mb-5">
    <div class="row">
        <div class="col-md-12">
            <h1 class="text-center">Chính sách đổi trả hàng</h1>
            <div class="row">
                <div class="col-md-1"></div>
                <p
                        class="ps-5 pe-5 text-center col-md-10"
                        style="font-style: italic"
                >
                    Cảm ơn quý khách đã tin tưởng lựa chọn sản phẩm vải may mặc của
                    chúng tôi. Chúng tôi cam kết mang đến cho quý khách hàng những sản
                    phẩm chất lượng và dịch vụ tốt nhất. Chính sách đổi trả hàng hóa
                    dưới đây sẽ giúp quý khách yên tâm hơn khi mua sắm tại cửa
                    hàng/chúng tôi:
                </p>
                <div class="col-md-1"></div>
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                        <ul style="list-style-type: none">
                            <li>
                                <h4>1. Điều kiện áp dụng đổi trả</h4>
                                <ul>
                                    <li>
                                        <b>Thời gian đổi trả:</b> Quý khách có thể yêu cầu đổi
                                        trả trong vòng 7 ngày kể từ ngày nhận hàng (đối với sản
                                        phẩm vải chưa sử dụng).
                                    </li>
                                    <li>
                                        <b>Sản phẩm không bị hư hỏng:</b> Sản phẩm vải cần được
                                        trả lại trong tình trạng nguyên vẹn, không bị rách, sờn,
                                        mất nếp, không có mùi lạ hoặc bị tác động bởi các yếu tố
                                        khác.
                                    </li>
                                    <li>
                                        <b>Hóa đơn mua hàng:</b> Quý khách cần giữ lại hóa đơn
                                        hoặc biên lai mua hàng để làm căn cứ khi yêu cầu đổi
                                        trả.
                                    </li>
                                    <li>
                                        <b>Sản phẩm chưa qua gia công:</b> Đối với vải may mặc,
                                        nếu đã cắt hoặc may thành sản phẩm thì không được đổi
                                        trả trừ khi vải bị lỗi do nhà sản xuất.
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4>2. Lý do đổi trả</h4>
                                <ul>
                                    <li>
                                        <b>Sản phẩm bị lỗi:</b> Quý khách phát hiện sản phẩm bị
                                        lỗi do nhà sản xuất như vải bị rách, lỗi dệt, nhuộm sai
                                        màu, hay chất lượng không đạt yêu cầu.
                                    </li>
                                    <li>
                                        <b>Sản phẩm không đúng mẫu:</b> Nếu sản phẩm nhận được
                                        không đúng với đơn đặt hàng (về màu sắc, loại vải, kích
                                        thước,...), quý khách có thể yêu cầu đổi trả.
                                    </li>
                                    <li>
                                        <b>Sản phẩm không phù hợp:</b> Trong trường hợp sản phẩm
                                        không phù hợp với nhu cầu hoặc yêu cầu của quý khách,
                                        chúng tôi có thể hỗ trợ đổi sang mẫu vải khác (nếu còn
                                        hàng) hoặc hoàn tiền (trong trường hợp không có sản phẩm
                                        thay thế).
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4>3. Quy trình đổi trả</h4>
                                <ul>
                                    <li>
                                        <b>Bước 1:</b> Liên hệ với chúng tôi qua email, số điện
                                        thoại hỗ trợ hoặc fanpage để thông báo về yêu cầu đổi
                                        trả và lý do đổi trả.
                                    </li>
                                    <li>
                                        <b>Bước 2:</b> Cung cấp thông tin chi tiết như mã đơn
                                        hàng, hình ảnh sản phẩm (nếu có lỗi), và yêu cầu đổi
                                        trả.
                                    </li>
                                    <li>
                                        <b>Bước 3:</b> Chúng tôi sẽ kiểm tra yêu cầu và thông
                                        báo quý khách về cách thức gửi trả hàng (quý khách có
                                        thể gửi lại sản phẩm qua bưu điện hoặc mang trực tiếp
                                        đến cửa hàng nếu thuận tiện).
                                    </li>
                                    <li>
                                        <b>Bước 4:</b> Sau khi nhận sản phẩm trả lại, chúng tôi
                                        sẽ kiểm tra tình trạng sản phẩm và thực hiện đổi hàng
                                        hoặc hoàn tiền cho quý khách trong vòng 7 ngày làm việc.
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4>4. Phí đổi trả</h4>
                                <ul>
                                    <li>
                                        <b>Đổi hàng:</b> Miễn phí đổi hàng nếu vải bị lỗi, không
                                        đúng mẫu hoặc có sự cố do nhà sản xuất.
                                    </li>
                                    <li>
                                        <b>Trả hàng và hoàn tiền:</b> Quý khách chịu chi phí vận
                                        chuyển khi trả lại sản phẩm do thay đổi ý định hoặc
                                        không phù hợp. Chúng tôi sẽ hoàn lại tiền sau khi nhận
                                        được sản phẩm trả lại và kiểm tra tình trạng sản phẩm.
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4>5. Trường hợp không áp dụng đổi trả</h4>
                                <ul>
                                    <li>Sản phẩm vải đã được cắt, may hoặc sử dụng.</li>
                                    <li>
                                        Sản phẩm đã bị thay đổi trạng thái ban đầu (như giặt,
                                        nhuộm, hoặc sửa chữa).
                                    </li>
                                    <li>
                                        Quá thời gian đổi trả (quá 7 ngày kể từ ngày nhận hàng).
                                    </li>
                                    <li>
                                        Sản phẩm không có hóa đơn mua hàng, hoặc không đúng với
                                        thông tin mua hàng ban đầu.
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <h4>6. Lưu ý quan trọng</h4>
                                <ul>
                                    <li>
                                        Sản phẩm vải có thể có sự chênh lệch nhẹ về màu sắc giữa
                                        các lô sản xuất hoặc trong ánh sáng khác nhau. Điều này
                                        không được coi là lỗi.
                                    </li>
                                    <li>
                                        Quý khách vui lòng kiểm tra kỹ sản phẩm trước khi quyết
                                        định đặt mua.
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
                        <input type="checkbox" name="readedPolicyReturn" id="readed" />
                        <label for="readed" class="fw-bold"
                        >Tôi đã đọc và đồng ý với chính sách đổi trả hàng của cửa
                            hàng.</label
                        >
                    </div>
                </div>
                <div
                        class="row"
                        id="folowReturn"
                        style="border: 1px solid black; border-top: #4fd0b6 5px solid"
                >
                    <h4 class="fw-bold text-center">Quy trình đổi trả hàng</h4>
                    <div class="ms-5">
                        <h6>
                            <b>Bước 1:</b> Liên hệ với chúng tôi thông qua số điện thoại
                            hoặc email được thông báo trên trang website của chúng tôi.
                        </h6>
                        <h6>
                            <b>Bước 2:</b> Kiểm tra lại chính sách đổi trả hàng và đóng
                            gói hàng.
                        </h6>
                        <h6>
                            <b>Bước 3:</b> Bàn giao sản phẩm đến chúng tôi thông qua các
                            đơn vị vận chuyển.
                        </h6>
                        <h6><b>Bước 4:</b> Đơn hàng sẽ được phê duyệt và hoàn tiền.</h6>
                        <a
                                href="https://zalo.me/0377314202"
                                style="
                    float: right;
                    margin-right: 30%;
                    font-style: italic;
                    font-size: 20px;
                  "
                                class="text-primary"
                        >Liên hệ với chúng tôi.</a
                        >
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

<%@include file="includes/footer.jsp"%>
<%@include file="includes/link/footLink.jsp"%>
<script src="js/police-return.js"></script>
</body>
</html>