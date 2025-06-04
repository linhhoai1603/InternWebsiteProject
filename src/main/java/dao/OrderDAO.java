package dao;

import connection.DBConnection;
import models.Address;
import models.Order;
import models.User;
import models.Voucher;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    Jdbi jdbi;

    public OrderDAO() {
        jdbi = DBConnection.getConnetion();
    }

    public int insertOrder(Order order) {
        String query = "INSERT INTO orders (timeOrder, idUser, idVoucher, statusOrder, " +
                "totalPrice, lastPrice) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        return jdbi.withHandle(handle -> handle.createUpdate(query)
                .bind(0, order.getTimeOrdered())
                .bind(1, order.getUser().getId())
                .bind(2, order.getVoucher() != null ? order.getVoucher().getIdVoucher() : null) // Check for null voucher
                .bind(3, order.getStatus())
                .bind(4, order.getTotalPrice())
                .bind(5, order.getLastPrice())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(Integer.class)
                .findOnly());
    }

    public boolean updateOrderStatus(int orderId, String newStatus) {
        String query = "UPDATE orders SET statusOrder = :status WHERE id = :id";

        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bind("status", newStatus)
                        .bind("id", orderId)
                        .execute() > 0
        );
    }

    public List<Order> getAllOrders() {
        String query = "SELECT * FROM orders";

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .map((rs, ctx) -> {
                    // Handle user
                    User user = new User();
                    user.setId(rs.getInt("idUser"));
                    // Handle voucher
                    Voucher voucher = new Voucher();
                    Integer idVoucher = (Integer) rs.getObject("idVoucher");
                    if (idVoucher != null) {
                        voucher.setIdVoucher(idVoucher);
                    } else {
                        voucher.setIdVoucher(null);
                    }
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

    public Order getOder(int id) {
        String query = "SELECT * FROM orders WHERE id = :id";

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind("id", id)
                .map((rs, ctx) -> {
                    // Handle user
                    User user = new User();
                    user.setId(rs.getInt("idUser"));

                    // Handle voucher
                    Voucher voucher = new Voucher();
                    Integer idVoucher = (Integer) rs.getObject("idVoucher");
                    if (idVoucher != null) {
                        voucher.setIdVoucher(idVoucher);
                    } else {
                        voucher.setIdVoucher(null);
                    }

                    // Handle order
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setTimeOrdered(rs.getObject("timeOrder", LocalDateTime.class));
                    order.setUser(user);
                    order.setVoucher(voucher);
                    order.setStatus(rs.getString("statusOrder"));
                    order.setTotalPrice(rs.getDouble("totalPrice"));
                    order.setLastPrice(rs.getDouble("lastPrice"));

                    return order;
                }).findOne().orElse(null));
    }

    public List<Order> getOrdersByUserId(int userId) {
        String query = "SELECT * FROM orders WHERE idUser = :idUser ORDER BY timeOrder ASC";

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind("idUser", userId)
                .map((rs, ctx) -> {
                    // Handle user
                    User user = new User();
                    user.setId(rs.getInt("idUser"));

                    // Handle voucher
                    Voucher voucher = new Voucher();
                    Integer idVoucher = (Integer) rs.getObject("idVoucher");
                    if (idVoucher != null) {
                        voucher.setIdVoucher(idVoucher);
                    } else {
                        voucher.setIdVoucher(null);
                    }

                    // Handle order
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
    public void cancelOrder(int orderId) {
        String query = "UPDATE orders SET statusOrder = :status WHERE id = :id";

        jdbi.useHandle(handle ->
                handle.createUpdate(query)
                        .bind("status", "CANCELLED")
                        .bind("id", orderId)
                        .execute()
        );
    }
    public boolean deleteOrder(int orderId) {
        try {
            System.out.println("OrderDAO: Starting to delete order " + orderId);
            
            jdbi.useTransaction(handle -> {
                // Xóa các bản ghi thanh toán trước
                int paymentsDeleted = handle.createUpdate("DELETE FROM payments WHERE idOrder = :idOrder")
                        .bind("idOrder", orderId)
                        .execute();
                System.out.println("OrderDAO: Deleted " + paymentsDeleted + " payments");

                // Xóa chi tiết đơn hàng
                int detailsDeleted = handle.createUpdate("DELETE FROM order_details WHERE idOrder = :idOrder")
                        .bind("idOrder", orderId)
                        .execute();
                System.out.println("OrderDAO: Deleted " + detailsDeleted + " order details");

                // Sau đó xóa đơn hàng
                int orderDeleted = handle.createUpdate("DELETE FROM orders WHERE id = :id")
                        .bind("id", orderId)
                        .execute();
                System.out.println("OrderDAO: Deleted " + orderDeleted + " orders");
            });
            
            System.out.println("OrderDAO: Order deletion completed successfully");
            return true;
        } catch (Exception e) {
            System.out.println("OrderDAO: Exception during order deletion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateOrderTotal(int orderId, double totalPrice) {
        String query = "UPDATE orders SET totalPrice = :totalPrice, lastPrice = :totalPrice WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bind("totalPrice", totalPrice)
                        .bind("id", orderId)
                        .execute() > 0
        );
    }

    public boolean updateOrder(Order order) {
        try {
            System.out.println("OrderDAO: Starting to update order " + order.getId());
            
            jdbi.useTransaction(handle -> {
                int updated = handle.createUpdate("""
                    UPDATE orders 
                    SET status = :status,
                        updatedAt = NOW()
                    WHERE id = :id
                """)
                .bind("id", order.getId())
                .bind("status", order.getStatus())
                .execute();
                
                System.out.println("OrderDAO: Updated " + updated + " orders");
            });
            
            System.out.println("OrderDAO: Order update completed successfully");
            return true;
        } catch (Exception e) {
            System.out.println("OrderDAO: Exception during order update: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Order getOrderById(int orderId) {
        try {
            System.out.println("OrderDAO: Getting order by ID: " + orderId);
            Order order = jdbi.withHandle(handle -> {
                return handle.createQuery("SELECT * FROM orders WHERE id = :id")
                             .bind("id", orderId)
                             .mapToBean(Order.class)
                             .findOne()
                             .orElse(null);
            });
            System.out.println("OrderDAO: Found order: " + (order != null));
            return order;
        } catch (Exception e) {
            System.out.println("OrderDAO: Exception getting order by ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}
