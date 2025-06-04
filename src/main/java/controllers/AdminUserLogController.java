package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.UserLog;
import services.UserLogService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manager-logging")
public class AdminUserLogController extends HttpServlet {
    private UserLogService userLogService;
    private static final int PAGE_SIZE = 10; // Number of logs per page

    @Override
    public void init() throws ServletException {
        userLogService = new UserLogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get page number from request parameter, default to 1 if not specified
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                // Invalid page number, use default
            }

            // Get total number of logs for pagination
            int totalLogs = userLogService.getTotalLogs();
            int totalPages = (int) Math.ceil((double) totalLogs / PAGE_SIZE);

            // Get logs for current page
            List<UserLog> userLogs = userLogService.getUserLogsByPage(page, PAGE_SIZE);
            
            // Set attributes for JSP
            request.setAttribute("userLogs", userLogs);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("pageSize", PAGE_SIZE);
            
            request.getRequestDispatcher("/admin/user-logs.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving user logs");
        }
    }
} 