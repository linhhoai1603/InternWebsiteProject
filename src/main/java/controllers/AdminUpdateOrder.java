package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import services.OrderService;

import java.io.IOException;

@WebServlet("/admin/update-order")
public class AdminUpdateOrder extends HttpServlet {
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get order ID and new status from request
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("status");

            // Create order object with updated status
            Order order = new Order();
            order.setId(orderId);
            order.setStatus(newStatus);

            // Update order
            boolean success = orderService.updateOrder(order);

            // Send response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            if (success) {
                response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật trạng thái đơn hàng thành công\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Cập nhật trạng thái đơn hàng thất bại\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi server: " + e.getMessage() + "\"}");
        }
    }
} 