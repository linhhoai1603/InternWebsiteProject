package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import services.OrderService;

import java.io.IOException;

@WebServlet(name = "AdminEditOrder", value = "/admin/edit-order")
public class AdminEditOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderService orderService = new OrderService();
        Order order = orderService.getOrder(orderId);

        if (order != null) {
            request.setAttribute("order", order);
            request.getRequestDispatcher("/admin/edit-order.jsp").forward(request, response);
        } else {
            // Handle case where order is not found
            response.sendRedirect(request.getContextPath() + "/admin/manager-order?error=Order not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            OrderService orderService = new OrderService();
            boolean success = orderService.updateOrderStatus(orderId, status);

            if (success) {
                request.getSession().setAttribute("successMessage", "Cập nhật trạng thái đơn hàng thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Cập nhật trạng thái đơn hàng thất bại.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Mã đơn hàng không hợp lệ.");
            e.printStackTrace();
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi khi cập nhật đơn hàng.");
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/manager-order");
    }
} 