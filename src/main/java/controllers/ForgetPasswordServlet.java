package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AccountService;
import services.UserService;
import services.application.Code;
import services.application.EmailSender;
import services.application.HashUtil;

@WebServlet(name = "ForgetPasswordServlet", value = "/forget-password")
public class ForgetPasswordServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String method = request.getParameter("method");
        if ("confirmEmail".equals(method)) {
            confirmEmail(request, response);
        }
        if ("confirmCode".equals(method)) {
            confirmCode(request, response);
        }
        if("resetPassword".equals(method)) {
            resetPassword(request, response);
        }
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AccountService accountService = new AccountService();
        String username = (String) request.getSession().getAttribute("username");
        String password1 = HashUtil.encodePasswordBase64(request.getParameter("password1"));
        String password2 = HashUtil.encodePasswordBase64(request.getParameter("password2"));
        if(!password1.equals(password2)) {
            request.setAttribute("error", "Mật khẩu không trùng khớp");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }else {
            accountService.resetPassword(username, password1);
            request.getSession().removeAttribute("username");
            request.getSession().removeAttribute("code");
            request.setAttribute("error", "Đổi mật khẩu thành công, vui lòng đăng nhập lại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }


    private void confirmCode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AccountService accountService = new AccountService();
        Integer code = (Integer) request.getSession().getAttribute("code");
        String username = (String) request.getSession().getAttribute("username");
        if(accountService.checkCode(username, code)) {
            request.getSession().setAttribute("username", username);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }else{
            request.setAttribute("error", "Mã xác nhận không đúng");
            request.getRequestDispatcher("confirm-code.jsp").forward(request, response);
        }
    }

    private void confirmEmail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = new UserService();
        AccountService accountService = new AccountService();
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        if(userService.checkHaveEmail(username, email)) {
            // send email
            int code = Code.createCode();
            EmailSender.sendEMail(email, "Xác nhận mã", "Mã xác nhận của bạn là: " + code);
            accountService.updateCode(username, code);
            request.getSession().setAttribute("code", code);
            request.getSession().setAttribute("username", username);
            request.getRequestDispatcher("confirm-code.jsp").forward(request, response);
        }else{
            // send error
            request.setAttribute("error", "Email hoặc username không đúng");
            request.getRequestDispatcher("confirm-email.jsp").forward(request, response);
        }
    }

}