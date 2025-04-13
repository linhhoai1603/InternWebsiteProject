package controllers;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Parameter;
import com.restfb.Version;
import com.restfb.exception.FacebookOAuthException;
import com.restfb.types.User; // RestFB User
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
// Import các lớp DAO và Service
import dao.UserDao;
import dao.UserProviderDao;
import services.AuthService;
import connection.DBConnection; // Import DBConnection để lấy Jdbi nếu cần khởi tạo DAO/Service ở đây
import org.jdbi.v3.core.Jdbi; // Import Jdbi
import utils.ConfigLoader;

@WebServlet(name = "facebookCallback", value = "/fb-callback")
public class FacebookCallback extends HttpServlet {

    private static final String FACEBOOK_APP_ID = ConfigLoader.getProperty("FACEBOOK_APP_ID");
    private static final String FACEBOOK_APP_SECRET = ConfigLoader.getProperty("FACEBOOK_APP_SECRET");
    private static final String FACEBOOK_REDIRECT_URI = "http://localhost:8080/ProjectWeb/fb-callback";
    private static final Version FACEBOOK_API_VERSION = Version.VERSION_18_0;

    private transient AuthService authService;
    private transient Jdbi jdbi;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            this.jdbi = DBConnection.getJdbi();
            if (this.jdbi == null) {
                throw new ServletException("Không thể khởi tạo JDBI từ DBConnection");
            }
            UserDao userDao = new UserDao();
            UserProviderDao userProviderDao = new UserProviderDao();
            authService = new AuthService(userDao, userProviderDao);
            log("AuthService đã được khởi tạo trong FacebookCallback");
        } catch (Exception e) {
            log("LỖI NGHIÊM TRỌNG: Không thể khởi tạo AuthService trong FacebookCallback", e);
            throw new ServletException("Lỗi khởi tạo service", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        log("Bắt đầu xử lý /fb-callback");

        // --- Kiểm tra State ---
        String receivedState = (String) req.getSession().getAttribute("state");
        String sessionState = (String) req.getSession().getAttribute("FACEBOOK_OAUTH_STATE");
        if (receivedState == null || !receivedState.equals(sessionState)) {
            log("Lỗi CSRF (FB): State không khớp.");
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid state parameter.");
            return;
        }
        req.getSession().removeAttribute("FACEBOOK_OAUTH_STATE");
        req.getSession().removeAttribute("state");
        log("State hợp lệ (FB).");

        // --- Lấy Code do Fb gửi ---
        String code = req.getParameter("code");
        String error = req.getParameter("error");
        if (error != null) {
            log("Lỗi từ Facebook: " + error + " - " + req.getParameter("error_description"));
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Facebook%20login%20failed:%20" + error);
            return;
        }
        if (code == null) {
            log("Không nhận được code từ Facebook.");
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Facebook%20login%20failed");
            return;
        }
        log("Nhận được code (FB): [hidden]");

        // --- Đảm bảo AuthService đã sẵn sàng ---
        if (this.authService == null) {
            log("LỖI: AuthService chưa được khởi tạo khi xử lý callback.");
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cấu hình server.");
            return;
        }

        try {
            // --- Đổi Code lấy Access Token ---
            FacebookClient clientForToken = new DefaultFacebookClient(FACEBOOK_API_VERSION);
            FacebookClient.AccessToken accessTokenResponse = clientForToken.obtainUserAccessToken(
                    FACEBOOK_APP_ID,
                    FACEBOOK_APP_SECRET,
                    FACEBOOK_REDIRECT_URI,
                    code
            );
            String accessToken = accessTokenResponse.getAccessToken();
            if (accessToken == null || accessToken.trim().isEmpty()) {
                log("Không lấy được access token từ Facebook.");
                resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Failed%20to%20get%20Facebook%20token");
                return;
            }
            log("Đã lấy được Access Token (FB): [hidden]");

            // --- Dùng Access Token lấy thông tin User ---
            FacebookClient facebookClient = new DefaultFacebookClient(accessToken, FACEBOOK_APP_SECRET, FACEBOOK_API_VERSION);
            User fbUser = facebookClient.fetchObject("me", User.class,
                    Parameter.with("fields", "id,email,first_name,last_name,picture.type(large)"));

            String facebookUserId = fbUser.getId();
            String email = fbUser.getEmail();
            String firstName = fbUser.getFirstName();
            String lastName = fbUser.getLastName();
            String pictureUrl = (fbUser.getPicture() != null) ? fbUser.getPicture().getUrl() : null;

            log("Facebook User ID: " + facebookUserId);
            log("Email (có thể null): " + email);
            log("First Name: " + firstName);
            log("Last Name: " + lastName);

            // --- Xử lý trường hợp email null ---
            if (email == null || email.trim().isEmpty()) {
                log("LỖI: Không lấy được email từ Facebook.");
                // Tạm thời báo lỗi chung, bạn có thể xử lý phức tạp hơn
                resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Could%20not%20retrieve%20email%20from%20Facebook");
                return;
            }

            int internalUserId = authService.processFacebookLogin(facebookUserId, email, firstName, lastName, pictureUrl, true); // Giả sử bạn tạo phương thức này

            if (internalUserId > 0) {
                req.getSession().setAttribute("loggedInUserId", internalUserId);
                log("Người dùng (ID=" + internalUserId + ") đăng nhập thành công bằng Facebook.");
                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                log("AuthService không thể xử lý đăng nhập/đăng ký Facebook.");
                resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Unable%20to%20process%20Facebook%20login");
            }

        } catch (FacebookOAuthException e) {
            log("Lỗi OAuth từ Facebook: " + e.getMessage(), e);
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Facebook%20authentication%20error");
        } catch (Exception e) {
            log("Lỗi không mong muốn khi xử lý callback Facebook: " + e.getMessage(), e);
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=An%20unexpected%20error%20occurred");
        }
    }

    public void log(String message) {
        System.out.println("[FacebookCallbackServlet] " + message);
    }

    public void log(String message, Throwable throwable) {
        System.err.println("[FacebookCallbackServlet ERROR] " + message);
        throwable.printStackTrace(System.err);
    }
}