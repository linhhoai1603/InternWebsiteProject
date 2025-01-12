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

    public List<Order> getAllProduct(){
        DashboardDAO dashboardDAO = new DashboardDAO();
        VoucherService voucherService = new VoucherService();
        OrderDetailService orderDetailService = new OrderDetailService();
        List<Order> orders = dashboardDAO.getAllProducts();
        for(Order order : orders){
            // xu ly user
            order.setVoucher(voucherService.getVoucherById(order.getVoucher().getIdVoucher()));
            order.setListOfDetailOrder(orderDetailService.getOrderDetailByOrder(order.getId()));
        }
        return orders;
    }

}
