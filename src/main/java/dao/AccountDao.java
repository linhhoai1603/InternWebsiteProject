package dao;

import connection.DBConnection;
import models.AccountUser;
import org.jdbi.v3.core.Jdbi;

public class AccountDao {
    public AccountUser findByUsername(String username) {
        Jdbi jdbi = DBConnection.getConnetion();

        return jdbi.withHandle(handle ->
            handle.createQuery("select * from account_user where username = :username")
                    .bind("username", username)
                    .mapToBean(AccountUser.class)
                    .findOne().orElse(null)

        );
    }
}
