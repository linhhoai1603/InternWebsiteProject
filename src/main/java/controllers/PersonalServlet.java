package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Address;
import models.User;
import services.AddressService;
import services.UploadService;
import services.UserInForServies;
import services.UserService;

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
            response.sendRedirect(request.getContextPath() + "/login-user");
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

        String finalEmail = user.getEmail();
        String finalFirstName = (firstNameFromForm == null || firstNameFromForm.trim().isEmpty()) ? user.getFirstname() : firstNameFromForm.trim();
        String finalLastName = (lastNameFromForm == null || lastNameFromForm.trim().isEmpty()) ? user.getLastname() : lastNameFromForm.trim();
        String finalPhoneNumber = (phoneNumberFromForm == null || phoneNumberFromForm.trim().isEmpty()) ? user.getNumberPhone() : phoneNumberFromForm.trim();
        String finalProvince = (provinceFromForm == null || provinceFromForm.trim().isEmpty()) ? currentAddress.getProvince() : provinceFromForm;
        String finaldistrict = (districtFromForm == null || districtFromForm.trim().isEmpty()) ? currentAddress.getDistrict() : districtFromForm;
        String finalward = (wardFromForm == null || wardFromForm.trim().isEmpty()) ? currentAddress.getWard() : wardFromForm;
        String finalDetail = detailFromForm;
        if(wardFromForm == null) finalDetail = currentAddress.getDetail();
        UserInForServies userInForServies = new UserInForServies();
        boolean success = userInForServies.updateInfo(idUser,idAddress,emailFromForm,
                finalFirstName,finalLastName,finalPhoneNumber,finalProvince,finaldistrict,finalward,finalDetail);
        
        if (success) {
            request.setAttribute("message", "Cập nhật thông tin thành công!");
            request.setAttribute("messageType", "success");

            UserService userService = new UserService();
            User updatedUser = userService.getUserById(idUser);
            if (updatedUser != null) {
                session.setAttribute("user", updatedUser);
                request.setAttribute("user", updatedUser);
            }
            
        } else {
            request.setAttribute("message", "Cập nhật thông tin thất bại!");
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher("user.jsp").forward(request, response);
    }
}
