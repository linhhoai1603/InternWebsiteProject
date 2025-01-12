package dao;

import connection.DBConnection;
import models.Address;
import models.Delivery;
import models.Order;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

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
    public List<Delivery> getAllDeliveries() {
        String query = """
        SELECT * FROM deliveries
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .map((rs, ctx) -> {
                            // xu ly cho address
                            Address address = new Address();
                            address.setId(rs.getInt("idAddress"));

                            // Map the Delivery object
                            Delivery delivery = new Delivery();
                            delivery.setId(rs.getInt("id"));
                            delivery.setIdAddress(rs.getInt("idAddress"));
                            delivery.setIdOrder(rs.getInt("idOrder"));
                            delivery.setFullName(rs.getString("fullName"));
                            delivery.setNumberPhone(rs.getString("phoneNumber"));
                            delivery.setArea(rs.getDouble("area"));
                            delivery.setDeliveryFee(rs.getDouble("deliveryFee"));
                            delivery.setNote(rs.getString("note"));
                            delivery.setStatus(rs.getString("status"));
                            delivery.setAddress(address);
                            delivery.setScheduledDateTime(rs.getTimestamp("scheduledDateTime").toLocalDateTime());
                            return delivery;
                        })
                        .list()
        );
    }
    public List<Delivery> getDeliveriesByOrderId(int idOrder) {
        String query = """
        SELECT * FROM deliveries WHERE idOrder = :idOrder
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("idOrder", idOrder) // Bind the idOrder parameter
                        .map((rs, ctx) -> {
                            // Process Address
                            Address address = new Address();
                            address.setId(rs.getInt("idAddress"));

                            // Map the Delivery object
                            Delivery delivery = new Delivery();
                            delivery.setId(rs.getInt("id"));
                            delivery.setIdAddress(rs.getInt("idAddress"));
                            delivery.setIdOrder(rs.getInt("idOrder"));
                            delivery.setFullName(rs.getString("fullName"));
                            delivery.setNumberPhone(rs.getString("phoneNumber"));
                            delivery.setArea(rs.getDouble("area"));
                            delivery.setDeliveryFee(rs.getDouble("deliveryFee"));
                            delivery.setNote(rs.getString("note"));
                            delivery.setStatus(rs.getString("status"));
                            delivery.setAddress(address);
                            delivery.setScheduledDateTime(rs.getTimestamp("scheduledDateTime").toLocalDateTime());
                            return delivery;
                        })
                        .list()
        );
    }


}
