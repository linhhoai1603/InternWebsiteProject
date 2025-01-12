package dao;

import connection.DBConnection;
import models.Order;
import models.User;
import models.Voucher;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class DashboardDAO {
    private Jdbi jdbi;
    public DashboardDAO() {
        jdbi = DBConnection.getConnetion();
    }

    public int getNumberOfUsers() {
        String query = "SELECT COUNT(*) FROM users";
        return jdbi.withHandle(handle -> handle.createQuery(query).mapTo(Integer.class).one());
    }

    public int getNumberOfVouchers() {
        String query = "SELECT COUNT(*) FROM vouchers";
        return jdbi.withHandle(handle -> handle.createQuery(query).mapTo(Integer.class).one());
    }

    public double getTotalRevenue() {
        String query = "SELECT SUM(lastPrice) FROM orders";
        return jdbi.withHandle(handle -> handle.createQuery(query).mapTo(Double.class).one());
    }
    public double getTotalRevenueForMonth(int month) {
        String query = "SELECT SUM(lastPrice) FROM orders WHERE YEAR(timeOrder) = ? AND MONTH(timeOrder) = ?";
        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, LocalDate.now().getYear())  // Bind the current year
                        .bind(1, month)  // Bind the input month
                        .mapTo(Double.class)  // Map to Double
                        .findOne().orElse(0.0)  // Return 0.0 if there is no result
        );
    }
    
    public int getNumberOfOrders() {
        String query = "SELECT COUNT(*) FROM orders";
        return jdbi.withHandle(handle -> handle.createQuery(query).mapTo(Integer.class).one());
    }

    public List<Order> getTenNewOrders() {
        String query = "SELECT * FROM orders ORDER BY timeOrder DESC LIMIT 10";

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .map((rs, ctx) -> {
                  // xu ly cho user
                    User user = new User();
                    user.setId(rs.getInt("idUser"));
                    // xu ly cho voucher
                    Voucher voucher = new Voucher();
                    Integer idVoucher = (Integer) rs.getObject("idVoucher");
                    if (idVoucher != null) {
                        voucher.setIdVoucher(idVoucher);
                    } else {
                        voucher.setIdVoucher(null); // Or do nothing if you want to keep it as null
                    }
                    // xu ly cho don hang
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setTimeOrdered(rs.getObject("timeOrder", LocalDateTime.class));
                    order.setUser(user);
                    order.setVoucher(voucher);
                    order.setStatus(rs.getString("statusOrder"));
                    order.setTotalPrice(rs.getDouble("totalPrice"));
                    order.setLastPrice(rs.getDouble("lastPrice"));
                    return order;

                }).list());
    }

    public List<Order> getAllProducts() {
        String query = "SELECT * FROM orders";

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .map((rs, ctx) -> {
                    // xu ly cho user
                    User user = new User();
                    user.setId(rs.getInt("idUser"));
                    // xu ly cho voucher
                    Voucher voucher = new Voucher();
                    Integer idVoucher = (Integer) rs.getObject("idVoucher");
                    if (idVoucher != null) {
                        voucher.setIdVoucher(idVoucher);
                    } else {
                        voucher.setIdVoucher(null); // Or do nothing if you want to keep it as null
                    }
                    // xu ly cho don hang
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setTimeOrdered(rs.getObject("timeOrder", LocalDateTime.class));
                    order.setUser(user);
                    order.setVoucher(voucher);
                    order.setStatus(rs.getString("statusOrder"));
                    order.setTotalPrice(rs.getDouble("totalPrice"));
                    order.setLastPrice(rs.getDouble("lastPrice"));
                    return order;

                }).list());
    }


    public static void main(String[] args) {
        DashboardDAO dashboardDAO = new DashboardDAO();
        System.out.println(dashboardDAO.getTenNewOrders());
    }
}
