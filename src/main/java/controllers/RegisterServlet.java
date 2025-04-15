// filepath: /src/main/java/controllers/RegisterServlet.java

package controllers;

import connection.DBConnection;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jdbi.v3.core.Jdbi;
import services.application.HashUtil;
import services.UserService;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        // Khởi tạo kết nối & UserDao
        Jdbi jdbi = DBConnection.getJdbi();
        UserDao userDAO = new UserDao(jdbi);
        userService = new UserService(userDAO);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy tham số từ form
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String hasedPassword = this.hashedPassword(password);

        String scheme = request.getScheme();             // http
        String serverName = request.getServerName();     // localhost
        int serverPort = request.getServerPort();        // 8080
        String contextPath = request.getContextPath();   // /your_app_context (hoặc rỗng nếu root)
        String appBaseUrl = scheme + "://" + serverName + ":" + serverPort + contextPath;

        try {
            userService.registerUser(email, firstName, lastName, username, hasedPassword, phoneNumber, "default.png", appBaseUrl);

            request.setAttribute("success", "Đăng ký thành công! Vui lòng kiểm tra email (" + email + ") để kích hoạt tài khoản.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng ký: " + e.getMessage());
            request.setAttribute("email", email);
            request.setAttribute("firstName", firstName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private String hashedPassword(String password) {
        return HashUtil.encodePasswordBase64(password);
    }
}