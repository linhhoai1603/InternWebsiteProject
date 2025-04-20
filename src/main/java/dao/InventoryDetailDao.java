package dao;

import connection.DBConnection;
import models.InventoryDetail;
import org.jdbi.v3.core.Jdbi;

import java.sql.Date;
import java.util.List;

public class InventoryDetailDao {
    Jdbi jdbi;
    public InventoryDetailDao() {
        jdbi = DBConnection.getConnetion();
    }
    public boolean updateQuantityActualAndLoss(int idInventoryDetail, int before, int total) {
        int loss = before - total;

        int result = jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE inventorydetail SET quantityImported = :total, quantityLoss = :loss WHERE id = :id")
                        .bind("total", total)
                        .bind("loss", loss)
                        .bind("id", idInventoryDetail)
                        .execute()
        );

        return result > 0;
    }
    public int createInventory(int idInventory, int idProduct, int quantityBefore, int quantityImported, int quantityLoss) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO inventorydetail (idInventory, idProduct, quantityBefore, quantityImported, quantityLoss, importDate) " +
                                "VALUES (:idInventory, :idProduct, :quantityBefore, :quantityImported, :quantityLoss, CURRENT_DATE)")
                        .bind("idInventory", idInventory)
                        .bind("idProduct", idProduct)
                        .bind("quantityBefore", quantityBefore)
                        .bind("quantityImported", quantityImported)
                        .bind("quantityLoss", quantityLoss)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one()
        );
    }

    public List<InventoryDetail> getInventoryDetailByProductId(int idProduct) {
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery("SELECT * FROM inventory WHERE idProduct = :idProduct")
                            .bind("idProduct", idProduct)
                            .map((rs, ctx) -> new InventoryDetail(
                                    rs.getInt("id"),
                                    rs.getInt("idProduct"),
                                    rs.getInt("idWareHouse"),
                                    rs.getInt("quantityBefore"),
                                    rs.getInt("quantityLoss"),
                                    rs.getInt("quantityImported"),
                                    rs.getInt("quantityTotal"),
                                    rs.getDate("importDate")
                            ))
                            .list()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return List.of(); // Trả về danh sách rỗng nếu có lỗi
        }
    }
    public List<InventoryDetail> getInventoryDetailByInventory(int idWareHouse) {
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery("SELECT * FROM inventory WHERE idWareHouse = :idWareHouse")
                            .bind("idWareHouse", idWareHouse)
                            .map((rs, ctx) -> new InventoryDetail(
                                    rs.getInt("id"),
                                    rs.getInt("idProduct"),
                                    rs.getInt("idWareHouse"),
                                    rs.getInt("quantityBefore"),
                                    rs.getInt("quantityLoss"),
                                    rs.getInt("quantityImported"),
                                    rs.getInt("quantityTotal"),
                                    rs.getDate("importDate")
                            ))
                            .list()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return List.of(); // Trả về danh sách rỗng nếu có lỗi
        }
    }
    public InventoryDetail getInventoryById(int id) {
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery("SELECT * FROM inventory WHERE id = :id")
                            .bind("id", id)
                            .map((rs, ctx) -> new InventoryDetail(
                                    rs.getInt("id"),
                                    rs.getInt("idProduct"),
                                    rs.getInt("idWareHouse"),
                                    rs.getInt("quantityBefore"),
                                    rs.getInt("quantityLoss"),
                                    rs.getInt("quantityImported"),
                                    rs.getInt("quantityTotal"),
                                    rs.getDate("importDate")
                            ))
                            .findOne()
                            .orElse(null)
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public List<InventoryDetail> getInventoryByProductIdAndDateRange(int idProduct, Date startDate, Date endDate) {
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery("""
                SELECT * FROM inventory 
                WHERE idProduct = :idProduct 
                  AND importDate BETWEEN :startDate AND :endDate
            """)
                            .bind("idProduct", idProduct)
                            .bind("startDate", startDate)
                            .bind("endDate", endDate)
                            .map((rs, ctx) -> new InventoryDetail(
                                    rs.getInt("id"),
                                    rs.getInt("idProduct"),
                                    rs.getInt("idWareHouse"),
                                    rs.getInt("quantityBefore"),
                                    rs.getInt("quantityLoss"),
                                    rs.getInt("quantityImported"),
                                    rs.getInt("quantityTotal"),
                                    rs.getDate("importDate")
                            ))
                            .list()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return List.of(); // Trả về danh sách rỗng nếu có lỗi
        }
    }


}
