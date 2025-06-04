package dao;

import connection.DBConnection;
import models.*;
import models.enums.TokenType;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import services.AddressService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;


public class UserDao {

    private Jdbi jdbi;
    Handle handle;

    public UserDao(Jdbi jdbi) {
        this.jdbi = jdbi;
    }

    public UserDao() {
        this.jdbi = DBConnection.getJdbi();
    }

    public Jdbi getJdbi() {
        return jdbi;
    }

    public User findUserById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE id = :id")
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            User user = new User();
                            user.setId(rs.getInt("id"));
                            user.setEmail(rs.getString("email"));
                            user.setFirstname(rs.getString("firstName"));
                            user.setLastname(rs.getString("lastName"));
                            user.setFullname(rs.getString("fullNameGenerated"));
                            user.setPhoneNumber(rs.getString("phoneNumber"));
                            user.setImage(rs.getString("image"));
                            user.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                            user.setUpdatedAt(rs.getTimestamp("updatedAt").toLocalDateTime());

                            int addressId = rs.getInt("idAddress");
                            if (!rs.wasNull()) {
                                AddressService addressService = new AddressService();
                                Address address = addressService.getAddressById(addressId);
                                user.setAddress(address);
                            }

                            return user;
                        })
                        .findOne()
                        .orElse(null)
        );
    }


    public boolean updateInfo(int id,String email,String firstname, String lastname, String phone) {
        String sql = "UPDATE users SET email = :email,firstName = :firstName, lastName = :lastName, phoneNumber = :phoneNumber " +
                     "WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", id)
                        .bind("email", email)
                        .bind("firstName", firstname)
                        .bind("lastName", lastname)
                        .bind("phoneNumber", phone)
                        .execute() > 0
        );
    }

    public static void main(String[] args) {
        UserDao userDao = new UserDao();
        UserTokens u = new UserTokens();

        User user = userDao.findUserById(1);
        System.out.println(user.getEmail());


    }

    public boolean updateAvatar(int id, String url) {
        String sql = "UPDATE users SET image = :image " +
                     "WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", id)
                        .bind("image", url)
                        .execute() > 0
        );
    }

    public void beginTransaction() {
        handle = jdbi.open();
        handle.begin();
    }


    public void commitTransaction() {
        if (handle != null) {
            handle.commit();
        }
    }

    public void rollbackTransaction() {
        if (handle != null) {
            handle.rollback();
        }
    }

    public void closeTransaction() {
        if (handle != null) {
            handle.close();
            handle = null;
        }
    }

    public boolean isEmailExists(String email) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM users WHERE email = :email")
                        .bind("email", email)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public int insertUser(Handle handle, String email, String firstName, String lastName,
                          String phoneNumber, int idAddress, String image) {
        return handle.createUpdate(
                        "INSERT INTO users (email, firstName, lastName, phoneNumber, idAddress, image) " +
                                "VALUES (:email, :firstName, :lastName, :phoneNumber, :idAddress, :image)"
                )
                .bind("email", email)
                .bind("firstName", firstName)
                .bind("lastName", lastName)
                .bind("phoneNumber", phoneNumber)
                .bind("idAddress", idAddress)
                .bind("image", image)
                .executeAndReturnGeneratedKeys("id")
                .mapTo(Integer.class)
                .one();
    }

    public void insertAccountUser(Handle handle, int userId, String username,
                                  String password, int idRole, int locked, Integer code) {
        handle.createUpdate(
                        "INSERT INTO account_users (idUser, username, password, idRole, locked, code) " +
                                "VALUES (:userId, :username, :password, :idRole, :locked, :code)"
                )
                .bind("userId", userId)
                .bind("username", username)
                .bind("password", password)
                .bind("idRole", idRole)
                .bind("locked", locked)
                .bind("code", code)
                .execute();
    }

    public int createAccount(int userId, String username, String password, int idRole, int locked, Integer code) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO account_users (idUser, username, password, idRole, locked, code) " +
                                "VALUES (:userId, :username, :password, :idRole, :locked, :code)")
                        .bind("userId", userId)
                        .bind("username", username)
                        .bind("password", password)
                        .bind("idRole", idRole)
                        .bind("locked", locked)
                        .bind("code", code)
                        .execute()
        );
    }

    public int createUser(User user) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO users (email, firstName, lastName, phoneNumber, idAddress, image) " +
                                "VALUES (:email, :firstName, :lastName, :phoneNumber, :idAddress, :image)")
                        .bind("email", user.getEmail())
                        .bind("firstName", user.getFirstname())
                        .bind("lastName", user.getLastname())
                        .bind("phoneNumber", user.getPhoneNumber())
                        .bind("idAddress", 1)
                        .bind("image", user.getImage())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public void insertToken(Handle handle, int idUser, String tokenHash, TokenType tokenType, LocalDateTime expiresAt) {
        String sql = "INSERT INTO user_tokens (idUser, tokenHash, tokenType, expiresAt) VALUES (:idUser, :tokenHash, :tokenType, :expiresAt)";
        handle.createUpdate(sql)
                .bind("idUser", idUser)
                .bind("tokenHash", tokenHash)
                .bind("tokenType", tokenType)
                .bind("expiresAt", expiresAt)
                .execute();
    }


    public boolean usernameExists(String username) {
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT COUNT(*) FROM account_users " +
                                        "WHERE username = :username"
                        )
                        .bind("username", username)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public boolean checkHaveEmail(String username, String email) {
        Integer idUser = getIdUserByUsername(username); // Lấy idUser dựa trên username
        if (idUser == null) {
            return false; // Trả về false nếu username không tồn tại
        }
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT COUNT(*) FROM users " +
                                        "WHERE id = :idUser AND email = :email"
                        )
                        .bind("idUser", idUser)
                        .bind("email", email)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public Integer getIdUserByUsername(String username) {
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT idUser FROM account_users " +
                                        "WHERE username = :username"
                        )
                        .bind("username", username)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElseThrow(() -> new NoSuchElementException("User not found: " + username))
        );
    }

    public List<AccountUser> getAllUser() {
        String query = "SELECT u.id AS userId, u.email, u.fullNameGenerated, u.phoneNumber, " +
                "a.id AS addressId, a.province, a.district, a.ward, a.detail, " +
                "COUNT(o.id) AS orderCount, SUM(o.lastPrice) AS totalSpent, acc.locked " +
                "FROM users u " +
                "JOIN addresses a ON u.idAddress = a.id " +
                "JOIN account_users acc ON u.id = acc.idUser " +
                "LEFT JOIN orders o ON u.id = o.idUser " +
                "GROUP BY u.id, a.id, acc.locked";

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .map((rs, ctx) -> {
                            // Tạo đối tượng User
                            User user = new User();
                            user.setId(rs.getInt("userId"));
                            user.setEmail(rs.getString("email"));
                            user.setFullname(rs.getString("fullNameGenerated"));
                            user.setPhoneNumber(rs.getString("phoneNumber"));

                            // Tạo đối tượng Address
                            Address address = new Address();
                            address.setId(rs.getInt("addressId"));
                            address.setProvince(rs.getString("province"));
                            address.setDistrict(rs.getString("district"));
                            address.setWard(rs.getString("ward"));
                            address.setDetail(rs.getString("detail"));

                            // Gán Address vào User
                            user.setAddress(address);

                            // Tạo đối tượng AccountUser
                            AccountUser accountUser = new AccountUser();
                            accountUser.setLocked(rs.getInt("locked"));
                            accountUser.setUser(user);

                            // Gán số lượng đơn hàng và tổng tiền đã chi vào User
                            user.setOrderCount(rs.getInt("orderCount"));
                            user.setTotalSpent(rs.getDouble("totalSpent"));

                            return accountUser;
                        })
                        .list()
        );
    }

    public boolean lockUser(int id) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE account_users SET locked = 1 WHERE idUser = :id")
                        .bind("id", id)
                        .execute() > 0
        );
    }

    public boolean unlockUser(int id) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE account_users SET locked = 0 WHERE idUser = :id")
                        .bind("id", id)
                        .execute() > 0
        );
    }

    public List<AccountUser> findUserByName(String name) {
        String query = "SELECT u.id AS userId, u.email, u.fullName, u.phoneNumber, " +
                "a.id AS addressId, a.province, a.district, a.ward, a.detail, " +
                "COUNT(o.id) AS orderCount, SUM(o.lastPrice) AS totalSpent, acc.locked " +
                "FROM users u " +
                "JOIN addresses a ON u.idAddress = a.id " +
                "JOIN account_users acc ON u.id = acc.idUser " +
                "LEFT JOIN orders o ON u.id = o.idUser " +
                "WHERE u.fullName LIKE :name " +
                "GROUP BY u.id, a.id";

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("name", "%" + name + "%")
                        .map((rs, ctx) -> {
                            // Tạo đối tượng User
                            User user = new User();
                            user.setId(rs.getInt("userId"));
                            user.setEmail(rs.getString("email"));
                            user.setFullname(rs.getString("fullName"));
                            user.setPhoneNumber(rs.getString("phoneNumber"));

                            // Tạo đối tượng Address
                            Address address = new Address();
                            address.setId(rs.getInt("addressId"));
                            address.setProvince(rs.getString("province"));
                            address.setDistrict(rs.getString("district"));
                            address.setWard(rs.getString("ward"));
                            address.setDetail(rs.getString("detail"));

                            // Gán Address vào User
                            user.setAddress(address);

                            // Tạo đối tượng AccountUser
                            AccountUser accountUser = new AccountUser();
                            accountUser.setLocked(rs.getInt("locked"));
                            accountUser.setUser(user);

                            // Gán số lượng đơn hàng và tổng tiền đã chi vào User
                            user.setOrderCount(rs.getInt("orderCount"));
                            user.setTotalSpent(rs.getDouble("totalSpent"));

                            return accountUser;
                        })
                        .list()
        );
    }


    // Tìm token bằng hash của nó
    public Optional<UserTokens> findTokenByHash(String tokenHash) {
        String sql = "SELECT id, idUser, tokenHash, tokenType, expiresAt, createdAt FROM user_tokens WHERE tokenHash = :tokenHash";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("tokenHash", tokenHash)
                        // mapToBean sẽ tự động chuyển đổi chuỗi từ DB thành TokenType enum
                        .mapToBean(UserTokens.class)
                        .findFirst()
        );
    }

    public Optional<User> findByEmail(String email) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE email = :email")
                        .bind("email", email)
                        .mapToBean(User.class)
                        .findFirst()
        );
    }

    // Xóa token (không thay đổi)
    public void deleteToken(String tokenHash) {
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM user_tokens WHERE tokenHash = :tokenHash")
                        .bind("tokenHash", tokenHash)
                        .execute()
        );
    }

    public boolean updateUserAddressId(int userId, int addressId) {
        String sql = """
                UPDATE users
                SET
                    idAddress = :idAddress,
                    updatedAt = :updatedAt
                WHERE
                    id = :userId
                """;

        try {
            return jdbi.withHandle(handle -> {
                int rowsAffected = handle.createUpdate(sql)
                        .bind("userId", userId)
                        .bind("idAddress", addressId)
                        .bind("updatedAt", LocalDateTime.now()) // Cập nhật thời gian sửa đổi
                        .execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            // Log lỗi ở đây nếu cần thiết
            // System.err.println("Error updating user's address ID: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}


