package dao;

import connection.DBConnection;
import models.User;
import org.jdbi.v3.core.Jdbi;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;



public class UserDao {
    private Jdbi jdbi;

    public UserDao(Jdbi jdbi) {
        this.jdbi = jdbi;
    }


    public User findUserById(int id) {
        Jdbi jdbi = DBConnection.getConnetion();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM Users WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }


    public boolean emailExists(String email) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM account_users au JOIN users u ON au.idUser = u.id WHERE u.email = :email")
                        .bind("email", email)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }


    public int insertUser(String email, String fullName, String phoneNumber, int idAddress, String image) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO users (email, fullName, phoneNumber, idAddress, image) VALUES (:email, :fullName, :phoneNumber, :idAddress, :image)")
                        .bind("email", email)
                        .bind("fullName", fullName)
                        .bind("phoneNumber", phoneNumber)
                        .bind("idAddress", idAddress)
                        .bind("image", image)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public void insertAccountUser(int idUser, String username, String password, int role, int locked, int code) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO account_users (idUser, username, password, role, locked, code) VALUES (:idUser, :username, :password, :role, :locked, :code)")
                        .bind("idUser", idUser)
                        .bind("username", username)
                        .bind("password", password)
                        .bind("role", role)
                        .bind("locked", locked)
                        .bind("code", code)
                        .execute()
        );
    }
}


