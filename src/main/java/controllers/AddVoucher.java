package controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Cart;
import models.Voucher;
import services.CartService; // Bạn cần có service này
import services.VoucherService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Locale;

@WebServlet(name = "AddVoucher", value = "/addVoucher")
public class AddVoucher extends HttpServlet {

    VoucherService voucherService = new VoucherService();
    CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/checkout.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("cart") == null) {
            session.setAttribute("voucherMessage", "Giỏ hàng không tồn tại.");
            session.setAttribute("voucherStatus", "error");
            response.sendRedirect(request.getContextPath() + "/checkout.jsp");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        String voucherCodeParam = request.getParameter("voucherCodeInput");

        String redirectPage = request.getContextPath() + "/checkout.jsp";

        String voucherCode = voucherCodeParam.trim().toUpperCase();
        Voucher voucher = voucherService.getVoucherByCode(voucherCode);

        if (voucher == null) {
            session.setAttribute("voucherMessage", "Mã giảm giá '" + voucherCode + "' không hợp lệ hoặc không tồn tại.");
            session.setAttribute("voucherStatus", "error");
        } else {
            cart.recalculateCartTotals();

            if (voucher.getIsActive() != 1) {
                session.setAttribute("voucherMessage", "Mã giảm giá này không còn hoạt động.");
                session.setAttribute("voucherStatus", "error");
            } else if (voucher.getStartDate() != null && LocalDateTime.now().isBefore(voucher.getStartDate())) {
                session.setAttribute("voucherMessage", "Mã giảm giá này chưa đến ngày sử dụng.");
                session.setAttribute("voucherStatus", "error");
            } else if (voucher.getEndDate() != null && LocalDateTime.now().isAfter(voucher.getEndDate())) {
                session.setAttribute("voucherMessage", "Mã giảm giá đã hết hạn sử dụng.");
                session.setAttribute("voucherStatus", "error");
            } else if (cart.getTotalPrice() < voucher.getMinimumSpend()) {
                String minSpendFormatted = formatCurrency(voucher.getMinimumSpend());
                session.setAttribute("voucherMessage", "Đơn hàng chưa đạt giá trị tối thiểu (" + minSpendFormatted + ") để áp dụng mã này.");
                session.setAttribute("voucherStatus", "error");
            } else if (voucher.getMaxUses() != null && voucherService.getVoucherUsageCount(voucher.getCode()) >= voucher.getMaxUses()) {
                session.setAttribute("voucherMessage", "Mã giảm giá đã hết lượt sử dụng.");
                session.setAttribute("voucherStatus", "error");
            }
            else {
                boolean applied = voucherService.applyVoucherToCart(cart, voucher);

                if (applied) {
                    session.setAttribute("voucherMessage", "Áp dụng mã giảm giá '" + voucher.getCode() + "' thành công!");
                    session.setAttribute("voucherStatus", "success");
                } else {
                    session.setAttribute("voucherMessage", "Không thể áp dụng mã giảm giá. Vui lòng kiểm tra lại điều kiện.");
                    session.setAttribute("voucherStatus", "error");
                }
            }
        }

        session.setAttribute("cart", cart);
        response.sendRedirect(redirectPage);
    }
    private String formatCurrency(double amount) {
        java.text.NumberFormat currencyFormatter = java.text.NumberFormat.getCurrencyInstance(Locale.forLanguageTag("vi-VN"));
        return currencyFormatter.format(amount);
    }
}