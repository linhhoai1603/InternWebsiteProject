package services;

import dao.OrderDAO;
import models.Order;

public class OrderService {
    OrderDAO dao;
    public OrderService(){
        dao = new OrderDAO();
    }
    public int insertOrder(Order order){
        return dao.insertOrder(order);
    }
    public String convertStatus(int status){
        switch (status){
            case 0:
                return "Đang giao hàng";
            case 2:
                return "Đã giao hàng";
            default:
                return "Unknown";
        }
    }

}
