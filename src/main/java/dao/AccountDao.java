package dao;

import connection.DBConnection;
import models.AccountUser;
import models.Address;
import models.User;
import org.jdbi.v3.core.Jdbi;
import services.application.HashUtil;

public class AccountDao {
    Jdbi jdbi;

    public AccountDao() {
        this.jdbi = DBConnection.getConnetion();
    }

    public AccountUser findByUsername(String username, String password) {
        String sql = """
                SELECT 
                    u.id AS user_id, u.email, u.firstName, u.lastName, u.fullNameGenerated,
                    u.phoneNumber, u.image, u.createdAt AS user_createdAt, u.updatedAt AS user_updatedAt,
                    a.id AS address_id, a.province, a.city, a.commune, a.street,
                    au.id AS account_user_id, au.username, au.password, au.idRole AS role_id, au.locked ,au.code
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
                        user.setFirstname(rs.getString("firstName"));
                        user.setLastname(rs.getString("lastName"));
                        user.setFullName(rs.getString("fullNameGenerated"));
                        user.setNumberPhone(rs.getString("phoneNumber"));
                        user.setImage(rs.getString("image"));

                        // Ánh xạ thông tin từ bảng address
                        int addressId = rs.getInt("address_id");

                        if (!rs.wasNull()) {
                            Address address = new Address();
                            address.setId(addressId);
                            address.setProvince(rs.getString("province"));
                            address.setCity(rs.getString("city"));
                            address.setCommune(rs.getString("commune"));
                            address.setStreet(rs.getString("street"));
                            user.setAddress(address);
                        } else {
                            user.setAddress(null); // Không tìm thấy địa chỉ khớp
                        }

                        // Ánh xạ thông tin từ bảng account_users
                        AccountUser accountUser = new AccountUser();
                        accountUser.setId(rs.getInt("account_user_id"));
                        accountUser.setUsername(rs.getString("username"));
                        accountUser.setPassword(rs.getString("password"));
                        accountUser.setRole(rs.getInt("role_id"));
                        accountUser.setLocked(rs.getInt("locked"));
                        accountUser.setCode(rs.getString("code")); // nếu lỗi code sửa ở đây
                        accountUser.setUser(user);
                        return accountUser;
                    })
                    .findOne()
                    .orElse(null);
        });
    }

    public static void main(String[] args) {

        AccountDao accDao = new AccountDao();
        System.out.println(accDao.updateCodeByEmail("ttahuy1801@gmail.com", "0"));
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

    public boolean updateCodeByEmail(String email, String code) {
        String sql = "UPDATE account_users AS au " +
                "JOIN users AS u ON au.idUser = u.id " +
                "SET au.code = :code " +
                "WHERE u.email = :email";

        return jdbi.withHandle(handle -> {
            int rowsAffected = handle.createUpdate(sql)
                    .bind("code", code)
                    .bind("email", email)
                    .execute();
            return rowsAffected > 0;
        });
    }

    public boolean resetPasswordByEmail(String email, String password) {
        String sql = "UPDATE account_users AS au " +
                "JOIN users AS u ON au.idUser = u.id " +
                "SET au.password = :password " +
                "WHERE u.email = :email";

        return jdbi.withHandle(handle -> {
            int rowsAffected = handle.createUpdate(sql)
                    .bind("password", password)
                    .bind("email", email)
                    .execute();
            return rowsAffected > 0;
        });
    }
}