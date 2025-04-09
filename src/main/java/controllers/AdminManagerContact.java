package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.ContactInfo;
import services.ContactInfoService;
import services.DeliveryService;

@WebServlet(name = "AdminManagerContact", value = "/admin/manager-Contact")
public class AdminManagerContact extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String message = request.getParameter("message");
        ContactInfoService cis = new ContactInfoService();
        ContactInfo ci = cis.getContactInfo(1);

        request.setAttribute("message",message);
        request.setAttribute("contactInfo", ci);
        request.getRequestDispatcher("/admin/manager-contact.jsp").forward(request, response);

    }

}