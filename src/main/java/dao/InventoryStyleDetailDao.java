package dao;

import connection.DBConnection;
import org.jdbi.v3.core.Jdbi;

public class InventoryStyleDetailDao {
    Jdbi jdbi;
    public InventoryStyleDetailDao() {
        jdbi = DBConnection.getConnetion();
    }

    public boolean createInventoryInStyleDetail(int idinventoryDetail, int styleId, int quantity) {
        int result = jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO inventory_style_detail (idInventoryDetail, idStyle, stockQuantity, actualQuantity) " +
                                "VALUES (:idInventoryDetail, :idStyle, :stockQuantity, :actualQuantity)")
                        .bind("idInventoryDetail", idinventoryDetail)
                        .bind("idStyle", styleId)
                        .bind("stockQuantity", 0)
                        .bind("actualQuantity", quantity)
                        .execute()
        );
        return result > 0;
    }
    public boolean create(int idInventoryDetail, int idStyle, int stockQuantity, int actualQuantity) {
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


}
