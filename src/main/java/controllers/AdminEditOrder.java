package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import models.OrderDetail;
import services.OrderService;
import services.OrderDetailService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/edit-order")
public class AdminEditOrder extends HttpServlet {
    private OrderService orderService;
    private OrderDetailService orderDetailService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
        orderDetailService = new OrderDetailService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            
            Order order = orderService.getOrderById(orderId);
            List<OrderDetail> orderDetails = orderDetailService.getOrderDetailsByOrderId(orderId);
            
            if (order != null) {
                request.setAttribute("order", order);
                request.setAttribute("orderDetails", orderDetails);
                request.getRequestDispatcher("/admin/edit-order.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Order ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
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