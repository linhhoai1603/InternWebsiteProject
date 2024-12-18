package dao;

import connection.DBConnection;
import models.AccountUser;
import models.User;
import org.jdbi.v3.core.Jdbi;

public class AccountDao {
    public AccountUser findByUsername(String username) {
        Jdbi jdbi = DBConnection.getConnetion();
        UserDao userDao = new UserDao();
        return jdbi.withHandle(handle ->
                handle.createQuery("select * from account_user where username = :username")
                        .bind("username", username)
                        .mapToBean(AccountUser.class)
                        .findOne()
                        .map(accountUser -> {
                            User user = userDao.findUserById(accountUser.getId());
                            accountUser.setUser(user);
                            return accountUser;
                        })
                        .orElse(null)
        );
    }
    public AccountUser findByUserId(int id) {
        Jdbi jdbi = DBConnection.getConnetion();
        return jdbi.withHandle(handle ->
                handle.createQuery("select * from account_users where idUser = :idUser")
                        .bind("idUser", id)
                        .mapToBean(AccountUser.class)
                        .findOne()
                        .orElse(null)
        );
    }


}
