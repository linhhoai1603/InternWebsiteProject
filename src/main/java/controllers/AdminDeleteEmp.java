package controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AccountService;
import services.UserService;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AdminDeleteEmp", value = "/admin/delete-employee")
public class AdminDeleteEmp extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = userService.lockUser(id);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (success) {
            out.print("{\"status\":true, \"message\":\"Xóa nhân viên thành công.\"}");
        } else {
            out.print("{\"status\":false, \"message\":\"Xóa thất bại hoặc không tìm thấy nhân viên.\"}");
        }
        out.flush();
    }
}