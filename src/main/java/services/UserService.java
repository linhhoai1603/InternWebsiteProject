package services;

import dao.UserDao;
// Đảm bảo bạn import HashUtil từ package services


public class UserService {
    private UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }
    public UserService() {
        this.userDao = new UserDao();
    }

    public void registerUser(String username, String password,
                             String fullName, String phoneNumber,
                             int idAddress, String image) {
        // Kiểm tra username
        if (username == null || username.isEmpty()) {
            throw new RuntimeException("Username không được để trống.");
        }

        // Kiểm tra username đã tồn tại chưa (chỉ ở account_users)
        if (userDao.usernameExists(username)) {
            throw new RuntimeException("Username đã được sử dụng.");
        }

        String fakeEmail = "";

        int newUserId = userDao.insertUser(fakeEmail, fullName, phoneNumber, idAddress, image); // add user

        userDao.insertAccountUser(newUserId, username, password, 1, 0, 0); // add accont_user
    }

}

