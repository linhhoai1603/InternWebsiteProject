package dao;

import connection.DBConnection;
import models.Inventory;
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


    public List<Inventory> getInventoryByType(int type) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM inventory WHERE type = :type")
                        .bind("type", type)
                        .map((rs, ctx) -> {
                            Inventory inventory = new Inventory();
                            inventory.setId(rs.getInt("id"));
                            inventory.setType(rs.getInt("type"));
                            inventory.setCreatDate(rs.getTimestamp("creatDate"));
                            inventory.setCode(rs.getString("code"));
                            inventory.setStatus(rs.getString("status"));
                            inventory.setDescription(rs.getString("decription"));
                            return inventory;
                        })
                        .list()
        );
    }

    public static void main(String[] args) {
        InventoryDao inventoryDao = new InventoryDao();
        System.out.println(inventoryDao.getById(1));
    }

    public Inventory getById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM inventory WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Inventory.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public boolean updateStatus(int id) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE inventory SET status = :status WHERE id = :id")
                        .bind("id", id)
                        .bind("status", "Đã chấp nhận")
                        .execute() > 0);
    }
}
