package dao;

import connection.DBConnection;
import org.jdbi.v3.core.Jdbi;

public class InventoryStyleDetailDao {
    Jdbi jdbi;
    public InventoryStyleDetailDao() {
        jdbi = DBConnection.getConnetion();
    }

    public boolean createInventoryInStyleDetail(int idinventoryDetail, int idStyle, int imported) {
        int result = jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO inventory_style_detail (idInventoryDetail, idStyle, imported) " +
                                "VALUES (:idInventoryDetail, :idStyle, :imported)")
                        .bind("idInventoryDetail", idinventoryDetail)
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


}
