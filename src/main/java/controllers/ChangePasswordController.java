package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.AccountUser;
import services.AccountService;
import services.application.HashUtil;

import java.io.IOException;

@WebServlet(name = "ChangePasswordController", value = "/change-password")
public class ChangePasswordController extends HttpServlet {

    private final AccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý yêu cầu GET để hiển thị trang thay đổi mật khẩu
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) Lấy thông tin tài khoản từ session (nếu có)
        HttpSession session = request.getSession(false);
        AccountUser account = (AccountUser) session.getAttribute("account");
        if (account == null) {
            // Nếu không có session, chuyển hướng đến trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2) Lấy các thông số đầu vào
        String currentPassword = request.getParameter("current_pass");
        String newPassword1 = request.getParameter("new_pass1");
        String newPassword2 = request.getParameter("new_pass2");

        // 3) Kiểm tra các trường không được để trống
        if (currentPassword == null || currentPassword.isEmpty()
                || newPassword1 == null || newPassword1.isEmpty()
                || newPassword2 == null || newPassword2.isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ các trường!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        // 4) Kiểm tra mật khẩu mới phải trùng khớp
        if (!newPassword1.equals(newPassword2)) {
            request.setAttribute("error", "Mật khẩu mới không khớp!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        // 5) Kiểm tra mật khẩu hiện tại có đúng không
        if(!accountService.checkPass(account.getUsername(), HashUtil.encodePasswordBase64(currentPassword))) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }


        // 6) Thực hiện thay đổi mật khẩu trong database
        try {
            accountService.resetPassword(account.getUsername(), HashUtil.encodePasswordBase64(newPassword1));
            request.setAttribute("success", "Đổi mật khẩu thành công!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra khi đổi mật khẩu: " + e.getMessage());
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        }
    }
}
