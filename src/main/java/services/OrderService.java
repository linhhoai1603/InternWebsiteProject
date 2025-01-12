package services;

import dao.DashboardDAO;
import dao.OrderDAO;
import models.Order;

import java.util.List;

public class OrderService {
    OrderDAO dao;
    public OrderService(){
        dao = new OrderDAO();
    }
    public int insertOrder(Order order){
        return dao.insertOrder(order);
    }

    public List<Order> getOrderByUserId(int id){
        List<Order> orders = dao.getOrdersByUserId(id);
        OrderDetailService orderDetailService = new OrderDetailService();
        for(Order order : orders){
            order.setListOfDetailOrder(orderDetailService.getOrderDetailByOrder(order.getId()));
        }
        return orders;
    }

}
