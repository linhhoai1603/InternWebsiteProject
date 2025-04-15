package services;

import dao.AccountDao;
import models.AccountUser;

public class AccountService {
    AccountDao accountDao;

    public AccountService() {
        accountDao = new AccountDao();
    }

    public AccountUser findByUsername(String username, String hashedPassword) {
        AccountUser acc = accountDao.findByUsername(username, hashedPassword);
        if (acc == null) {
            return null;
        }
        return acc;
    }

    public void updateCode(String username, int code) {
        accountDao.updateCode(username, code);
    }

    public boolean checkCode(String username, int code) {
        return accountDao.checkCode(username, code);
    }

    public void resetPassword(String username, String password) {
        accountDao.resetPassword(username, password);
    }

    public boolean updateCodeByEmail(String email, String code) {
        return accountDao.updateCodeByEmail(email, code);
    }

    public boolean checkPass(String username, String password) {
        return accountDao.checkPass(username, password);

    }

    public boolean deleteAccountUserByIDUser(int id) {
        return accountDao.deleteAccountUserByIDUser(id);
    }

    public boolean resetPasswordByEmail(String email, String hashedPassword) {
        return accountDao.resetPasswordByEmail(email, hashedPassword);
    }
}
