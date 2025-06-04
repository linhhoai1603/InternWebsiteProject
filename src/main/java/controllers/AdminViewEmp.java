package controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.AccountUser;
import models.User;
import org.json.JSONObject;
import services.AccountService;
import services.UserService;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AdminViewEmp", value = "/admin/view-employee")
public class AdminViewEmp extends HttpServlet {
    private final UserService userService = new UserService();
    private final AccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("có vô trang admin view");
        int id = Integer.parseInt(req.getParameter("id"));
        User emp = userService.getEmployeeById(id);
        AccountUser acc = accountService.getEmployeeById(id);

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        if (emp != null) {
            JSONObject obj = new JSONObject();
            obj.put("status", true);
            JSONObject e = new JSONObject();
            e.put("id", emp.getId());
            e.put("firstname", emp.getFirstname());
            e.put("lastname", emp.getLastname());
            e.put("email", emp.getEmail());
            e.put("username", acc.getUsername());
            e.put("phoneNumber", emp.getPhoneNumber());
            e.put("roleName", acc.getRole() == 3 ? "Quản lý" : "Nhân viên");
            obj.put("employee", e);
            out.print(obj.toString());
            out.flush();
        } else {
            out.print("{\"status\":false}");
        }
    }
}