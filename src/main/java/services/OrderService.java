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
        try {
            // Sau đó xóa đơn hàng
           return   dao.deleteOrder(orderId);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
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

    public boolean updateOrder(Order order) {
        try {
            System.out.println("OrderService: Starting to update order " + order.getId());
            
            // Validate order status
            if (order.getStatus() == null || order.getStatus().trim().isEmpty()) {
                System.out.println("OrderService: Invalid order status");
                return false;
            }
            
            // Update order
            boolean updated = dao.updateOrder(order);
            System.out.println("OrderService: Order update result: " + updated);
            
            return updated;
        } catch (Exception e) {
            System.out.println("OrderService: Exception during order update: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Order getOrderById(int orderId) {
        try {
            System.out.println("OrderService: Getting order by ID: " + orderId);
            Order order = dao.getOrderById(orderId);
            System.out.println("OrderService: Found order: " + (order != null));
            return order;
        } catch (Exception e) {
            System.out.println("OrderService: Exception getting order by ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}
