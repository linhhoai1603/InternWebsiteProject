package services;

import models.AccountUser;
import models.User;
import services.application.HashUtil;

public class AuthenServies {
    public AccountUser checkLogin(String username, String hashedPassword) {
        AccountService accDao = new AccountService();
        AccountUser acc = accDao.findByUsername(username,hashedPassword);
        if (acc == null) return null;
        return acc;
    }

    public static void main(String[] args) {
//        AuthenServies authen = new AuthenServies();
//
//        AccountUser acc = new AccountUser();
//        acc = authen.checkLogin("huy1111", HashUtil.encodePasswordBase64("Anhhuy1801*"));
//        System.out.println(acc.getUsername());
        System.out.println(HashUtil.encodePasswordBase64("Anhhuy1801*"));

    }
}
