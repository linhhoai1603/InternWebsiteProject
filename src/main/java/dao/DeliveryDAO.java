package dao;

import connection.DBConnection;
import models.Delivery;
import org.jdbi.v3.core.Jdbi;

public class DeliveryDAO {
    Jdbi jdbi;
    public DeliveryDAO(){this.jdbi = DBConnection.getConnetion();
    }
    public boolean insertDelivery(Delivery delivery){
        String query = "insert into deliveries values (?,?,?,?,?,?,?,?,?)";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(1, delivery.getIdOrder())
                    .bind(2, delivery.getIdAddress())
                    .bind(3, delivery.getFullName())
                    .bind(4, delivery.getPhoneNumber())
                    .bind(5, delivery.getArea())
                    .bind(6, delivery.getDeliveryFee())
                    .bind(7, delivery.getNote())
                    .bind(8, delivery.getStatus())
                    .bind(9, delivery.getScheduledDateTime())
                    .execute() > 0;
        });
    }
}
