package controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.AccountUser;
import models.User;
import services.AccountService;
import services.UserService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "AdminManagerEmpLoader", value = "/admin/manage-employees")
public class AdminManagerEmpLoader extends HttpServlet {
    private final UserService userService = new UserService();
    private final AccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        AccountUser currentAccount = null;
        Integer currentUserRoleId = null;

        try {
            currentAccount = (AccountUser) session.getAttribute("account");
            if (currentAccount != null) {
                currentUserRoleId = currentAccount.getRole();
            }
        } catch (ClassCastException e) {
            System.err.println("Lỗi ép kiểu AccountUser trong session: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.setAttribute("currentUserRole", currentUserRoleId);

        List<AccountUser> allUsers = userService.getAllUser();
        System.out.println("allUsers: " + allUsers.size());
        List<User> staffList = new ArrayList<>();
        List<User> managerList = new ArrayList<>();
        List<AccountUser> staffAccList = new ArrayList<>();
        List<AccountUser> managerAccList = new ArrayList<>();

        if (allUsers != null) {
            final int STAFF_ROLE_ID = 4;
            final int MANAGER_ROLE_ID = 3;

            staffAccList = userService.getAllAccUserByRole(STAFF_ROLE_ID);
            System.out.println("Servlet: Staff acc list size: " + staffAccList.size());
            staffList = userService.getAllUserByAccList(staffAccList);
            System.out.println("Servlet: Staff list size: " + staffList.size());

            managerAccList = userService.getAllAccUserByRole(MANAGER_ROLE_ID);
            System.out.println("Servlet: Manager acc list size: " + managerAccList.size());
            managerList = userService.getAllUserByAccList(managerAccList);
            System.out.println("Servlet: Manager list size: " + managerList.size());

        }
        request.setAttribute("staffList", staffList);
        request.setAttribute("managerList", managerList);

        System.out.println("Servlet: Current User Role ID for JSP: " + currentUserRoleId);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/management-employee.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}