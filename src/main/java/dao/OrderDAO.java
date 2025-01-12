package dao;

import connection.DBConnection;
import models.Order;
import models.User;
import models.Voucher;
import org.jdbi.v3.core.Jdbi;

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
    public List<Order> getOrdersByUserId(int userId) {
        String query = "SELECT * FROM orders WHERE idUser = :idUser ORDER BY timeOrder DESC";

        return jdbi.withHandle(handle -> handle.createQuery(query)
                .bind("idUser", userId)
                .map((rs, ctx) -> {
                    // Xử lý User
                    User user = new User();
                    user.setId(rs.getInt("idUser"));

                    // Xử lý Voucher
                    Voucher voucher = new Voucher();
                    Integer idVoucher = (Integer) rs.getObject("idVoucher");
                    if (idVoucher != null) {
                        voucher.setIdVoucher(idVoucher);
                    } else {
                        voucher.setIdVoucher(null); // Hoặc để trống nếu không cần
                    }

                    // Xử lý Đơn hàng
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setTimeOrdered(rs.getTimestamp("timeOrder").toLocalDateTime());
                    order.setUser(user);
                    order.setVoucher(voucher);
                    order.setStatus(rs.getString("statusOrder"));
                    order.setTotalPrice(rs.getDouble("totalPrice"));
                    order.setLastPrice(rs.getDouble("lastPrice"));
                    return order;
                }).list());
    }

}



