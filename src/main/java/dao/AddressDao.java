package dao;

import connection.DBConnection;
import models.Address;
import org.jdbi.v3.core.Jdbi;

public class AddressDao {
    Jdbi jdbi;
    public AddressDao() {
        jdbi = DBConnection.getConnetion();
    }
    public boolean updateAddress(int id , String province , String city , String street , String commune) {
        String sql = """
                Update address SET province = ? ,city = ? ,street = ? ,commune = ?
                WHERE id = ?
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(4, id)
                        .bind(0,province )
                        .bind(1, city)
                        .bind(2, street)
                        .bind(3,commune)
                        .execute() > 0
        );
    }

}
