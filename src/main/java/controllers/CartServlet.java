package controllers;

import java.io.*;

import dao.StyleDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Cart;
import models.CartItem;
import models.Style;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if("add".equals(method)){
            addToCart(request, response);
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // lấy thông tin từ người dùng gửi qua
        int idStyle = Integer.parseInt(request.getParameter("selectedStyle"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        // lấy ra sản phẩm từ id
        StyleDao styleDao = new StyleDao();
        CartItem itemNew = new CartItem(styleDao.getStyleByID(idStyle), quantity);
        Cart cart =(Cart) request.getSession().getAttribute("cart"); // lấy ra cart hiện tại
        cart.add(itemNew); // thêm item và cart
        request.getSession().setAttribute("cart", cart);
        String currentURL = request.getParameter("currentURL");
        request.getRequestDispatcher(currentURL).forward(request,response);
    }
}