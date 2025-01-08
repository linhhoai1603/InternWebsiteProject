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

    public static void main(String[] args) {
        AuthenServies authen = new AuthenServies();
        AccountUser acc = authen.checkLogin("linhhoai", "dmpiYXZ2dmFidmFidmJhdmFoYmh2YWJoaGJhbGluaGhvYWk3OTY2NTZAIyQlUUAjZmNmdnlnYg==");
        if(acc != null) {
            User user = acc.getUser();
            System.out.println(user.getFullName());
        } else {
            System.out.println("Tài khoản hoặc mật khẩu sai");
        }
    }
}
