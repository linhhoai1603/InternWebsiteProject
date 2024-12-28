package dao;

import connection.DBConnection;
import models.User;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserDao {
    Jdbi jdbi;
    private Handle handle;
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
                        .bind("name", name)
                        .bind("email", email)
                        .bind("phone", phone)
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

    public static void main(String[] args) {
        UserDao dao = new UserDao();
        System.out.println(dao.updateInfo(1,"hung@gmail.com","Lê Đình Hưng","0330099958"));
    }
}
