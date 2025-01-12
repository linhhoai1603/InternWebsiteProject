package services;

import dao.OrderDAO;
import models.Order;

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
    public List<Order> getAllOrders() {
        return dao.getAllOder();
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
        // Tính số đơn hàng bắt đầu và kết thúc dựa trên trang và số đơn hàng mỗi trang
        int startOrder = (page - 1) * ordersPerPage;
        int endOrder = page * ordersPerPage;

        // Lấy tất cả các đơn hàng
        List<Order> allOrders = getAllOrders();

        // Lọc các đơn hàng trong phạm vi của trang yêu cầu
        List<Order> ordersForPage = new ArrayList<>();
        for (int i = startOrder; i < endOrder && i < allOrders.size(); i++) {
            ordersForPage.add(allOrders.get(i));
        }

        return ordersForPage;
    }

    public static void main(String[] args) {
        OrderService orderService = new OrderService();
        System.out.println(orderService.getOrdersByPage(1,5));
    }

}
