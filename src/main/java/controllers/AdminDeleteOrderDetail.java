package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.OrderDetail;
import services.OrderDetailService;
import services.OrderService;

import java.io.IOException;

@WebServlet(name = "AdminDeleteOrderDetail", value = "/admin/delete-order-detail")
public class AdminDeleteOrderDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int detailId = Integer.parseInt(request.getParameter("detailId"));
        OrderDetailService orderDetailService = new OrderDetailService();
        OrderService orderService = new OrderService();

        // Get orderId before deleting the detail
        OrderDetail detailToDelete = orderDetailService.getOrderDetailById(detailId);
        int orderId = -1; // Default invalid value
        if (detailToDelete != null) {
            orderId = detailToDelete.getIdOrder();
            boolean success = orderDetailService.deleteOrderDetailById(detailId);

            if (success) {
                // Update total price of the main order
                orderService.updateOrderTotalAndLastPrice(orderId);
                request.getSession().setAttribute("successMessage", "Xóa chi tiết đơn hàng thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Xóa chi tiết đơn hàng thất bại.");
            }
        } else {
            request.getSession().setAttribute("errorMessage", "Không tìm thấy chi tiết đơn hàng để xóa.");
        }


        // Redirect back to the edit order page
        if (orderId != -1) {
            response.sendRedirect(request.getContextPath() + "/admin/edit-order?orderId=" + orderId);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/manager-order?error=Could not determine order ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 