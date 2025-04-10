package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Locale;

@WebServlet(name = "ChangeLanguage", value = "/ChangeLanguage")
public class ChangeLanguage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lang = request.getParameter("lang");

        HttpSession session = request.getSession();

        if (lang != null) {
            System.out.println(lang);
            if (lang.equals("en")) {
                System.out.println("english");

                session.setAttribute("lang", "en");
                session.setAttribute("locale", new Locale("en"));
            } else if (lang.equals("vi")) {
                System.out.println("vietnamese");

                session.setAttribute("lang", "vi");
                session.setAttribute("locale", new Locale("vi"));
            }
        }
        if (session.getAttribute("locale") == null) {
            session.setAttribute("locale", new Locale("vi"));
        }

        String referer = request.getHeader("referer");

        if (referer == null || referer.trim().isEmpty()) {
            System.out.println(referer);
            referer = request.getContextPath() + "/home";
        }

        response.sendRedirect(referer);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}