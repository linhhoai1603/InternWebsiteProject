package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.User;
import services.UploadService;
import services.UserInForServies;

import java.io.File;
import java.io.IOException;

@WebServlet(name="avatar")
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

        // Lấy file từ form và lưu vào tạm thời
        Part filePart = request.getPart("avarta");
        String fileName = filePart.getSubmittedFileName();
        File tempFile = new File("/tmp/" + fileName);
        filePart.write(tempFile.getAbsolutePath());

        // Upload ảnh lên Cloud (hoặc máy chủ)
        UploadService us = new UploadService();
        String url = us.uploadCloud(fileName, tempFile);

        UserInForServies usf = new UserInForServies();
        if (url != null) {
            // Cập nhật avatar của người dùng
            usf.updateAvatar(user.getId(), url);
            user.setImage(url);
            session.setAttribute("user", user);
            request.setAttribute("message", "Cập nhật thành công!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Ảnh tải lên không thành công");
            request.setAttribute("messageType", "error");
        }

        // Lấy URL của trang trước đó để chuyển hướng
        String redirectTo = request.getHeader("Referer");

        // Chuyển hướng về trang cũ (hoặc trang người dùng)
        if (redirectTo != null) {
            response.sendRedirect(redirectTo); // Chuyển hướng về trang trước đó
        } else {
            // Nếu không tìm thấy URL trước đó, chuyển hướng về trang mặc định (ví dụ: user.jsp)
            request.getRequestDispatcher("user.jsp").forward(request, response);
        }
    }
}
