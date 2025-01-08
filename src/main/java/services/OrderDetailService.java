package services;

import dao.OrderDetailDAO;
import models.OrderDetail;

public class OrderDetailService {
    OrderDetailDAO dao;
    public OrderDetailService(){
        dao = new OrderDetailDAO();
    }
    public boolean insertOrderDetail(OrderDetail orderDetail){
        return dao.insertOrderDetail(orderDetail);
    }
}
