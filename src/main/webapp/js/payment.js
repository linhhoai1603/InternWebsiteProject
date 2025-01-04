$(document).ready(function () {
    $("#voucher").click(function () {
        $("#inputVoucher").slideToggle();
    });
    $("#otherAddress").click(function () {
        $("#form-otherAddress").slideToggle();
    });
    $("#payment-online").click(function () {
        $("#messageOnline").slideDown();
        $("#messageCash").slideUp();
    });
    $("#payment-cash").click(function () {
        $("#messageCash").slideDown();
        $("#messageOnline").slideUp();
    });
});
