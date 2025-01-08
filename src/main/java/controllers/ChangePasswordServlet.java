package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.AccountUser;
import models.User;
import services.AccountService;
import services.UserService;
import services.application.HashUtil;

import java.io.IOException;

// ...existing code...
@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String currentPassword = HashUtil.encodePasswordBase64(request.getParameter("current_pass"));
        String newPassword     = HashUtil.encodePasswordBase64(request.getParameter("new_pass1"));
        String confirmPassword =HashUtil.encodePasswordBase64(request.getParameter("new_pass2"));



        // 1. Kiểm tra người dùng đã đăng nhập hay chưa
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        AccountUser acc = (AccountUser) session.getAttribute("acc");
        acc.setUser(user);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Kiểm tra mật khẩu cũ có đúng không
        AccountService accountService = new AccountService();
        if (!accountService.checkPass(acc.getUsername(), currentPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng!");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        // 3. Kiểm tra mật khẩu mới và xác nhận
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới không khớp!");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }



        // 4. Cập nhật mật khẩu mới
        accountService.resetPassword(acc.getUsername(), newPassword);

        // 5. Hiển thị thông báo thành công
        request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
    }


    public static void main(String[] args) {
        String currentPassword = "123456";
        String newPassword     = "1234567";
        String confirmPassword = "1234567";
        System.out.println(newPassword.equals(confirmPassword));
    }

}
