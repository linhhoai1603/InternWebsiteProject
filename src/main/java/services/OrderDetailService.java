package services;

import dao.OrderDetailDAO;
import models.OrderDetail;

import java.util.List;

public class OrderDetailService {
    OrderDetailDAO dao;
    public OrderDetailService(){
        dao = new OrderDetailDAO();
    }
    public boolean insertOrderDetail(OrderDetail orderDetail){
        return dao.insertOrderDetail(orderDetail);
    }
    public List<OrderDetail> getOrderDetailByOrder(int idOrder){
        return dao.getOrderDetailByOrder(idOrder);
    }
    public OrderDetail getOrderDetailById(int id) {
        return dao.getOrderDetailById(id);
    }

    public boolean deleteOrderDetailById(int id) {
        return dao.deleteOrderDetailById(id);
    }

    public boolean updateOrderDetail(OrderDetail orderDetail) {
        return dao.updateOrderDetail(orderDetail);
    }

    public boolean deleteOrderDetails(int orderId) {
        try {
            // Lấy danh sách chi tiết đơn hàng
            List<OrderDetail> details = getOrderDetailByOrder(orderId);
            
            // Xóa từng chi tiết
            for (OrderDetail detail : details) {
                if (!deleteOrderDetailById(detail.getId())) {
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        try {
            System.out.println("OrderDetailService: Getting order details for order ID: " + orderId);
            List<OrderDetail> orderDetails = dao.getOrderDetailByOrder(orderId);
            System.out.println("OrderDetailService: Found " + (orderDetails != null ? orderDetails.size() : 0) + " order details");
            return orderDetails;
        } catch (Exception e) {
            System.out.println("OrderDetailService: Exception getting order details by order ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}
