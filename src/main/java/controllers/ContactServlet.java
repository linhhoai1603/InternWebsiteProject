package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.User;
import services.MessageService;

@WebServlet(name = "ContactServlet", value = "/contact")
public class ContactServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        User user = (User) request.getSession().getAttribute("user");
        int idUser = user.getId();
        // Call the service to insert the contact
        MessageService messageService = new MessageService();
        messageService.insertContact(idUser, title, content);
        request.setAttribute("message", "Tin nhắn của bạn đang được xử lý!");
       request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}