package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Cart;
import models.CartItem;
import services.StyleService;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if("add".equals(method)) {
            addToCart(request, response);
        }
        if("updateQuantity".equals(method)) {
            updateQuantity(request, response);
        }
        if("remove".equals(method)) {
            remove(request, response);
        }

    }

    private void remove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idStyle = Integer.parseInt(request.getParameter("idStyle"));
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        cart.remove(idStyle);
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
}