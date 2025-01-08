package services;

import models.AccountUser;
import models.User;

public class AuthenServies {
    public AccountUser checkLogin(String username, String password) {
        AccountService accDao = new AccountService();
        AccountUser acc = accDao.findByUsername(username,password);
        if (acc == null) return null;
        return acc;
    }
}
