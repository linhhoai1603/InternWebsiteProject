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
    public OrderDAO(){
        jdbi = DBConnection.getConnetion();
    }
    public int insertOrder(Order order) {
        String query = "INSERT INTO orders (timeOrder, idUser, idVoucher, statusOrder, totalPrice, lastPrice) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, order.getTimeOrdered())
                    .bind(1, order.getUser().getId())
                    .bind(2, order.getVoucher() != null ? order.getVoucher().getIdVoucher() : null) // Kiểm tra voucher null
                    .bind(3, order.getStatus())
                    .bind(4, order.getTotalPrice())
                    .bind(5, order.getLastPrice())
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .findOnly();
        });
    }
    public List<Order> getAllOder() {
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
                        voucher.setIdVoucher(null);
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
    public Order getOder(int id) {
        String query = "SELECT * FROM orders WHERE id = :id";

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind("id", id)
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
                        voucher.setIdVoucher(null);
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

                }).findOne().orElse(null));
    }


}
