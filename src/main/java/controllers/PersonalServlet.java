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

@WebServlet( value="/personal-inf")
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
            city = (city == null || city.isEmpty()) ? user.getAddress().getDistrict() : city;
            commune = (commune == null || commune.isEmpty()) ? user.getAddress().getWard() : commune;
            street = (street == null || street.isEmpty()) ? user.getAddress().getDetail() : street;

            if (sv.updateInfo(idUser, idAddress, email, fullname, phone, province, city, commune, street)) {
                user.setEmail(email);
                user.setFullName(fullname);
                user.setNumberPhone(phone);

                if (user.getAddress() != null) {
                    user.getAddress().setProvince(province);
                    user.getAddress().setDistrict(city);
                    user.getAddress().setWard(commune);
                    user.getAddress().setDetail(street);
                }

                // Cập nhật lại đối tượng user trong session
                session.setAttribute("user", user);
                request.setAttribute("message", "Cập nhật thành công!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Cập nhật thất bại, vui lòng thử lại.");
                request.setAttribute("messageType", "error");
            }
        request.getRequestDispatcher("user.jsp").forward(request, response);

    }

}
