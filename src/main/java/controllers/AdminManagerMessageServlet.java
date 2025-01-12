package controllers;import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.MessageService;

@WebServlet(name = "AdminManagerMessageServlet", value = "/admin/manager-message")
public class AdminManagerMessageServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        MessageService  messageService = new MessageService();
        request.setAttribute("messages", messageService.getAllMessages());
        request.getRequestDispatcher("management-message.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        MessageService messageService = new MessageService();
        request.setAttribute("messages", messageService.getAllMessages(name));
        request.getRequestDispatcher("management-message.jsp").forward(request, response);
    }
}