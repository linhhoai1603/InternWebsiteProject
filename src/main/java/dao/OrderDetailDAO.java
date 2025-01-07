package dao;

import connection.DBConnection;
import models.Order;
import models.OrderDetail;
import org.jdbi.v3.core.Jdbi;

public class OrderDetailDAO {
    Jdbi jdbi;
    public OrderDetailDAO(){ this.jdbi = DBConnection.getConnetion();
    }
    public boolean insertOrderDetail(OrderDetail detail){
        String query = "insert into order_details values (?,?,?,?,?,?)";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(1, detail.getId())
                    .bind(2, detail.getIdOrder())
                    .bind(3, detail.getStyle().getId())
                    .bind(4, detail.getQuantity())
                    .bind(5, detail.getTotalPrice())
                    .bind(6, detail.getWeight())
                    .execute() > 0;
        });
    }
}
