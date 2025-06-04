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
}
