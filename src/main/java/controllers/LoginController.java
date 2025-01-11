package controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.AccountUser;
import models.User;
import services.AuthenServies;
import services.application.HashUtil;

import java.io.IOException;

@WebServlet(name="LoginController", value = "/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Kiểm tra username và password có trống không
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Tên đăng nhập và mật khẩu không được để trống");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra đăng nhập
        AuthenServies authen = new AuthenServies();
        AccountUser acc = authen.checkLogin(username, HashUtil.encodePasswordBase64(password));

        if(acc != null) {
            if(acc.getLocked() == 1) {
                request.setAttribute("username", username);
                request.setAttribute("error", "Tài khoản đã bị khóa, vui lòng liên hệ quản trị viên");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            // Lưu thông tin người dùng vào session
            User user = acc.getUser();
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("account", acc);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            // Nếu đăng nhập sai, giữ lại username và thông báo lỗi
            request.setAttribute("username", username);
            request.setAttribute("error", "Tài khoản hoặc mật khẩu sai");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
