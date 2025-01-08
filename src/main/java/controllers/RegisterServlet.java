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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 1) Kiểm tra độ dài mật khẩu
        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 2) Kiểm tra mật khẩu và confirmPassword
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3) Kiểm tra định dạng username
        if (!isValidUsername(username)) {
            request.setAttribute("error", "Username không hợp lệ (ít nhất 3 ký tự, không chứa khoảng trắng).");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            userService.registerUser(
                    username,
                    HashUtil.encodePasswordBase64(password),
                    "Default Name",
                    "0000000000",
                    1,
                    "default.png"
            );

            request.setAttribute("success", "Đăng ký tài khoản thành công!");
            request.getRequestDispatcher("register.jsp").forward(request, response);

        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private boolean isValidUsername(String username) {
        // Regex: Cho phép chữ cái, chữ số, dấu chấm, gạch dưới, gạch ngang. Ít nhất 3 ký tự.
        // Không chứa khoảng trắng.
        String usernameRegex = "^[A-Za-z0-9._-]{3,}$";
        return username != null && username.matches(usernameRegex);
    }
}