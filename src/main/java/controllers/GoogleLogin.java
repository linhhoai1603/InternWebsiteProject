package controllers;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeRequestUrl;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.json.gson.GsonFactory;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.ConfigLoader;

import java.io.IOException;
import java.io.InputStream;         // Thêm import InputStream
import java.io.InputStreamReader;   // Thêm import InputStreamReader
import java.nio.charset.StandardCharsets; // Thêm import StandardCharsets
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "googleLogin", value = "/googleLogin")
public class GoogleLogin extends HttpServlet {
    private static final String HARDCODED_CLIENT_ID_CHECK = ConfigLoader.getProperty("google.oauth.clientId");
    private static final String REDIRECT_URI = "http://192.168.74.139.nip.io/ProjectWeb/oauth2callback";
    private static final List<String> SCOPES = Arrays.asList(
            "openid",
            "https://www.googleapis.com/auth/userinfo.email",
            "https://www.googleapis.com/auth/userinfo.profile"
    );
    private static final GsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        log("Bắt đầu xử lý yêu cầu /googleLogin");

        try {
            // 1. Tạo và lưu state token chống CSRF
            String state = new SecureRandom().nextLong() + "";
            request.getSession().setAttribute("GOOGLE_OAUTH_STATE", state);
            log("Đã tạo và lưu state: " + state);

            // 2. Load thông tin client secrets từ classpath
            String clientSecretsFileName = "client_secrets.json";
            InputStream in = this.getClass().getClassLoader().getResourceAsStream(clientSecretsFileName);

            if (in == null) {
                log("LỖI NGHIÊM TRỌNG: Không tìm thấy file '" + clientSecretsFileName + "' trong classpath!");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cấu hình phía máy chủ. " +
                        "Không tìm thấy thông tin xác thực Google.");
                return;
            }
            log("Đã tìm thấy file '" + clientSecretsFileName + "' trong classpath.");

            GoogleClientSecrets clientSecrets;
            try (InputStreamReader reader = new InputStreamReader(in, StandardCharsets.UTF_8)) {
                clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, reader);
                log("Đã load thành công client secrets từ file.");
            }

            // 3. Lấy Client ID và kiểm tra (tùy chọn nhưng nên làm)
            String clientId = clientSecrets.getDetails().getClientId();
            if (clientId == null || clientId.trim().isEmpty()) {
                log("LỖI NGHIÊM TRỌNG: Client ID bị thiếu hoặc trống trong file " + clientSecretsFileName);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cấu hình Client ID.");
                return;
            }
            if (!clientId.equals(HARDCODED_CLIENT_ID_CHECK)) {
                log("CẢNH BÁO: Client ID trong file secrets (" + clientId + ") khác với giá trị hardcode (" + HARDCODED_CLIENT_ID_CHECK + "). Hãy kiểm tra lại cả hai!");
            }
            log("Sử dụng Client ID: " + clientId);
            log("Sử dụng Redirect URI: " + REDIRECT_URI);

            // 4. Xây dựng URL ủy quyền của Google
            GoogleAuthorizationCodeRequestUrl authorizationUrl = new GoogleAuthorizationCodeRequestUrl(
                    clientId,
                    REDIRECT_URI,
                    SCOPES
            );
            authorizationUrl.setState(state);
            String url = authorizationUrl.build();
            log("URL ủy quyền được tạo: " + url);

            // 5. Chuyển hướng người dùng đến Google
            response.sendRedirect(url);
            log("Đã chuyển hướng người dùng đến Google.");

        } catch (IOException e) {
            log("Lỗi IOException trong quá trình khởi tạo Google Login: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi xử lý yêu cầu đăng nhập Google.");
        } catch (Exception e) {
            log("Lỗi không mong muốn trong quá trình khởi tạo Google Login: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi không mong muốn.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    public void log(String message) {
        System.out.println("[GoogleLoginServlet] " + message);
    }

    public void log(String message, Throwable throwable) {
        System.err.println("[GoogleLoginServlet ERROR] " + message);
        throwable.printStackTrace(System.err);
    }
}

