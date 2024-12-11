package controllers.admin;

import dao.AccountDao;
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

@WebServlet(name = "AdminController" , value="/admin")
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        AccountDao accountDao = new AccountDao();
        AccountUser acc = accountDao.findByUserId(user.getId());

        if (acc.getRole()<1 && acc==null) {
            response.sendRedirect("login.jsp");
            return;
        }
        ///Trang này làm cho zui hoi hihi
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý POST request
    }
}