package dao;

import connection.DBConnection;
import models.WareHouse;
import org.jdbi.v3.core.Jdbi;

import java.security.Timestamp;
import java.util.List;

public class WareHouseDao {
    Jdbi jdbi;
    public WareHouseDao() {
        jdbi = DBConnection.getConnetion();
    }
    public boolean createWareHouse() {
        try {
            jdbi.useHandle(handle -> {
                handle.execute("""
                    CREATE TABLE IF NOT EXISTS warehouse (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        import_date TIMESTAMP,
                        updatedAt TIMESTAMP
                    )
                """);
            });
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public WareHouse findById(int id) {
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery("SELECT * FROM warehouse WHERE id = :id")
                            .bind("id", id)
                            .map((rs, ctx) -> new WareHouse(
                                    rs.getInt("id"),
                                    rs.getTimestamp("import_date"),
                                    rs.getTimestamp("updatedAt")
                            ))
                            .findOne()
                            .orElse(null) // Trả về null nếu không tìm thấy
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public List<Integer> getWareHouseIdsByImportDateRange(Timestamp start, Timestamp end) {
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery("""
                SELECT id FROM warehouse 
                WHERE import_date BETWEEN :start AND :end
            """)
                            .bind("start", start)
                            .bind("end", end)
                            .mapTo(Integer.class)
                            .list()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return List.of(); // Trả về danh sách rỗng nếu có lỗi
        }
    }

}
