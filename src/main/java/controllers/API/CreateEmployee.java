package controllers.API;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.UserService;
import services.application.EmailSender;
import services.application.HashUtil;
import utils.CodeGenerator;

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
//        String password = request.getParameter("password");
        String hasedPassword = CodeGenerator.generateUniqueCode(email + username);
        int role = Integer.parseInt(request.getParameter("role"));

        try {
            userService.createEmp(email, firstName, lastName, username, hasedPassword, phoneNumber, "default.png", role);
            System.out.println("tao thanh cong employee");
            String content = String.format(
                    "Chào %s,\n\nTài khoản nhân viên của bạn đã được tạo:\n\nUsername: %s\nPassword: %s\n\nVui lòng đổi mật khẩu sau khi đăng nhập.",
                    username, hasedPassword
            );
            EmailSender.sendEMail(email, "Thông tin tài khoản nhân viên mới", content);
            System.out.println("Gui mail thanh cong");
            log("Verification code sent successfully to: " + email);
            response.sendRedirect(request.getContextPath() + "/admin/manage-employees");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình tạo tài khoản " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/manage-employees");
        }
    }

    private String hashedPassword(String password) {
        return HashUtil.encodePasswordBase64(password);
    }
}