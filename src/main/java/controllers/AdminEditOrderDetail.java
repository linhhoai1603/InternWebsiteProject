package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.OrderDetail;
import models.Style;
import services.OrderDetailService;
import services.OrderService;
import services.StyleService; // Assuming you have a StyleService to get style details

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminEditOrderDetail", value = "/admin/edit-order-detail")
public class AdminEditOrderDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String detailIdStr = request.getParameter("detailId");
        String orderIdStr = request.getParameter("orderId");
        OrderDetailService orderDetailService = new OrderDetailService();
        StyleService styleService = new StyleService(); // Assuming this service exists

        List<Style> allStyles = styleService.getAllStyles(); // Assuming you have a method to get all styles
        request.setAttribute("allStyles", allStyles);

        if (detailIdStr != null && !detailIdStr.isEmpty()) {
            // Editing existing detail
            int detailId = Integer.parseInt(detailIdStr);
            OrderDetail orderDetail = orderDetailService.getOrderDetailById(detailId);
            if (orderDetail != null) {
                request.setAttribute("orderDetail", orderDetail);
                request.setAttribute("orderId", orderDetail.getIdOrder()); // Pass orderId for context
                request.getRequestDispatcher("/admin/edit-order-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manager-order?error=Order detail not found");
            }
        } else if (orderIdStr != null && !orderIdStr.isEmpty()) {
            // Adding new detail to an existing order
            int orderId = Integer.parseInt(orderIdStr);
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("/admin/edit-order-detail.jsp").forward(request, response);
        } else {
            // Invalid request
            response.sendRedirect(request.getContextPath() + "/admin/manager-order?error=Invalid request");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = -1; // Default invalid value
        try {
            orderId = Integer.parseInt(request.getParameter("orderId"));
            String detailIdStr = request.getParameter("detailId");
            int styleId = Integer.parseInt(request.getParameter("styleId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            OrderDetailService orderDetailService = new OrderDetailService();
            OrderService orderService = new OrderService();
            StyleService styleService = new StyleService(); // Assuming this service exists

            Style selectedStyle = styleService.getStyleById(styleId); // Assuming this method exists

            if (selectedStyle == null) {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy thông tin sản phẩm.");
                 response.sendRedirect(request.getContextPath() + "/admin/edit-order?orderId=" + orderId);
                 return;
            }

            boolean success = false;
            if (detailIdStr != null && !detailIdStr.isEmpty()) {
                // Editing existing detail
                int detailId = Integer.parseInt(detailIdStr);
                OrderDetail orderDetail = orderDetailService.getOrderDetailById(detailId);
                if (orderDetail != null) {
                    orderDetail.setStyle(selectedStyle);
                    orderDetail.setQuantity(quantity);
                    // Recalculate total price and weight based on new quantity and style price/weight
                    orderDetail.setTotalPrice(quantity * selectedStyle.getProduct().getPrice().getLastPrice()); // Assuming Product and Price are loaded with Style
                    orderDetail.setWeight(quantity * 0.5); // Assuming a fixed weight per item or style has weight info

                    success = orderDetailService.updateOrderDetail(orderDetail);
                } else {
                     request.getSession().setAttribute("errorMessage", "Không tìm thấy chi tiết đơn hàng để cập nhật.");
                     response.sendRedirect(request.getContextPath() + "/admin/edit-order?orderId=" + orderId);
                     return;
                }
            } else {
                // Adding new detail
                OrderDetail newOrderDetail = new OrderDetail();
                newOrderDetail.setIdOrder(orderId);
                newOrderDetail.setStyle(selectedStyle);
                newOrderDetail.setQuantity(quantity);
                 // Recalculate total price and weight
                newOrderDetail.setTotalPrice(quantity * selectedStyle.getProduct().getPrice().getLastPrice()); // Assuming Product and Price are loaded with Style
                newOrderDetail.setWeight(quantity * 0.5); // Assuming a fixed weight per item or style has weight info

                success = orderDetailService.insertOrderDetail(newOrderDetail);
            }

            if (success) {
                // Update total price of the main order
                orderService.updateOrderTotalAndLastPrice(orderId);
                request.getSession().setAttribute("successMessage", "Lưu chi tiết đơn hàng thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Lưu chi tiết đơn hàng thất bại.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu nhập vào không hợp lệ.");
            e.printStackTrace();
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi khi lưu chi tiết đơn hàng.");
            e.printStackTrace();
        }

        // Redirect back to the edit order page
        if (orderId != -1) {
            response.sendRedirect(request.getContextPath() + "/admin/edit-order?orderId=" + orderId);
        } else {
             response.sendRedirect(request.getContextPath() + "/admin/manager-order?error=Could not determine order ID");
        }
    }
} 