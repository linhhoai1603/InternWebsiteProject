package controllers;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.AccountUser;
import models.Cart;
import models.CartItem;
import services.CartService;
import services.ProductService;

@WebServlet(name = "AddToCartServlet", value = "/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    ProductService productService = new ProductService();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form gửi tới
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int idStyle = Integer.parseInt(request.getParameter("selectedStyle"));
        String originalUrl = request.getParameter("currentURL");

        // Xử lý thêm vào giỏ hàng
        CartService cartService = new CartService();
        AccountUser acc = (AccountUser) request.getSession().getAttribute("account");
        Cart cart = (Cart) request.getSession().getAttribute("cart");

        // Get the product ID from the style
        int productId = productService.getIdProductByIdStyle(idStyle);
        // Get the unit price for the product
        double unitPrice = productService.getPriceByIdProduct(productId);

        // Thêm item vào giỏ
        cartService.addToCartItem(acc.getUser().getId(), new CartItem(cart.getId(), idStyle, quantity));

        // Cập nhật lại giỏ hàng trong session
        request.getSession().setAttribute("cart", cartService.getCart(acc.getUser().getId()));

        // Redirect về trang cũ
        String contextPath = request.getContextPath(); // ví dụ: /ProjectWeb_war
        response.sendRedirect(contextPath + "/" + originalUrl);
    }
}
