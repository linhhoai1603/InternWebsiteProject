package controllers;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import dao.UserDao;
import dao.UserProviderDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.AccountUser;
import models.Cart;
import models.User;
import services.AuthService;
import services.CartService;
import utils.ConfigLoader;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

@WebServlet(name = "oauth2callback", value = "/oauth2callback")
public class oauth2callback extends HttpServlet {
    private static final String CLIENT_ID = ConfigLoader.getProperty("google.oauth.clientId");
    private static final String CLIENT_SECRET = ConfigLoader.getProperty("google.oauth.clientSecret");
    private static final String REDIRECT_URI = "http://192.168.74.139.nip.io/ProjectWeb/oauth2callback";

    private static final GsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    private static final NetHttpTransport HTTP_TRANSPORT = new NetHttpTransport();

    private UserDao userDao = new UserDao();
    private UserProviderDao userProviderDao = new UserProviderDao();
    private AuthService authService = new AuthService(userDao, userProviderDao);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // --- Bảo vệ chống CSRF ---
        String receivedState = request.getParameter("state");
        String sessionState = (String) request.getSession().getAttribute("GOOGLE_OAUTH_STATE");

        if (receivedState == null || !receivedState.equals(sessionState)) {
            log("Lỗi CSRF: State không khớp.");
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid state parameter.");
            return;
        }
        request.getSession().removeAttribute("GOOGLE_OAUTH_STATE");

        String authorizationCode = request.getParameter("code");
        if (authorizationCode == null) {
            log("Không nhận được authorization code từ Google.");
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Google%20authentication%20failed");
            return;
        }

        HttpSession existingSession = request.getSession(false);
        if (existingSession == null || existingSession.getAttribute("user") != null) {
            log("Người dùng đã đăng nhập từ trước.");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            // --- Đổi authorization code lấy Access Token và ID Token ---
            log("Bắt đầu xử lý callback từ Google");
            log("Authorization code nhận được: " + authorizationCode);
            GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                    HTTP_TRANSPORT,
                    JSON_FACTORY,
                    CLIENT_ID,
                    CLIENT_SECRET,
                    authorizationCode,
                    REDIRECT_URI
            ).execute();
            log("Đã lấy được token từ Google.");

            // --- Xác thực ID Token và lấy thông tin người dùng ---
            String idTokenString = tokenResponse.getIdToken();
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(HTTP_TRANSPORT, JSON_FACTORY)
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();

                if (!CLIENT_ID.equals(payload.getAudience())) {
                    log("Invalid audience in ID Token.");
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid audience in ID Token.");
                    return;
                }
                if (!CLIENT_ID.equals(payload.getAuthorizedParty())) {
                    log("Lỗi: Token không được cấp cho ứng dụng này.");
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Token không hợp lệ.");
                    return;
                }

                long expirationTime = payload.getExpirationTimeSeconds();
                long currentTime = System.currentTimeMillis() / 1000;

                if (expirationTime < currentTime) {
                    log("ID Token đã hết hạn.");
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Token hết hạn. Vui lòng đăng nhập lại.");
                    return;
                }

                String googleUserId = payload.getSubject();
                String email = payload.getEmail();
                boolean emailVerified = payload.getEmailVerified();
                String name = (String) payload.get("name");
                String pictureUrl = (String) payload.get("picture");
                String familyName = (String) payload.get("family_name");
                String givenName = (String) payload.get("given_name");

                log("Google User ID: " + googleUserId);
                log("Email: " + email);
                log("Name: " + name);

                // --- Xử lý logic Đăng nhập / Đăng ký trong DB ---
                int internalUserId = authService.processGoogleLogin(googleUserId, email, givenName, familyName, pictureUrl, emailVerified);
                if (internalUserId > 0) {
                    User user = userDao.findUserById(internalUserId);
                    AccountUser accountUser = new AccountUser();
                    accountUser.setUser(user);
                    if (existingSession != null) {
                        existingSession.invalidate();
                    }
                    HttpSession newSession = request.getSession(true);
                    newSession.setMaxInactiveInterval(30 * 60);
                    newSession.setAttribute("loggedInUserId", internalUserId);
                    newSession.setAttribute("user", user);
                    newSession.setAttribute("account", accountUser);
                    CartService cartService = new CartService();
                    Cart cart = cartService.getCart(user.getId());
                    newSession.setAttribute("cart", cart);
                    log("Người dùng (ID=" + internalUserId + ") đăng nhập thành công bằng Google.");
                    response.sendRedirect(request.getContextPath() + "/home");
                } else {
                    log("Không thể xử lý đăng nhập/đăng ký cho Google ID: " + googleUserId);
                    response.sendRedirect(request.getContextPath() + "/login.jsp?error=Unable%20to%20process%20Google%20login");
                }

            } else {
                log("ID Token không hợp lệ.");
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid ID Token.");
            }

        } catch (GeneralSecurityException e) {
            log("Lỗi bảo mật khi xác thực ID Token: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Security error during Google authentication.");
        } catch (IOException e) {
            log("Lỗi IO khi giao tiếp với Google: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error communicating with Google.");
        } catch (Exception e) {
            log("Lỗi không xác định khi xử lý đăng nhập Google: " + e.getMessage(), e);
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=An%20unexpected%20error%20occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}