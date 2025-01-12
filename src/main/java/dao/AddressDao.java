package dao;

import connection.DBConnection;
import models.Address;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

public class AddressDao {
    Jdbi jdbi;
    public AddressDao() {
        jdbi = DBConnection.getConnetion();
    }
    public boolean updateAddress(int id , String province , String city , String street , String commune) {
        String sql = """
                Update addresses SET province = :province ,city = :city ,street = :street ,commune = :commune
                WHERE id = :id
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", id)
                        .bind("province",province )
                        .bind("city", city)
                        .bind("street", street)
                        .bind("commune",commune)
                        .execute() > 0
        );
    }
    public Address getAddressByID(int id) {
        String query = "SELECT * FROM addresses WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("id", id)  // Bind parameter by name
                        .mapToBean(Address.class)
                        .findOne()
                        .orElse(null)    // Return null if not found
        );
    }
    public boolean addAddress(Address address){
        String query = "insert into addresses (city, province, commune, street) values (?,?,?,?)";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, address.getCity())
                    .bind(1, address.getProvince())
                    .bind(2, address.getCommune())
                    .bind(3, address.getStreet())
                    .execute() > 0;
        });
    }

    public int getLastId() {
        String query = "select max(id) from addresses";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .mapTo(Integer.class)
                    .one();
        });
    }
    public boolean deleteAddress(int id) {
        String query = "delete from addresses where id = :id";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind("id", id)
                    .execute() > 0;
        });
    }

}
