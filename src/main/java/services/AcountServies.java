package services;

import dao.AccountDao;
import models.AccountUser;

public class AcountServies {
    AccountDao accountDao ;
    public AcountServies() {
        accountDao = new AccountDao();
    }
    public AccountUser findByUsername (String username) {
        return accountDao.findByUsername(username);
    }

}
