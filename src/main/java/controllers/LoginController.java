package controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.AccountUser;
import models.Cart;
import models.User;
import services.AuthenServies;
import services.CartService;
import services.UserLogService;
import services.application.HashUtil;
import utils.ConfigLoader;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet(name = "LoginController", value = "/login-user")
public class LoginController extends HttpServlet {

    private boolean verifyRecaptcha(String recaptchaResponse) throws IOException {
        String secretKey =ConfigLoader.getProperty("recaptcha.sec.key");
        String verifyUrl = "https://www.google.com/recaptcha/api/siteverify";
        String postParams = "secret=" + secretKey + "&response=" + recaptchaResponse;

        System.out.println("Verifying reCAPTCHA...");
        System.out.println("Secret Key: " + secretKey);
        System.out.println("Response: " + recaptchaResponse);

        URL url = new URL(verifyUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setDoOutput(true);

        try (OutputStream os = con.getOutputStream()) {
            os.write(postParams.getBytes());
            os.flush();
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuilder responseStr = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            responseStr.append(inputLine);
        }
        in.close();

        String response = responseStr.toString();
        System.out.println("reCAPTCHA API Response: " + response);

        // Kiểm tra phản hồi có chứa `"success": true` không
        boolean success = response.contains("\"success\": true");
        System.out.println("Verification result: " + success);
        return success;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String siteKey = ConfigLoader.getProperty("recaptcha.site.key");
        request.setAttribute("siteKey", siteKey);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String recaptchaResponse = request.getParameter("g-recaptcha-response");

        // Bước 1: Kiểm tra CAPTCHA
        if (recaptchaResponse == null || !verifyRecaptcha(recaptchaResponse)) {
            String siteKey =ConfigLoader.getProperty("recaptcha.site.key");
            request.setAttribute("siteKey", siteKey);
            request.setAttribute("username", username);
            request.setAttribute("error", "Xác minh CAPTCHA thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Bước 2: Kiểm tra username/password trống
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            String siteKey =ConfigLoader.getProperty("recaptcha.site.key");
            request.setAttribute("siteKey", siteKey);
            request.setAttribute("error", "Tên đăng nhập và mật khẩu không được để trống");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Bước 3: Kiểm tra tài khoản
        AuthenServies authen = new AuthenServies();
        AccountUser acc = authen.checkLogin(username, HashUtil.encodePasswordBase64(password));

        if (acc != null) {
            if (acc.getLocked() == 1) {
                String siteKey =ConfigLoader.getProperty("recaptcha.site.key");
                request.setAttribute("siteKey", siteKey);
                request.setAttribute("username", username);
                request.setAttribute("error", "Tài khoản đã bị khóa, vui lòng liên hệ quản trị viên");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            User user = acc.getUser();
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("account", acc);

            CartService cartService = new CartService();
            Cart cart = cartService.getCart(user.getId());
            session.setAttribute("cart", cart);

            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            String siteKey =ConfigLoader.getProperty("recaptcha.site.key");
            request.setAttribute("siteKey", siteKey);
            request.setAttribute("username", username);
            request.setAttribute("error", "Tài khoản hoặc mật khẩu sai");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
