package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.DeliveryService;

@WebServlet(name = "AdminManagerDeliveries", value = "/admin/manager-deliveries")
public class AdminManagerDeliveries extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        DeliveryService deliveryService = new DeliveryService();
        request.setAttribute("deliveries", deliveryService.getAllDeliveries());
        request.getRequestDispatcher("management-deliveries.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idOrder = request.getParameter("idOrder");
         DeliveryService deliveryService = new DeliveryService();
         request.setAttribute("deliveries", deliveryService.getDeliveryByIdOrder(Integer.parseInt(idOrder)));
         request.getRequestDispatcher("management-deliveries.jsp").forward(request, response);
    }

}