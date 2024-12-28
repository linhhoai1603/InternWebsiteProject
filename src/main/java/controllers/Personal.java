package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;

import java.io.IOException;

@WebServlet(name = "/Personal" , value = "/personal")
public class Personal extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("user.jsp").forward(request, response);
            }else{
                response.sendRedirect(request.getContextPath() + "/login");
            }
        }else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullName");
        String phone = request.getParameter("numberPhone");
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String commune = request.getParameter("commune");
        String street = request.getParameter("street");


    }
}