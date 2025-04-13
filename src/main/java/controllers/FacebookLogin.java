package controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.ConfigLoader;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;

@WebServlet(name = "facebookLogin", value = "/facebookLogin")
public class FacebookLogin extends HttpServlet {
    private static final String FACEBOOK_APP_ID = ConfigLoader.getProperty("FACEBOOK_APP_ID");
    private static final String FACEBOOK_REDIRECT_URI = "http://localhost:8080/ProjectWeb/fb-callback";
    private static final String FACEBOOK_API_VERSION = "v18.0";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        log("Bắt đầu xử lý /login-facebook");

        String state = new SecureRandom().nextLong() + "";
        request.getSession().setAttribute("FACEBOOK_OAUTH_STATE", state);
        request.getSession().setAttribute("state", state);
        log("Đã tạo và lưu state (FB): " + state);

        String scope = "email,public_profile";
        String authorizationUrl = String.format(
                "https://www.facebook.com/%s/dialog/oauth?client_id=%s&redirect_uri=%s&state=%s&scope=%s",
                FACEBOOK_API_VERSION,
                FACEBOOK_APP_ID,
                URLEncoder.encode(FACEBOOK_REDIRECT_URI, StandardCharsets.UTF_8.toString()),
                state,
                URLEncoder.encode(scope, StandardCharsets.UTF_8.toString())
        );
        log("URL ủy quyền Facebook: " + authorizationUrl);

        response.sendRedirect(authorizationUrl);
        log("Đã chuyển hướng người dùng đến Facebook.");
    }

    public void log(String message) { System.out.println("[FacebookLoginServlet] " + message); }
    public void log(String message, Throwable throwable) {
        System.err.println("[FacebookLoginServlet ERROR] " + message);
        throwable.printStackTrace(System.err);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}