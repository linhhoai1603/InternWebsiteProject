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
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
                request.setAttribute("error", "Mã đơn hàng không hợp lệ");
                request.getRequestDispatcher("/admin/manager-order").forward(request, response);
                return;
            }

            int orderId = Integer.parseInt(orderIdStr);
            
            // Xóa đơn hàng
            boolean success = orderService.deleteOrder(orderId);
            
            if (success) {
                request.setAttribute("success", "Xóa đơn hàng thành công!");
            } else {
                request.setAttribute("error", "Xóa đơn hàng thất bại.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Mã đơn hàng không hợp lệ");
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }

        // Chuyển hướng về trang quản lý đơn hàng
        response.sendRedirect(request.getContextPath() + "/admin/manager-order");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 