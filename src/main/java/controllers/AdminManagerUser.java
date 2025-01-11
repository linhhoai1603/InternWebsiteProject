package controllers;import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.AccountUser;

import services.UserService;

@WebServlet("/admin/admin-manager-users")
public class AdminManagerUser extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String method = request.getParameter("method");

        if ("getAllUsers".equals(method)) {
            getAllUsers(request, response);
        } else if ("lockUser".equals(method)) {
            lockUser(request, response);
        }else if("unlockUser".equals(method)){
            unlockUser(request, response);
        } else if("searchUser".equals(method)){
            searchUser(request, response);
        }
        else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Phương thức không hợp lệ!");
        }
    }

    // Giả sử bạn đã có một UserService để tìm kiếm người dùng từ cơ sở dữ liệu
    private void searchUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("name"); // Lấy tên người dùng từ form

        if (userName == null || userName.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng nhập tên người dùng.");
        } else {
            try {
                // Giả sử bạn có UserService với phương thức searchUser
                List<AccountUser> foundUsers = userService.searchUser(userName);

                if (foundUsers != null && !foundUsers.isEmpty()) {
                    request.setAttribute("accounts", foundUsers);
                    request.setAttribute("message", "Tìm thấy " + foundUsers.size() + " người dùng.");
                } else {
                    request.setAttribute("message", "Không tìm thấy người dùng nào.");
                }
            } catch (Exception e) {
                request.setAttribute("message", "Lỗi khi tìm kiếm người dùng: " + e.getMessage());
            }
        }

        // Chuyển hướng lại trang quản lý người dùng sau khi tìm kiếm
        request.getRequestDispatcher("management-users.jsp").forward(request, response);
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
    private void unlockUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("user_id");

        if (userIdParam == null || userIdParam.isEmpty()) {
            request.setAttribute("message", "Không tìm thấy người dùng!");
        } else {
            try {
                int id = Integer.parseInt(userIdParam);
                boolean isUnlocked = userService.unlockUser(id); // Gọi dịch vụ mở khóa người dùng

                if (isUnlocked) {
                    request.setAttribute("message", "Mở khóa người dùng thành công!");
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
        request.getRequestDispatcher("management-users.jsp").forward(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        getAllUsers(request, response);
    }
}
