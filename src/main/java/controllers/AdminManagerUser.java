package controllers;import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.AccountUser;

import services.UserService;

@WebServlet("/admin-manager-users")
public class AdminManagerUser extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String method = request.getParameter("method");

        if ("getAllUsers".equals(method)) {
            getAllUsers(request, response);
        } else if ("lockUser".equals(method)) {
            lockUser(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Phương thức không hợp lệ!");
        }
    }

    private void lockUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("user_id");

        if (userIdParam == null || userIdParam.isEmpty()) {
            request.setAttribute("message", "Không tìm thấy người dùng!");
        } else {
            try {
                int id = Integer.parseInt(userIdParam);
                boolean isLocked = userService.lockUser(id);

                if (isLocked) {
                    request.setAttribute("message", "Khóa người dùng thành công!");
                } else {
                    request.setAttribute("message", "Không tìm thấy người dùng với ID " + id);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("message", "ID người dùng không hợp lệ!");
            }
        }

        // Lấy danh sách người dùng mới để hiển thị
        getAllUsers(request, response);
    }

    private void getAllUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<AccountUser> users = userService.getAllUser();
        request.setAttribute("accounts", users);
        request.getRequestDispatcher("admin/management-users.jsp").forward(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        getAllUsers(request, response);
    }
}
