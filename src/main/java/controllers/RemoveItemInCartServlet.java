package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.AccountUser;
import models.Cart;
import services.CartService;
//import websocket.CartSyncEndpoint;

@WebServlet(name = "RemoveItemInCartServlet", value = "/delete-cart-item")
public class RemoveItemInCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CartService cartService = new CartService();
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        int idItem = Integer.parseInt(request.getParameter("idItem"));
        cartService.deleteCartItem(cart.getId(), idItem);
        AccountUser acc = (AccountUser) request.getSession().getAttribute("account");
//        CartSyncEndpoint.notifyCartChanged(acc.getUser().getId());
        request.getRequestDispatcher("/cart").forward(request, response);
    }
}