package services;

import dao.UserDao;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {
    private UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public void registerUser(String email, String password, String fullName,
                             String phoneNumber, int idAddress, String image) {
        // 1. Kiểm tra email null hoặc rỗng
        if (email == null || email.isEmpty()) {
            throw new RuntimeException("Email không được để trống.");
        }

        // 2. Kiểm tra độ dài mật khẩu
        if (password == null || password.length() < 6) {
            throw new RuntimeException("Mật khẩu phải có ít nhất 6 ký tự.");
        }

        // 3. Kiểm tra email đã tồn tại
        if (userDao.emailExists(email)) {
            throw new RuntimeException("Email đã được sử dụng.");
        }

        // 4. Insert user vào DB
        int idUser = userDao.insertUser(email, fullName, phoneNumber, idAddress, image);

        // 5. Hash password và insert account
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
        userDao.insertAccountUser(idUser, email, hashedPassword, 1, 0, 0);
    }

}

