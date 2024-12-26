package services;

import dao.AccountDao;
import dao.UserDao;
import models.AccountUser;
import models.User;

public class AuthenServies {
    public AccountUser checkLogin(String username, String password) {
        AcountServies accDao = new AcountServies();
        AccountUser acc = accDao.findByUsername(username);

        if (acc == null) return null;
        if (acc!=null && password!=null
                && acc.getPassword().equals(password)) {
            return acc;
        }
        return null;
    }
}
