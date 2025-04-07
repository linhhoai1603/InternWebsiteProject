package controllers;

import dao.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;
import java.io.IOException;
import java.util.stream.Collectors;

@WebServlet(name = "CheckDuplicate", value = "/CheckDuplicate")
public class CheckDuplicate extends HttpServlet {
    UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Đọc JSON từ request
            String jsonBody = request.getReader().lines()
                    .collect(Collectors.joining(System.lineSeparator()));
            JSONObject json = new JSONObject(jsonBody);

            String field = json.getString("field");
            String value = json.getString("value");

            System.out.println("Checking duplicate for: " + field + " = " + value);

            // Kiểm tra trong database
            boolean exists = checkInDatabase(field, value);

            // Trả về kết quả
            JSONObject result = new JSONObject().put("exists", exists);
            response.getWriter().print(result.toString());

        } catch (Exception e) {
            System.err.println("CheckDuplicate error: " + e.getMessage());
            response.setStatus(500);
            response.getWriter().print("{\"error\":\"Server error\"}");
        }
    }
    private boolean checkInDatabase(String field, String value) {
        // Triển khai logic kiểm tra trong database
        if ("email".equals(field)) {
            return userDao.isEmailExists(value);
        } else if ("username".equals(field)) {
            return userDao.usernameExists(value);
        }
        return false;
    }
}