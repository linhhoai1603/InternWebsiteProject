package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;
import services.UserInForServies;

import java.io.IOException;

@WebServlet(name = "Personal" , value = "/personal-user")
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
        city = (city == null || city.isEmpty()) ? user.getAddress().getCity() : city;
        commune = (commune == null || commune.isEmpty()) ? user.getAddress().getCommune() : commune;
        street = (street == null || street.isEmpty()) ? user.getAddress().getStreet() : street;

        if(sv.updateInfo(idUser,idAddress, email, fullname, phone, province, city, commune, street)) {
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

        }else {
            request.setAttribute("message", "Cập nhật thất bại, vui lòng thử lại.");
            request.setAttribute("messageType", "error");
        }
        request.getRequestDispatcher("user.jsp").forward(request, response);

    }
}