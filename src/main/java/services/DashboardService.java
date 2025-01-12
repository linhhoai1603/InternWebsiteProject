package services;

import dao.DashboardDAO;
import models.Order;

import java.util.List;

public class DashboardService {
    private DashboardDAO dashboardDao;
    public DashboardService() {
        dashboardDao = new DashboardDAO();
    }
    public int getNumberOfUsers(){
        return dashboardDao.getNumberOfUsers();
    }
    public int getNumberOfVouchers(){
        return dashboardDao.getNumberOfVouchers();
    }
    public double getTotalRevenue(){
        return dashboardDao.getTotalRevenue();
    }
    public int getNumberOfOrders(){
        return dashboardDao.getNumberOfOrders();
    }
    public List<Order> getTenNewOders(){
        return dashboardDao.getTenNewOrders();
    }
}
