package services;

import connection.DBConnection;
import dao.UserDao;
import dao.UserProviderDao;
import models.User;
import models.UserProviders;
import org.jdbi.v3.core.Jdbi;
import utils.CodeGenerator;

import java.util.Optional;

public class AuthService {
    private UserDao userDao;
    private UserProviderDao userProviderDao;
    Jdbi jdbi;
    CodeGenerator codeGenerator;

    public AuthService(UserDao userDao, UserProviderDao userProviderDao) {
        this.userDao = userDao;
        this.userProviderDao = userProviderDao;
        this.jdbi = DBConnection.getJdbi();
    }

    public int processGoogleLogin(String googleUserId, String email, String firstName, String lastName, String pictureUrl, boolean emailVerified) throws Exception {
        try {

            Integer resultingUserId = jdbi.inTransaction(handle -> {
                int currentUserId = -1;

                // 1. Kiểm tra user_providers bằng provider_id
                Optional<UserProviders> existingProvider = userProviderDao.findByProvider("GOOGLE", googleUserId);

                if (existingProvider.isPresent()) {
                    currentUserId = existingProvider.get().getUserId();
                    System.out.println("AuthService (JDBI Transaction): Tìm thấy user qua Google ID: " + currentUserId);
                } else {
                    // 2. Kiểm tra bảng users bằng email
                    Optional<User> existingUser = userDao.findByEmail(email);

                    if (existingUser.isPresent()) {
                        currentUserId = existingUser.get().getId();
                        System.out.println("AuthService (JDBI Transaction): Tìm thấy user qua email: " + currentUserId + ". Tạo liên kết Google.");

                        // 3a. Tạo liên kết mới trong user_providers
                        UserProviders newProviderLink = new UserProviders();
                        newProviderLink.setUserId(currentUserId);
                        newProviderLink.setProviderName("GOOGLE");
                        newProviderLink.setProviderId(googleUserId);
                        newProviderLink.setProviderEmail(email);
                        userProviderDao.createProviderLink(newProviderLink);

                    } else {
                        System.out.println("AuthService (JDBI Transaction): Người dùng mới. Tạo user và liên kết Google.");

                        // 3b. Tạo đối tượng User mới
                        User newUser = new User();
                        newUser.setEmail(email);
                        newUser.setFirstname(firstName);
                        newUser.setLastname(lastName);
                        newUser.setImage(pictureUrl);
                        newUser.setNumberPhone("000000000");

                        String ggPass = codeGenerator.generateUniqueCode(email);
                        currentUserId = userDao.createUser(newUser);
                        int currentAccountId = userDao.createAccount(currentUserId, email, ggPass, 1, 0, null);
                        if (currentUserId <= 0 || currentAccountId <= 0) {
                            throw new RuntimeException("Không thể tạo user mới trong CSDL.");
                        }
                        System.out.println("AuthService (JDBI Transaction): User mới được tạo với ID: " + currentUserId + "account" + currentAccountId);

                        // 4b. Tạo liên kết mới trong user_providers
                        UserProviders newProviderLink = new UserProviders();
                        newProviderLink.setUserId(currentUserId);
                        newProviderLink.setProviderName("GOOGLE");
                        newProviderLink.setProviderId(googleUserId);
                        newProviderLink.setProviderEmail(email);
                        userProviderDao.createProviderLink(newProviderLink);
                    }
                }
                if (currentUserId <= 0) {
                    throw new RuntimeException("Không xác định được User ID hợp lệ.");
                }
                return currentUserId;
            });
            if (resultingUserId == null || resultingUserId <= 0) {
                throw new Exception("Không thể hoàn tất quá trình đăng nhập/đăng ký.");
            }

            System.out.println("AuthService (JDBI): Transaction thành công, trả về userId = " + resultingUserId);
            return resultingUserId;

        } catch (Exception e) {
            System.err.println("AuthService (JDBI): Lỗi khi xử lý đăng nhập Google: " + e.getMessage());
            e.printStackTrace();
            throw new Exception("Xảy ra lỗi trong quá trình xử lý đăng nhập Google. Vui lòng thử lại.", e);
        }
    }
}
