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

    public boolean createInventory(int idProduct, int idWareHouse, int quantityBefore,
                                   int quantityLoss, int quantityImported, Date importDate) {
        try {
            int quantityTotal = quantityBefore - quantityLoss + quantityImported;

            int rowsAffected = jdbi.withHandle(handle ->
                    handle.createUpdate("""
                    INSERT INTO inventory (
                        idProduct, idWareHouse, quantityBefore,
                        quantityLoss, quantityImported, quantityTotal, importDate
                    ) VALUES (
                        :idProduct, :idWareHouse, :quantityBefore,
                        :quantityLoss, :quantityImported, :quantityTotal, :importDate
                    )
                """)
                            .bind("idProduct", idProduct)
                            .bind("idWareHouse", idWareHouse)
                            .bind("quantityBefore", quantityBefore)
                            .bind("quantityLoss", quantityLoss)
                            .bind("quantityImported", quantityImported)
                            .bind("quantityTotal", quantityTotal)
                            .bind("importDate", importDate)
                            .execute()
            );

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<InventoryDetail> getInventoryByProductId(int idProduct) {
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
    public List<InventoryDetail> getInventoryByWareHouseId(int idWareHouse) {
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
