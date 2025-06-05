package dao;

import connection.DBConnection;
import models.InventoryStyleDetail;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class InventoryStyleDetailDao {
    Jdbi jdbi;
    public InventoryStyleDetailDao() {
        jdbi = DBConnection.getConnetion();
    }

    public boolean createInventoryInStyleDetail(int idInventoryDetail, int idStyle, int imported) {
        int result = jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO inventory_style_detail (idInventoryDetail, idStyle, imported) " +
                                "VALUES (:idInventoryDetail, :idStyle, :imported)")
                        .bind("idInventoryDetail", idInventoryDetail)
                        .bind("idStyle", idStyle)
                        .bind("imported", imported)
                        .execute()
        );
        return result > 0;
    }
    public boolean createInventoryStyleDetail(int idInventoryDetail, int idStyle, int stockQuantity, int actualQuantity) {
        int result = jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO inventory_style_detail (idInventoryDetail, idStyle, stockQuantity, actualQuantity) " +
                                "VALUES (:idInventoryDetail, :idStyle, :stockQuantity, :actualQuantity)")
                        .bind("idInventoryDetail", idInventoryDetail)
                        .bind("idStyle", idStyle)
                        .bind("stockQuantity", stockQuantity)
                        .bind("actualQuantity", actualQuantity)
                        .execute()
        );
        return result > 0;
    }
    public InventoryStyleDetail getById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM inventorydetail WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(InventoryStyleDetail.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public List<InventoryStyleDetail> getByIdInventoryDetail(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM inventorystyledetail WHERE idInventoryDetail = :id")
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            InventoryStyleDetail detail = new InventoryStyleDetail();
                            detail.setId(rs.getInt("id"));
                            detail.setIdInventoryDetail(rs.getInt("idInventoryDetail"));
                            detail.setActualQuantity(rs.getInt("actualQuantity"));
                            detail.setStockQuantity(rs.getInt("stockQuantity"));
                            detail.setQuantityImported(rs.getInt("imported"));
                            detail.setDiscrepancy(rs.getInt("discrepancy"));
                            return detail;
                        })
                        .list()
        );
    }

}
