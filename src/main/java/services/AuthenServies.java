package services;

import dao.AccountDao;
import dao.UserDao;
import models.AccountUser;
import models.User;

public class AuthenServies {
    public User checkLogin(String username, String password) {
        AcountServies accDao = new AcountServies();
        AccountUser acc = accDao.findByUsername(username);
        User user = null;
        if (acc == null) return null;
        if (acc!=null && password!=null
                && acc.getPassword().equals(password)) {
            user = acc.getUser();
        }
        return user;
    }
}
