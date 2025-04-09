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

    public AccountUser findByUsername(String username, String password) {
        String sql = """
                SELECT 
                    u.id AS user_id, u.email, u.fullName, u.phoneNumber, u.image,
                    a.id AS address_id, a.province, a.district, a.ward, a.detail, 
                    au.id AS account_user_id, au.username, au.password, au.role, au.locked ,au.code
                FROM 
                    users u 
                JOIN 
                    account_users au ON u.id = au.idUser 
                JOIN 
                    addresses a ON u.idAddress = a.id 
                WHERE 
                    au.username = :username AND au.password = :password
                """;
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind("username", username)
                    .bind("password", password)
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
                        address.setDistrict(rs.getString("district"));
                        address.setWard(rs.getString("ward"));
                        address.setDetail(rs.getString("detail"));
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

    public void updateCode(String username, int code) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("UPDATE account_users SET code = :code WHERE username = :username")
                    .bind("code", code)
                    .bind("username", username)
                    .execute();
        });
    }

    public boolean checkCode(String username, int code) {
        String sql = "SELECT 1 FROM account_users WHERE username = :username AND code = :code LIMIT 1";
        return jdbi.withHandle(handle -> {
            Integer result = handle.createQuery(sql)
                    .bind("username", username)
                    .bind("code", code)
                    .mapTo(Integer.class)
                    .findFirst()
                    .orElse(null);
            return result != null;
        });
    }

    public void resetPassword(String username, String password) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("UPDATE account_users SET password = :password WHERE username = :username")
                    .bind("password", password)
                    .bind("username", username)
                    .execute();
        });
    }

    public boolean checkPass(String userName, String pass) {
        String sql = "SELECT 1 FROM account_users WHERE username = :username AND password = :password";
        return jdbi.withHandle(handle -> {
            Integer result = handle.createQuery(sql)
                    .bind("username", userName)
                    .bind("password", pass)
                    .mapTo(Integer.class)
                    .findFirst()
                    .orElse(null);
            return result != null;
        });
    }
    public boolean deleteAccountUserByIDUser(int id) {
        String sql = "DELETE FROM account_users WHERE idUser = :id";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(sql)
                    .bind("id", id)
                    .execute() > 0;
        });
    }

}