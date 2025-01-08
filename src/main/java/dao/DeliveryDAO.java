package dao;

import connection.DBConnection;
import models.Delivery;
import org.jdbi.v3.core.Jdbi;

public class DeliveryDAO {
    Jdbi jdbi;
    public DeliveryDAO(){this.jdbi = DBConnection.getConnetion();
    }
    public boolean insertDelivery(Delivery delivery){
        String query = "insert into deliveries (idOrder, idAddress, fullName, phoneNumber, area, deliveryFee, note, status, scheduledDateTime) values (?,?,?,?,?,?,?,?,?)";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, delivery.getIdOrder())
                    .bind(1, delivery.getIdAddress())
                    .bind(2, delivery.getFullName())
                    .bind(3, delivery.getPhoneNumber())
                    .bind(4, delivery.getArea())
                    .bind(5, delivery.getDeliveryFee())
                    .bind(6, delivery.getNote())
                    .bind(7, delivery.getStatus())
                    .bind(8, delivery.getScheduledDateTime())
                    .execute() > 0;
        });
    }
}
