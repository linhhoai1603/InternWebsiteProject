package services;

import dao.AccountDao;
import dao.UserDao;
import models.AccountUser;

public class AuthenServies {
    public boolean checkLoogin(String username, String password) {
        AccountDao accDao = new AccountDao();
        AccountUser acc = accDao.findByUsername(username);
        if (acc == null) return false;
        return password.equals(acc.getPassword());
    }
}
