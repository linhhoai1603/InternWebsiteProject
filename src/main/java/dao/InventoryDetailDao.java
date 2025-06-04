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

    public static void main(String[] args) {
        System.out.println(new InventoryDetailDao().createInventoryInDetail(1, 185, 10));
    }

}
