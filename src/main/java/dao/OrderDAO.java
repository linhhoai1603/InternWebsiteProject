package dao;

import connection.DBConnection;
import models.Order;
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
    public ArrayList<Order> getAllOrders() {
        String query = "SELECT * FROM orders";
        return jdbi.withHandle(handle ->
                new ArrayList<>(handle.createQuery(query)
                        .mapTo(Order.class)
                        .list())
        );
    }


}
