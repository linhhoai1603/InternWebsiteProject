package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.UserLog;
import services.UserLogService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "ManagerLoggingServlet", urlPatterns = {"/manager-logging"})
public class ManagerLoggingServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;
    private UserLogService userLogService;

    @Override
    public void init() throws ServletException {
        userLogService = new UserLogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get filter parameters
            String level = request.getParameter("logLevel");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            
            // Parse dates if provided
            LocalDateTime fromDate = null;
            LocalDateTime toDate = null;
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                fromDate = LocalDateTime.parse(fromDateStr + "T00:00:00");
            }
            if (toDateStr != null && !toDateStr.isEmpty()) {
                toDate = LocalDateTime.parse(toDateStr + "T23:59:59");
            }

            // Get logs
            List<UserLog> logs;
            if (fromDate != null && toDate != null) {
                logs = userLogService.getLogsByDateRange(fromDate, toDate);
            } else {
                logs = userLogService.getAllLogs();
            }

            // Filter by level if specified
            if (level != null && !level.isEmpty()) {
                logs = logs.stream()
                    .filter(log -> log.getLevel().equals(level))
                    .toList();
            }

            // Calculate pagination
            int totalLogs = logs.size();
            int totalPages = (int) Math.ceil((double) totalLogs / PAGE_SIZE);
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
                if (page > totalPages) page = totalPages;
            } catch (NumberFormatException e) {
                // Default to page 1 if invalid page number
            }

            // Get logs for current page
            int start = (page - 1) * PAGE_SIZE;
            int end = Math.min(start + PAGE_SIZE, totalLogs);
            List<UserLog> pageLogs = logs.subList(start, end);

            // Set attributes for JSP
            request.setAttribute("logs", pageLogs);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("selectedLevel", level);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("toDate", toDateStr);

            // Forward to JSP
            request.getRequestDispatcher("admin/manager-logging.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }
    }
} 