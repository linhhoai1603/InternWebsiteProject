package controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AccountService;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AdminDemoteManager", value = "/admin/demote-manager")
public class AdminDemoteManager extends HttpServlet {
    private final AccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = accountService.updateEmployeeRole(id, 4);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (success) {
            out.print("{\"status\":true, \"message\":\"Hạ cấp thành công.\"}");
        } else {
            out.print("{\"status\":false, \"message\":\"Hạ cấp thất bại hoặc không tìm thấy quản lý.\"}");
        }
        out.flush();
    }
}