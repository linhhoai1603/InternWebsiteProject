package services;

import dao.UserDao;
import models.AccountUser;
import models.User;
import models.enums.TokenType;
import models.UserTokens;
import services.application.EmailSender;
import services.application.HashUtil;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class UserService {
    private UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public UserService() {
        this.userDao = new UserDao();
    }

    public void registerUser(String email, String firstname, String lastname, String username, String password,
                             String phoneNumber, String image, String appBaseURL) {
        String rawToken = UUID.randomUUID().toString();
        String tokenHash = HashUtil.encodePasswordBase64(rawToken);
        LocalDateTime expiresAt = LocalDateTime.now().plusHours(24);

        userDao.getJdbi().useTransaction(handle -> {
            int newUserId = userDao.insertUser(handle, email, firstname, lastname, phoneNumber, 1, image);
            userDao.insertAccountUser(handle, newUserId, username, password, 1, 1, null);

            userDao.insertToken(handle, newUserId, tokenHash, TokenType.email_verification, expiresAt);

            String activationLink = appBaseURL + "/activate?token=" + rawToken;
            String subject = "Kích hoạt tài khoản của bạn";
            String txt = "Chào " + username + ",\n\nVui lòng nhấp vào liên kết sau để kích hoạt tài khoản của bạn:\n" + activationLink +
                    "\n\nLiên kết này sẽ hết hạn sau " + " 24 giờ.\n\nTrân trọng.";

            EmailSender.sendEMail(email, subject, txt);
        });
    }

    public boolean activateUser(String rawToken) {
        System.out.println("activateUser - Raw Token Input: " + rawToken);
        String tokenHash = HashUtil.encodePasswordBase64(rawToken);
        System.out.println("activateUser - Generated Hash: '" + tokenHash + "'");
        Optional<UserTokens> tokenOpt = userDao.findTokenByHash(tokenHash);

        if (tokenOpt.isPresent()) {
            UserTokens token = tokenOpt.get();

            if (token.getTokenType().equals(TokenType.email_verification) &&
                    token.getExpiresAt().isAfter(LocalDateTime.now())) {

                boolean activated = userDao.unlockUser(token.getIdUser());
                if (activated) {
                    userDao.deleteToken(tokenHash);
                    return true;
                } else {
                    System.err.println("Lỗi khi cập nhật trạng thái user: " + token.getIdUser());
                    return false;
                }
            } else {
                if (!token.getTokenType().equals(TokenType.email_verification)) {
                    System.err.println("Token không đúng loại: " + token.getTokenType());
                }
                if (token.getExpiresAt().isBefore(LocalDateTime.now())) {
                    System.err.println("Token đã hết hạn: " + token.getExpiresAt());

                }
                return false;
            }
        } else {
            System.err.println("Token không tồn tại trong DB: " + tokenHash);
            return false;
        }
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

    public void createEmp(String email, String firstName, String lastName, String username, String hasedPassword, String phoneNumber, String image, int role) {
        userDao.getJdbi().useTransaction(handle -> {
            int newUserId = userDao.insertUser(handle, email, firstName, lastName, phoneNumber, 1, image);
            userDao.insertAccountUser(handle, newUserId, username, hasedPassword, role, 0, null);
        });
    }

    public List<User> getAllUserByAccList(List<AccountUser> AccList) {
        return userDao.getAllUserByAccList(AccList);
    }

    public List<AccountUser> getAllAccUserByRole(int RoleId) {
        return userDao.getAllAccUserByRole(RoleId);
    }
}

