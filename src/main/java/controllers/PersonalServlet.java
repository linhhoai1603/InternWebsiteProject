package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.User;
import services.UploadService;
import services.UserInForServies;

import java.io.File;
import java.io.IOException;

@WebServlet(name = "PersonalServlet", value = "/personal-servlet")
@MultipartConfig(
        maxFileSize = 10485760,       // 10MB
        maxRequestSize = 20971520,   // 20MB
        fileSizeThreshold = 0        // Lưu tệp tạm thời ngay lập tức
)
public class PersonalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("user", user);
            request.getRequestDispatcher("user.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            handleUserUpdate(request, response, session, user);
        } catch (Exception e) {
            request.setAttribute("message", "Đã xảy ra lỗi trong quá trình xử lý. Vui lòng thử lại.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("user.jsp").forward(request, response);
        }
    }

    private void handleUserUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session, User user) throws ServletException, IOException {
        int idUser = user.getId();
        int idAddress = (user.getAddress() != null) ? user.getAddress().getId() : -1;

        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            updateUserInformation(request, session, user, idUser, idAddress);
        } else {
            uploadAndSaveAvatar(request, session, user, filePart);
        }
        request.getRequestDispatcher("user.jsp").forward(request, response);
    }

    private void updateUserInformation(HttpServletRequest request, HttpSession session, User user, int idUser, int idAddress) {
        String email = getValueOrDefault(request.getParameter("email"), user.getEmail());
        String fullname = getValueOrDefault(request.getParameter("fullName"), user.getFullName());
        String phone = getValueOrDefault(request.getParameter("phoneNumber"), user.getNumberPhone());
        String province = getValueOrDefault(request.getParameter("province"), user.getAddress() != null ? user.getAddress().getProvince() : null);
        String city = getValueOrDefault(request.getParameter("city"), user.getAddress() != null ? user.getAddress().getCity() : null);
        String commune = getValueOrDefault(request.getParameter("commune"), user.getAddress() != null ? user.getAddress().getCommune() : null);
        String street = getValueOrDefault(request.getParameter("street"), user.getAddress() != null ? user.getAddress().getStreet() : null);

        UserInForServies service = new UserInForServies();
        boolean isUpdated = service.updateInfo(idUser, idAddress, email, fullname, phone, province, city, commune, street);

        if (isUpdated) {
            user.setEmail(email);
            user.setFullName(fullname);
            user.setNumberPhone(phone);

            if (user.getAddress() != null) {
                user.getAddress().setProvince(province);
                user.getAddress().setCity(city);
                user.getAddress().setCommune(commune);
                user.getAddress().setStreet(street);
            }

            session.setAttribute("user", user);
            request.setAttribute("message", "Cập nhật thành công!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Cập nhật thất bại, vui lòng thử lại.");
            request.setAttribute("messageType", "error");
        }
    }

    private void uploadAndSaveAvatar(HttpServletRequest request, HttpSession session, User user, Part filePart) throws IOException {
        String fileName = filePart.getSubmittedFileName();
        File tempFile = File.createTempFile("upload_", "_" + fileName);
        filePart.write(tempFile.getAbsolutePath());

        UploadService uploadService = new UploadService();
        String imageUrl = uploadService.uploadCloud(fileName, tempFile);

        if (imageUrl != null) {
            UserInForServies userService = new UserInForServies();
            userService.updateAvatar(user.getId(), imageUrl);

            user.setImage(imageUrl);
            session.setAttribute("user", user);

            request.setAttribute("message", "Cập nhật thành công!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Ảnh tải lên không thành công.");
            request.setAttribute("messageType", "error");
        }

        tempFile.delete(); // Xóa tệp tạm
    }

    private String getValueOrDefault(String value, String defaultValue) {
        return (value == null || value.isEmpty()) ? defaultValue : value;
    }
}
