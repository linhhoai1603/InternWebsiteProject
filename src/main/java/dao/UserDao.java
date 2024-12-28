package dao;

import connection.DBConnection;
import models.User;
import org.jdbi.v3.core.Jdbi;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserDao {
    Jdbi jdbi;
    public UserDao() {
        jdbi = DBConnection.getConnetion();
    }
    public User findUserById(int id) {

        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM Users WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public boolean updateInfo(int id ,String email, String name, String phone) {
        String sql = """
                UPDATE users SET email = :email, fullName = :name, phoneNumber = :phone
                WHERE id = :id
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", id)
                        .bind("fullName", name)
                        .bind("email", email)
                        .bind("phoneNumber", phone)
                        .execute() > 0
        );
    }


}
