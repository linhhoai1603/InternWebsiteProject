package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.User;
import services.OrderService;

@WebServlet(name = "OrderedServlet", value = "/ordered")
public class OrderedServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            request.setAttribute("error", "Vui lòng đăng nhập để tiếp tục");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            OrderService orderService = new OrderService();
            request.setAttribute("orders", orderService.getOrderByUserId(user.getId()));
            request.getRequestDispatcher("ordered.jsp").forward(request, response);
        }
    }

}