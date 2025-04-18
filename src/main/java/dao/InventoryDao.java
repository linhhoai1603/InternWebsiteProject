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


    public int createInventory(String description, String status) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO inventory (decription, status) VALUES (:description, :status)")
                        .bind("description", description)
                        .bind("status", status)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one()
        );
    }


}
