package services;

import dao.AccountDao;
import models.AccountUser;

public class AcountServies {
    AccountDao accountDao ;
    public AcountServies() {
        accountDao = new AccountDao();
    }
    public AccountUser findByUsername (String username, String password) {
        AccountUser acc = accountDao.findByUsername(username, password);
        if(acc == null) {
            return null;
        }
        return acc;
    }

}
