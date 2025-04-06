package services;

import dao.UserDao;
import models.AccountUser;
import models.User;

import java.util.List;

public class UserService {
    private UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public UserService() {
        this.userDao = new UserDao();
    }

    public void registerUser(String email, String firstname, String lastname, String username, String password,
                             String phoneNumber, String image) {

        userDao.getJdbi().useTransaction(handle -> {
            int newUserId = userDao.insertUser(handle, email, firstname, lastname, phoneNumber, null, image);
            userDao.insertAccountUser(handle, newUserId, username, password, 1, 0, null);
        });
    }


    public boolean checkHaveEmail(String username, String email) {
        return userDao.checkHaveEmail(username, email);
    }

    public List<AccountUser> getAllUser() {
        return userDao.getAllUser();
    }

    public boolean lockUser(int id) {
        return userDao.lockUser(id);
    }

    public boolean unlockUser(int id) {
        return userDao.unlockUser(id);
    }

    public List<AccountUser> searchUser(String name) {
        return userDao.findUserByName(name);
    }


}

