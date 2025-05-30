package dao;

import connection.DBConnection;
import models.Payment;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

public class PaymentDAO {
    Jdbi jdbi;

    public PaymentDAO() {
        jdbi = DBConnection.getConnetion();
    }

    public int insertPayment(Payment payment) {
        String sql = "INSERT INTO payments (idOrder, method, status, time, price, vnpTxnRef) " +
                "VALUES (:idOrder, :method, :status, :time, :price, :vnpTxnRef)";
        try (Handle handle = jdbi.open()) {
            return handle.createUpdate(sql)
                    .bindBean(payment)
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();
        }
    }
}
