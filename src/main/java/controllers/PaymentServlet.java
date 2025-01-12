package controllers;

import java.io.*;
import java.text.NumberFormat;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Cart;
import models.Style;
import models.Voucher;
import services.ProductService;
import services.StyleService;
import services.VoucherService;

@WebServlet(name = "PaymentServlet", value = "/payment")
public class PaymentServlet extends HttpServlet {

    protected  void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if("applyVoucher".equals(method)) {
            applyVoucher(request, response);
        }
        if("start".equals(method)){
            startPayment(request, response);
        }

    }

    private void startPayment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (request.getSession().getAttribute("user") == null) {
            request.setAttribute("error", "Vui lòng đăng nhập trước khi thanh toán!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return; // Dừng xử lý thêm, không cần tiếp tục
        }

        // Kiểm tra xem giỏ hàng có trống không
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null || cart.getItems().values().isEmpty()) {
            request.setAttribute("error", "Không thể tiến hành thanh toán vì giỏ hàng trống!");
            request.getRequestDispatcher("shopping-cart.jsp").forward(request, response);
            return; // Dừng xử lý thêm, không cần tiếp tục
        }

        // Nếu người dùng đã đăng nhập và giỏ hàng không trống, chuyển hướng đến trang thanh toán
        response.sendRedirect("payment.jsp");
    }


    private void applyVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        VoucherService vs = new VoucherService();
        Voucher voucher = vs.getVoucherByCode(code);
        if(voucher == null) {
            request.setAttribute("message", "Mã giảm giá sai!");
        }else{
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            if(!cart.applyVoucher(voucher)){
                // Định dạng tiền Việt
                Locale vietnam = new Locale("vi", "VN");
                NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(vietnam);
                String formattedAmount = currencyFormatter.format(voucher.getConditionAmount());
                request.setAttribute("message", "Áp dụng cho đơn hàng trên "+formattedAmount);
            }else{
                request.setAttribute("message", "Giảm giá thành công!");
            }
        }
        request.getRequestDispatcher("payment.jsp").forward(request,response);
    }
}