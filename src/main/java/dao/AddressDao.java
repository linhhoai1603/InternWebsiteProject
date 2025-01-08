package dao;

import connection.DBConnection;
import models.Address;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

public class AddressDao {
    Jdbi jdbi;
    Handle handle;
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
        String query = "insert into address values (?,?,?,?)";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(1, address.getCity())
                    .bind(2, address.getProvince())
                    .bind(3, address.getCommune())
                    .bind(4, address.getStreet())
                    .execute() > 0;
        });
    }

    public static void main(String[] args) {
        AddressDao dao = new AddressDao();
//        System.out.println(dao.updateAddress(1,"Đồng Nai","Biên Hòa","Yêết Kiu","Lonng Bình"));
        System.out.println(dao.getAddressByID(3));
    }

    public int getLastId() {
        String query = "select max(id) from addresses";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .mapTo(Integer.class)
                    .one();
        });
    }

}
