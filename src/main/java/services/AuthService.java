package services;

import connection.DBConnection;
import dao.UserDao;
import dao.UserProviderDao;
import models.User;
import models.UserProviders;
import org.jdbi.v3.core.Jdbi;
import services.application.HashUtil;
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
       return processOAuthLoginInternal("GOOGLE", googleUserId, email, firstName, lastName, pictureUrl, emailVerified);
    }

    public int processFacebookLogin(String facebookUserId, String email, String firstName, String lastName, String pictureUrl, boolean emailVerified) throws Exception {
        return processOAuthLoginInternal("FACEBOOK", facebookUserId, email, firstName, lastName, pictureUrl, emailVerified);
    }

    private int processOAuthLoginInternal(String providerName, String providerId, String email, String firstName, String lastName, String pictureUrl, boolean emailVerified) throws Exception {
        try {
            Integer resultingUserId = jdbi.inTransaction(handle -> {
                int currentUserId = -1;

                // 1. Kiểm tra user_providers bằng providerName và providerId
                Optional<UserProviders> existingProvider = userProviderDao.findByProvider(providerName, providerId);

                if (existingProvider.isPresent()) {
                    currentUserId = existingProvider.get().getUserId();
                    System.out.println("AuthService: Tìm thấy user qua " + providerName + " ID: " + currentUserId);
                } else {
                    // 2. Kiểm tra users bằng email
                    Optional<User> existingUser = userDao.findByEmail(email);

                    if (existingUser.isPresent()) {
                        currentUserId = existingUser.get().getId();
                        System.out.println("AuthService: Tìm thấy user qua email: " + currentUserId + ". Tạo liên kết " + providerName + ".");

                        // 3a. Tạo liên kết mới
                        UserProviders newProviderLink = new UserProviders();
                        newProviderLink.setUserId(currentUserId);
                        newProviderLink.setProviderName(providerName);
                        newProviderLink.setProviderId(providerId);
                        newProviderLink.setProviderEmail(email);
                        userProviderDao.createProviderLink(newProviderLink);

                    } else {
                        System.out.println("AuthService: Người dùng mới qua " + providerName + ". Tạo user, account và liên kết.");

                        // 3b. Tạo User mới
                        User newUser = new User();
                        newUser.setEmail(email);
                        newUser.setFirstname(firstName);
                        newUser.setLastname(lastName);
                        newUser.setImage(pictureUrl != null ? pictureUrl : "default.png");
                        newUser.setNumberPhone("0000000000");

                        currentUserId = userDao.createUser(newUser);

                        String dummyUsername = email;
                        String dummyPasswordInput = codeGenerator.generateUniqueCode(email + System.nanoTime());
                        String dummyHashedPassword = HashUtil.encodePasswordBase64(dummyPasswordInput);
                        int defaultRoleId = 1;
                        Integer verificationCode = null;

                        int currentAccountId = userDao.createAccount(currentUserId, dummyUsername, dummyHashedPassword, defaultRoleId, 0, verificationCode);

                        if (currentUserId <= 0 || currentAccountId <= 0) {
                            throw new RuntimeException("Không thể tạo user hoặc account mới trong CSDL.");
                        }
                        System.out.println("AuthService: User mới tạo ID: " + currentUserId + ", Account ID: " + currentAccountId);

                        // 4b. Tạo liên kết provider
                        UserProviders newProviderLink = new UserProviders();
                        newProviderLink.setUserId(currentUserId);
                        newProviderLink.setProviderName(providerName);
                        newProviderLink.setProviderId(providerId);
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
            System.out.println("AuthService (" + providerName + "): Transaction thành công, trả về userId = " + resultingUserId);
            return resultingUserId;

        } catch (Exception e) {
            System.err.println("AuthService (" + providerName + "): Lỗi khi xử lý đăng nhập: " + e.getMessage());
            e.printStackTrace();
            throw new Exception("Xảy ra lỗi trong quá trình xử lý đăng nhập " + providerName + ". Vui lòng thử lại.", e);
        }
    }
}
