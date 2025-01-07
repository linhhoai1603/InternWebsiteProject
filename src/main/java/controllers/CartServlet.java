package controllers;

import java.io.*;
import java.text.NumberFormat;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Cart;
import models.CartItem;
import models.Voucher;
import services.StyleService;
import services.VoucherService;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if("add".equals(method)) {
            addToCart(request, response);
        }
        if("changeStyle".equals(method)) {

        }
        if("updateQuantity".equals(method)) {
            updateQuantity(request, response);
        }
        if("remove".equals(method)) {
            remove(request, response);
        }
        if("applyVoucher".equals(method)) {
            applyVoucher(request, response);
        }

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
        request.getRequestDispatcher("shopping-cart.jsp").forward(request,response);
    }

    private void remove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idStyle = Integer.parseInt(request.getParameter("idStyle"));
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        cart.remove(idStyle);
       try{
           if(cart.getVoucher() != null) {
               if(cart.getTotalPrice() < cart.getVoucher().getConditionAmount()){
                   cart.applyVoucher(null);
               }
           }
       }catch (NullPointerException e){
           e.printStackTrace();
       }
        request.getSession().setAttribute("cart", cart);
        request.getRequestDispatcher("shopping-cart.jsp").forward(request, response);
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idStyle = Integer.parseInt(request.getParameter("idStyle"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        cart.updateQuantity(idStyle, quantity);
        request.getSession().setAttribute("cart", cart);
        request.getRequestDispatcher("shopping-cart.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // lấy thông tin từ người dùng gửi qua
        int idStyle = Integer.parseInt(request.getParameter("selectedStyle"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        // lấy ra sản phẩm từ id
        StyleService styleService = new StyleService();
        CartItem itemNew = new CartItem(styleService.getStyleByID(idStyle), quantity);
        Cart cart =(Cart) request.getSession().getAttribute("cart"); // lấy ra cart hiện tại
        cart.add(itemNew); // thêm item và cart
        request.getSession().setAttribute("cart", cart);
        String currentURL = request.getParameter("currentURL");
        request.getRequestDispatcher(currentURL).forward(request,response);
    }
    private void changeStyle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idOld = Integer.parseInt(request.getParameter("oldStyle"));
        int idNew = Integer.parseInt(request.getParameter("newStyle"));
        StyleService styleService = new StyleService();


    }

}