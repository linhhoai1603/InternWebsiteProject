package dao;

import connection.DBConnection;
import models.AccountUser;
import models.Address;
import models.User;
import org.jdbi.v3.core.Jdbi;

public class AccountDao {
    Jdbi jdbi;
    public AccountDao() {
        this.jdbi = DBConnection.getConnetion();
    }
    public AccountUser findByUsername(String username) {
        String sql = """
                        SELECT 
                            u.id AS user_id, u.email, u.fullName, u.phoneNumber, u.image,
                            a.id AS address_id, a.province, a.city, a.commune, a.street, 
                            au.id AS account_user_id, au.username, au.password, au.role, au.locked ,au.code
                        FROM 
                            users u 
                        JOIN 
                            account_users au ON u.id = au.idUser 
                        JOIN 
                            addresses a ON u.idAddress = a.id 
                        WHERE 
                            au.username = :username
                            """;
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind("username", username)
                    .map((rs, ctx) -> {
                        // Ánh xạ thông tin từ bảng users
                        User user = new User();
                        user.setId(rs.getInt("user_id"));
                        user.setEmail(rs.getString("email"));
                        user.setFullName(rs.getString("fullName"));
                        user.setNumberPhone(rs.getString("phoneNumber"));
                        user.setImage(rs.getString("image"));

                        // Ánh xạ thông tin từ bảng address
                        Address address = new Address();
                        address.setId(rs.getInt("address_id"));
                        address.setProvince(rs.getString("province"));
                        address.setCity(rs.getString("city"));
                        address.setCommune(rs.getString("commune"));
                        address.setStreet(rs.getString("street"));
                        user.setAddress(address);

                        // Ánh xạ thông tin từ bảng account_users
                        AccountUser accountUser = new AccountUser();
                        accountUser.setId(rs.getInt("account_user_id"));
                        accountUser.setUsername(rs.getString("username"));
                        accountUser.setPassword(rs.getString("password"));
                        accountUser.setRole(rs.getInt("role"));
                        accountUser.setLocked(rs.getInt("locked"));
                        accountUser.setCode(rs.getInt("code"));

                        accountUser.setUser(user);

                        return accountUser;
                    })
                    .findOne()
                    .orElse(null);
        });
    }

}
