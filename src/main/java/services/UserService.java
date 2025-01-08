package services;

import dao.UserDao;
// Đảm bảo bạn import HashUtil từ package services
import services.HashUtil;

public class UserService {
    private UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
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

        int newUserId = userDao.insertUser(fakeEmail, fullName, phoneNumber, idAddress, image);

        // Sử dụng HashUtil để mã hóa mật khẩu bằng Base64
        String encodedPassword = HashUtil.encodePasswordBase64(password);

        userDao.insertAccountUser(newUserId, username, encodedPassword, 1, 0, 0);
    }
}