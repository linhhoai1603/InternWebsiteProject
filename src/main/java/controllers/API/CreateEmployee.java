package controllers.API;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.UserService;
import services.application.HashUtil;

import java.io.IOException;

@WebServlet(name = "CreateEmployee", value = "/api/create-employee")
public class CreateEmployee extends HttpServlet {
    private final UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String hasedPassword = this.hashedPassword(password);
        int role = Integer.parseInt(request.getParameter("role"));

        try {
            userService.createEmp(email, firstName, lastName, username, hasedPassword, phoneNumber, "default.png", role);
            System.out.println("tao thanh cong employee");
            request.getRequestDispatcher("/admin/manage-employees").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình tạo tài khoản " + e.getMessage());
            request.getRequestDispatcher("/admin/manage-employees").forward(request, response);
        }
    }
    private String hashedPassword(String password) {
        return HashUtil.encodePasswordBase64(password);
    }
}