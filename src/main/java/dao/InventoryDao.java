package dao;

import connection.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.security.Timestamp;
import java.util.List;

public class InventoryDao {
    Jdbi jdbi;
    public InventoryDao() {
        jdbi = DBConnection.getConnetion();
    }

    public int createInventory(int type, String description, String status) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO inventory (type,decription, status) VALUES (:type,:decription, :status)")
                        .bind("type",type)
                        .bind("decription", description)
                        .bind("status", status)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one()
        );
    }


}
