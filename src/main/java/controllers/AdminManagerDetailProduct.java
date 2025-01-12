package controllers;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "AdminManagerDetailProduct", value = "/admin-manager-detail-product")
public class AdminManagerDetailProduct extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String method = request.getParameter("method");
        if ("updateStyle".equals(method)) {
            updateStyle(request, response);
        }
        if("deleteStyle".equals(method)){
            deleteStyle(request,response);
        }
    }

    private void deleteStyle(HttpServletRequest request, HttpServletResponse response) {
        
    }

    private void updateStyle(HttpServletRequest request, HttpServletResponse response) {

    }
}