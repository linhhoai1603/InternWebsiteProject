package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.DeliveryService;

@WebServlet(name = "AdminManagerContact", value = "/admin/manager-Contact")
public class AdminManagerContact extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String linkWebsite = request.getParameter("website");
        String hotline = request.getParameter("hotline");

    }

}