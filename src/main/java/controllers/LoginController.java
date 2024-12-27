package controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.AccountUser;
import models.User;
import services.AuthenServies;


import java.io.IOException;

@WebServlet(name="LoginController" , value = "/login")
public class LoginController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        AuthenServies authen = new AuthenServies();
        AccountUser acc = authen.checkLogin(username, password);
        User user = acc.getUser();
        if(user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("account", acc);
            response.sendRedirect(request.getContextPath() + "/home");
        }else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}