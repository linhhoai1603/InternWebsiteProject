package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import models.User;
import services.UploadService;
import services.UserInForServies;

import java.io.File;
import java.io.IOException;

@MultipartConfig
public class AvatarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("Hello, Servlet!");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra xem người dùng có đăng nhập hay không
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }


        Part filePart = request.getPart("avatar");
        String fileName = filePart.getSubmittedFileName();
        File tempFile = new File("/tmp/" + fileName);
        filePart.write(tempFile.getAbsolutePath());


        UploadService us = new UploadService();
        String url = us.uploadCloud(fileName, tempFile);

        UserInForServies usf = new UserInForServies();
        if (url != null) {

            usf.updateAvatar(user.getId(), url);
            user.setImage(url);
            session.setAttribute("user", user);
            request.setAttribute("message", "Cập nhật thành công!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Ảnh tải lên không thành công");
            request.setAttribute("messageType", "error");
        }


        String redirectTo = request.getHeader("Referer");


        if (redirectTo != null) {
            response.sendRedirect(redirectTo); // Chuyển hướng về trang trước đó
        } else {
            // Nếu không tìm thấy URL trước đó, chuyển hướng về trang mặc định (ví dụ: user.jsp)
            request.getRequestDispatcher("user.jsp").forward(request, response);
        }
    }
}