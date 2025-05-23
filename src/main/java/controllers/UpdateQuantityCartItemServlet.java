package controllers;

import java.io.IOException;

import dao.CartItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.AccountUser;
import models.Cart;
import services.CartService;
import services.ProductService;

@WebServlet(name = "UpdateQuantityCartItemServlet", value = "/update-cart-item")
public class UpdateQuantityCartItemServlet extends HttpServlet {
    ProductService productService = new ProductService();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            int idItem = Integer.parseInt(request.getParameter("idItem"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Lấy tài khoản và giỏ hàng từ session
            HttpSession session = request.getSession();
            AccountUser acc = (AccountUser) session.getAttribute("account");
            Cart cart = (Cart) session.getAttribute("cart");

            // Kiểm tra đăng nhập và giỏ hàng
            if (acc != null && cart != null) {
                CartItemDAO cartItemDAO = new CartItemDAO();
                int idStyle = cartItemDAO.getIdStyleByidItem(idItem);
                int idProduct = productService.getIdProductByIdStyle(idStyle);
                double price = productService.getPriceByIdProduct(idProduct);
                double unitPrice = price * quantity;
                CartService cartService = new CartService();
                cartService.updateQuantity(idItem, quantity, unitPrice);

                // Cập nhật lại cart trong session
                session.setAttribute("cart", cartService.getCart(acc.getUser().getId()));
            }

            // Quay lại trang giỏ hàng
            response.sendRedirect(request.getContextPath() + "/shopping-cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error/500.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
