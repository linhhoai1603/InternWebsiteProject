package dao;

import connection.DBConnection;
import models.InventoryDetail;
import org.jdbi.v3.core.Jdbi;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

public class InventoryDetailDao {
    Jdbi jdbi;
    public InventoryDetailDao() {
        jdbi = DBConnection.getConnetion();
    }
    public int createInventoryInDetail(int idInventory, int idProduct, int totalImport) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO inventorydetail (idProduct, idInventory, quantityBefore, quantityLoss, quantityImported) " +
                                "VALUES (:idProduct, :idInventory, :quantityBefore, :quantityLoss, :quantityImported)")
                        .bind("idProduct", idProduct)
                        .bind("idInventory", idInventory)
                        .bind("quantityBefore", 0)
                        .bind("quantityLoss", 0)
                        .bind("quantityImported", totalImport)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one()
        );
    }

    public int createInventoryDetail(int idProduct, int idInventory, int quantityBefore, int quantityLoss) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO inventorydetail (idProduct, idInventory, quantityBefore, quantityLoss, quantityImported, importDate) " +
                                "VALUES (:idProduct, :idInventory, :quantityBefore, :quantityLoss, :quantityImported, :importDate)")
                        .bind("idProduct", idProduct)
                        .bind("idInventory", idInventory)
                        .bind("quantityBefore", quantityBefore)
                        .bind("quantityLoss", quantityLoss)
                        .bind("quantityImported", 0)
                        .bind("importDate", LocalDate.now())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one()
        );
    }
    public InventoryDetail getById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM inventorydetail WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(InventoryDetail.class)
                        .findOne()
                        .orElse(null)
        );
    }


    public List<InventoryDetail> getByIdInventory(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM inventorydetail WHERE idInventory = :id")
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            InventoryDetail detail = new InventoryDetail();
                            detail.setId(rs.getInt("id"));
                            detail.setIdProduct(rs.getInt("idProduct"));
                            detail.setQuantityBefore(rs.getInt("quantityBefore"));
                            detail.setQuantityLoss(rs.getInt("quantityLoss"));
                            detail.setQuantityImported(rs.getInt("quantityImported"));
                            detail.setQuantityTotal(rs.getInt("quantityTotal"));
                            detail.setImportDate(rs.getDate("importDate"));
                            return detail;
                        })
                        .list()
        );
    }

}
