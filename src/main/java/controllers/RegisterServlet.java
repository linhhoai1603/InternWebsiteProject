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
        try {
            userService.registerUser(email, firstName, lastName, username, hasedPassword, phoneNumber, "default.png");

            request.setAttribute("error", "Đăng ký tài khoản thành công!");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private String hashedPassword(String password) {
        return HashUtil.encodePasswordBase64(password);
    }
}