package services;

import models.AccountUser;

public class AuthenServies {
    public AccountUser checkLogin(String username, String password) {
        AccountService accDao = new AccountService();
        AccountUser acc = accDao.findByUsername(username,password);
        if (acc == null) return null;
        return acc;
    }
}
