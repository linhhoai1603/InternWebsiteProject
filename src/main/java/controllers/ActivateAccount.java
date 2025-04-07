package controllers;

import connection.DBConnection;
import dao.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.jdbi.v3.core.Jdbi;
import services.UserService;

import java.io.IOException;

@WebServlet(name = "ActivateAccount", value = "/activate")
public class ActivateAccount extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        Jdbi jdbi = DBConnection.getJdbi();
        UserDao userDao = new UserDao(jdbi);
        userService = new UserService(userDao);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");

        if (token == null || token.isEmpty()) {
            request.setAttribute("error", "Liên kết kích hoạt không hợp lệ hoặc bị thiếu.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            boolean activationResult = userService.activateUser(token);

            if (activationResult) {
                request.setAttribute("success", "Tài khoản của bạn đã được kích hoạt thành công! Vui lòng đăng nhập.");
            } else {
                request.setAttribute("error", "Liên kết kích hoạt không hợp lệ, đã hết hạn hoặc tài khoản đã được kích hoạt.");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình kích hoạt tài khoản.");
        }
        // Chuyển hướng đến trang login với thông báo
        request.getRequestDispatcher("login.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}