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

import java.io.IOException;

@WebServlet(name="LoginController", value = "/login-user")
public class  LoginController extends HttpServlet {
    private UserLogService userLogService;

    @Override
    public void init() throws ServletException {
        super.init();
        userLogService = new UserLogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ipAddress = request.getRemoteAddr();
        String userAgent = request.getHeader("User-Agent");

        // Kiểm tra username và password có trống không
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Tên đăng nhập và mật khẩu không được để trống");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra đăng nhập
        AuthenServies authen = new AuthenServies();
        AccountUser acc = authen.checkLogin(username, HashUtil.encodePasswordBase64(password));

        if(acc == null) {
            // Log đăng nhập thất bại - sử dụng userId của tài khoản admin (1) để lưu log
            userLogService.logUserActivity(
                1, // Sử dụng ID của admin để lưu log
                "LOGIN_FAILED",
                "Đăng nhập thất bại với username: " + username,
                ipAddress,
                userAgent,
                "WARN"
            );
            
            // Nếu đăng nhập sai, giữ lại username và thông báo lỗi
            request.setAttribute("username", username);
            request.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tài khoản có bị khóa không
        if(acc.getLocked() == 1) {
            // Log tài khoản bị khóa
            userLogService.logUserActivity(
                acc.getUser().getId(),
                "LOGIN_BLOCKED",
                "Tài khoản bị khóa khi đăng nhập",
                ipAddress,
                userAgent,
                "WARN"
            );
            
            request.setAttribute("username", username);
            request.setAttribute("error", "Tài khoản đã bị khóa, vui lòng liên hệ quản trị viên");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Đăng nhập thành công
        User user = acc.getUser();
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("account", acc);
        
        // Log đăng nhập thành công
        userLogService.logUserActivity(
            user.getId(),
            "LOGIN_SUCCESS",
            "Đăng nhập thành công",
            ipAddress,
            userAgent,
            "INFO"
        );
        
        // Lấy giỏ hàng
        CartService cartService = new CartService();
        Cart cart = cartService.getCart(user.getId());
        session.setAttribute("cart", cart);
        
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
