package controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import services.OrderService;

import java.io.IOException;

@WebServlet(value = "/admin/order-detail")
public class AdminManagerOrderDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        OrderService orderService = new OrderService();
        Order order = orderService.getOrder(orderId);
         request.setAttribute("order", order);
         request.getRequestDispatcher("management-detail-orders.jsp").forward(request, response);
    }

}