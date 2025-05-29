package dao;

import connection.DBConnection;
import models.Address;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDateTime;

public class AddressDao {
    Jdbi jdbi;

    public AddressDao() {
        jdbi = DBConnection.getConnetion();
    }

    public boolean updateAddress(int id, String province, String city, String street, String commune) {
        String sql = """
                Update addresses SET province = :province ,city = :city ,street = :street ,commune = :commune
                WHERE id = :id
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", id)
                        .bind("province", province)
                        .bind("city", city)
                        .bind("street", street)
                        .bind("commune", commune)
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

    public boolean addAddress(Address address) {
        String query = "insert into addresses (province, district, ward, detail) values (?,?,?,?)";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, address.getProvince())
                    .bind(1, address.getDistrict())
                    .bind(2, address.getWard())
                    .bind(3, address.getDetail())
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

    public int createAddress(String province, String district, String ward, String detail) {
        String sql = """
                INSERT INTO addresses (province, district, ward, detail)
                VALUES (:province, :district, :ward, :detail)
                """;

        try {
            return jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("province", province)
                            .bind("district", district)
                            .bind("ward", ward)
                            .bind("detail", detail)
                            .executeAndReturnGeneratedKeys("id")
                            .mapTo(int.class)
                            .one()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public Address findAddress(String province, String district, String ward, String detail) {
        String query = "SELECT * FROM addresses\n" +
                "WHERE province = :province AND district = :district AND ward = :ward AND detail = :detail";
        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("province", province)
                        .bind("district", district)
                        .bind("ward", ward)
                        .bind("detail", detail)
                        .mapToBean(Address.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public static void main(String[] args) {
        AddressDao dao = new AddressDao();
        Address address = dao.findAddress("Long Bình", "Đồng Nai", "Biên Hòa", "Yết Kiêu");
        System.out.println(address.toString());
    }
}
