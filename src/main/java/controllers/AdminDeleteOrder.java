package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.OrderService;

import java.io.IOException;

@WebServlet(name = "AdminDeleteOrder", value = "/admin/delete-order")
public class AdminDeleteOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderService orderService = new OrderService();
        boolean success = orderService.deleteOrder(orderId);

        if (success) {
            request.getSession().setAttribute("successMessage", "Xóa đơn hàng thành công!");
        } else {
            request.getSession().setAttribute("errorMessage", "Xóa đơn hàng thất bại.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/manager-order");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 