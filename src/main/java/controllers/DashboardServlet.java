package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.DashboardService;

@WebServlet(name = "DashboardServlet", value = "/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        DashboardService dashboardService = new DashboardService();
        request.setAttribute("numberOfUsers", dashboardService.getNumberOfUsers());
        request.setAttribute("numberOfVouchers", dashboardService.getNumberOfVouchers());
        request.setAttribute("totalRevenue", dashboardService.getTotalRevenue());
        request.setAttribute("numberOfOrders", dashboardService.getNumberOfOrders());
        request.setAttribute("tenNewOrders", dashboardService.getTenNewOders());
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);

    }
}