package services;

import dao.DashboardDAO;
import dao.OrderDAO;
import models.Order;
import models.OrderDetail;


import java.util.ArrayList;

import java.util.List;

public class OrderService {
    OrderDAO dao;
    public OrderService(){
        dao = new OrderDAO();
    }
    public int insertOrder(Order order){
        return dao.insertOrder(order);
    }

    public List<Order> getOrderByUserId(int id) {
        List<Order> orders = dao.getOrdersByUserId(id);
        OrderDetailService orderDetailService = new OrderDetailService();
        for (Order order : orders) {
            order.setListOfDetailOrder(orderDetailService.getOrderDetailByOrder(order.getId()));
        }
        return orders;
    }
    public Order getOrder(int orderId){
        OrderDetailService orderService = new OrderDetailService();
        Order order = dao.getOder(orderId);
        order.setListOfDetailOrder(orderService.dao.getOrderDetailByOrder(orderId));
        return order;

    }
    public List<Order> getAllOrders() {
        return dao.getAllOrders();
    }
    public int getNuPage(int nu) {
        int nuOder = getAllOrders().size();
        int res = 0;
        if(nuOder%nu != 0){
            res = nuOder/nu +1 ;
        }else {
            res = nuOder/nu;
        }
        return res;
    }
    public List<Order> getOrdersByPage(int page, int ordersPerPage) {
        int startOrder = (page - 1) * ordersPerPage;
        List<Order> allOrders = getAllOrders();
        int endOrder;
        if(startOrder+ordersPerPage > allOrders.size()){
            endOrder = allOrders.size();
        }else {
            endOrder = startOrder + ordersPerPage;
        }

        List<Order> ordersForPage = new ArrayList<>();
        for (int i = startOrder; i < endOrder && i < allOrders.size(); i++) {
            ordersForPage.add(allOrders.get(i));
        }

        return ordersForPage;
    }

    public boolean updateOrderStatus(int orderId, String newStatus) {
        return dao.updateOrderStatus(orderId, newStatus);
    }

    public boolean deleteOrder(int orderId) {
        return false;
    }

    public void updateOrderTotalAndLastPrice(int orderId) {
        Order order = getOrder(orderId);
        if (order != null) {
            double totalPrice = 0;
            for (OrderDetail detail : order.getListOfDetailOrder()) {
                totalPrice += detail.getTotalPrice();
            }
            dao.updateOrderTotal(orderId, totalPrice);
        }
    }
}
