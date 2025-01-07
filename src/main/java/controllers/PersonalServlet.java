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

@MultipartConfig
public class PersonalServlet extends HttpServlet {
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int idUser = user.getId();
        int idAddress = user.getAddress() != null ? user.getAddress().getId() : -1;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Part filePart = request.getPart("avatar");
        if(filePart == null || filePart.getSize() == 0) {
            String email = request.getParameter("email");
            String fullname = request.getParameter("fullName");
            String phone = request.getParameter("phoneNumber");
            String province = request.getParameter("province");
            String city = request.getParameter("city");
            String commune = request.getParameter("commune");
            String street = request.getParameter("street");

            UserInForServies sv = new UserInForServies();

            email = (email == null || email.isEmpty()) ? user.getEmail() : email;
            fullname = (fullname == null || fullname.isEmpty()) ? user.getFullName() : fullname;
            phone = (phone == null || phone.isEmpty()) ? user.getNumberPhone() : phone;
            province = (province == null || province.isEmpty()) ? user.getAddress().getProvince() : province;
            city = (city == null || city.isEmpty()) ? user.getAddress().getCity() : city;
            commune = (commune == null || commune.isEmpty()) ? user.getAddress().getCommune() : commune;
            street = (street == null || street.isEmpty()) ? user.getAddress().getStreet() : street;

            if (sv.updateInfo(idUser, idAddress, email, fullname, phone, province, city, commune, street)) {
                user.setEmail(email);
                user.setFullName(fullname);
                user.setNumberPhone(phone);

                if (user.getAddress() != null) {
                    user.getAddress().setProvince(province);
                    user.getAddress().setCity(city);
                    user.getAddress().setCommune(commune);
                    user.getAddress().setStreet(street);
                }

                // Cập nhật lại đối tượng user trong session
                session.setAttribute("user", user);
                request.setAttribute("message", "Cập nhật thành công!");
                request.setAttribute("messageType", "success");

            } else {
                request.setAttribute("message", "Cập nhật thất bại, vui lòng thử lại.");
                request.setAttribute("messageType", "error");
            }

        }else {
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
        }
        request.getRequestDispatcher("user.jsp").forward(request, response);

    }

}