package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Address;
import models.User;
import services.UserInForServies;

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        int idUser = user.getId();
        int idAddress = -1;
        Address currentAddress = user.getAddress();

        if (currentAddress != null) {
            idAddress = currentAddress.getId();
        }

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String emailFromForm = request.getParameter("email");
        String firstNameFromForm = request.getParameter("firstname");
        String lastNameFromForm = request.getParameter("lastname");
        String phoneNumberFromForm = request.getParameter("phoneNumber");
        String provinceFromForm = request.getParameter("province");
        String districtFromForm = request.getParameter("district");
        String wardFromForm = request.getParameter("ward");
        String detailFromForm = request.getParameter("detail");

        UserInForServies sv = new UserInForServies();

        String finalEmail = user.getEmail();
        String finalFirstName = (firstNameFromForm == null || firstNameFromForm.trim().isEmpty()) ? user.getFirstname() : firstNameFromForm.trim();
        String finalLastName = (lastNameFromForm == null || lastNameFromForm.trim().isEmpty()) ? user.getLastname() : lastNameFromForm.trim();
        String finalFullname = finalFirstName + " " + finalLastName;
        String finalPhoneNumber = (phoneNumberFromForm == null || phoneNumberFromForm.trim().isEmpty()) ? user.getPhoneNumber() : phoneNumberFromForm.trim();


        Address addressToUpdateOrCreate = (currentAddress == null) ? new Address() : currentAddress;

        // Cập nhật các trường của address
        String finalProvince = (provinceFromForm == null || provinceFromForm.trim().isEmpty()) ? addressToUpdateOrCreate.getProvince() : provinceFromForm.trim();
        String finalDistrict = (districtFromForm == null || districtFromForm.trim().isEmpty()) ? addressToUpdateOrCreate.getDistrict() : districtFromForm.trim();
        String finalWard = (wardFromForm == null || wardFromForm.trim().isEmpty()) ? addressToUpdateOrCreate.getWard() : wardFromForm.trim();
        String finalDetail = (detailFromForm == null || detailFromForm.trim().isEmpty()) ? addressToUpdateOrCreate.getDetail() : detailFromForm.trim();

        User updatedUser = new User();
        updatedUser.setId(idUser);
        updatedUser.setEmail(finalEmail);
        updatedUser.setFirstname(finalFirstName);
        updatedUser.setLastname(finalLastName);
        updatedUser.setFullname(finalFullname);
        updatedUser.setPhoneNumber(finalPhoneNumber);

        Address updatedAddress = new Address();
        updatedAddress.setId(idAddress);
        updatedAddress.setProvince(finalProvince);
        updatedAddress.setDistrict(finalDistrict);
        updatedAddress.setWard(finalWard);
        updatedAddress.setDetail(finalDetail);

        updatedUser.setAddress(updatedAddress);

        boolean success = sv.updateUserAndAddress(updatedUser);

        if (success) {
            user.setFirstname(finalFirstName);
            user.setLastname(finalLastName);
            user.setFullname(finalFullname);
            user.setPhoneNumber(finalPhoneNumber);

            if (currentAddress == null && !finalProvince.isEmpty()) {
                Address newAddress = new Address();
                newAddress.setProvince(finalProvince);
                newAddress.setDistrict(finalDistrict);
                newAddress.setWard(finalWard);
                newAddress.setDetail(finalDetail);
                user.setAddress(newAddress);
            } else if (currentAddress != null) {
                currentAddress.setProvince(finalProvince);
                currentAddress.setDistrict(finalDistrict);
                currentAddress.setWard(finalWard);
                currentAddress.setDetail(finalDetail);
            }
            user.setAddress(updatedAddress);

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
