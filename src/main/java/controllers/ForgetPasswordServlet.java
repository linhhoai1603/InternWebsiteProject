package controllers;

import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Pattern;

import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AccountService;
import services.UserService;
import services.application.Code;
import services.application.EmailSender;
import services.application.HashUtil;
import com.google.gson.Gson;

@WebServlet(name = "ForgetPasswordServlet", value = "/forget-password")
public class ForgetPasswordServlet extends HttpServlet {
    private final Gson gson = new Gson();
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");

    // Giả lập các service (trong thực tế bạn sẽ inject hoặc tạo instance)
    private final UserService userService = new UserService();
    UserDao userDao = new UserDao();
    private final AccountService accountService = new AccountService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();
        String method = request.getParameter("method");

        try {
            switch (method) {
                case "confirmEmail":
                    confirmEmail(request, response, jsonResponse);
                    break;
                case "confirmCode":
                    confirmCode(request, response, jsonResponse);
                    break;
                case "resetPassword":
                    resetPassword(request, response, jsonResponse);
                    break;
                default:
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Invalid action specified.");
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    break;
            }
        } catch (Exception e) {
            // Log lỗi server chi tiết
            log("Error processing forget password request", e); // Sử dụng log của Servlet container
            jsonResponse.put("success", false);
            jsonResponse.put("message", "An internal server error occurred. Please try again later.");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        out.print(gson.toJson(jsonResponse));
        out.flush();
    }

    private void confirmEmail(HttpServletRequest request, HttpServletResponse response, Map<String, Object> jsonResponse) throws Exception {
        String email = request.getParameter("email");

        // 1. Validate Input
        if (email == null || email.trim().isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Email address cannot be empty.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        email = email.trim();
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid email format.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // 2. Check if email exists
        // *** THAY THẾ BẰNG LOGIC THỰC TẾ CỦA BẠN ***
        boolean emailExists = userDao.isEmailExists(email); // Giả định phương thức này tồn tại

        if (!emailExists) {
            // Trả về thông báo chung chung để tránh tiết lộ email nào đã đăng ký
            jsonResponse.put("success", false);
            jsonResponse.put("message", "If the email address is registered, a verification code will be sent.");
            // Vẫn trả về 200 OK để không cho biết email có tồn tại hay không
            return;
        }

        // 3. Generate Code, Update DB, Send Email, Update Session
        try {
            String code = Code.createCode();
            System.out.println("code của bạn " + code);

            // *** THAY THẾ BẰNG LOGIC THỰC TẾ CỦA BẠN ***
            boolean updated = accountService.updateCodeByEmail(email, code); // Giả định phương thức này tồn tại

            if (!updated) {
                log("Failed to update verification code for email: " + email); // Ghi log lỗi
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to process request. Please try again later.");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }

            // Gửi email SAU KHI cập nhật DB thành công
            try {
                EmailSender.sendEMail(email, "Password Reset Verification Code", "Your verification code is: " + code);
                log("Verification code sent successfully to: " + email); // Ghi log thành công
            } catch (Exception emailEx) {
                // Nếu gửi email thất bại, vẫn nên cho user biết mã đã được tạo (hoặc xử lý khác)
                // Ở đây ta vẫn tiếp tục, nhưng ghi log lỗi nghiêm trọng
                log("CRITICAL: Failed to send verification email to " + email + " after updating code.", emailEx);
                // Cân nhắc: Có nên rollback việc update code? Hoặc thông báo lỗi khác?
                // Hiện tại: Vẫn trả về success=true để user có thể thử nhập code (nếu họ biết cách lấy)
                // Hoặc trả về lỗi:
                // jsonResponse.put("success", false);
                // jsonResponse.put("message", "Could not send verification email. Please contact support.");
                // response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                // return;
            }


            // Lưu email và code vào session
            HttpSession session = request.getSession(); // Tạo session nếu chưa có
            session.setAttribute("resetEmail", email); // Dùng key khác username
            session.setAttribute("resetCode", code);
            session.setMaxInactiveInterval(15 * 60); // Ví dụ: session timeout 15 phút

            jsonResponse.put("success", true);
            // Không cần message, JS sẽ tự chuyển bước

        } catch (Exception e) {
            log("Error during confirmEmail process for: " + email, e);
            throw e; // Ném lại để được bắt ở doPost và trả về lỗi 500 chung
        }
    }

    private void confirmCode(HttpServletRequest request, HttpServletResponse response, Map<String, Object> jsonResponse) {
        HttpSession session = request.getSession(false); // Lấy session hiện có, không tạo mới
        String userEnteredCodeStr = request.getParameter("verificationCode");

        // 1. Validate Session and Input
        if (session == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Your session has expired. Please start over.");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
            return;
        }

        String email = (String) session.getAttribute("resetEmail");
        String correctCode = (String) session.getAttribute("resetCode");

        if (email == null || correctCode == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid session data. Please start over.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            session.invalidate(); // Hủy session lỗi
            return;
        }

        if (userEnteredCodeStr == null || !userEnteredCodeStr.matches("\\d{5}")) { // Giả sử mã 6 chữ số
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Please enter a valid 5-digit verification code.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // 2. Compare Codes
        if (correctCode.equals(userEnteredCodeStr)) {
            // Thành công! Đánh dấu code đã được xác thực trong session (tùy chọn)
            session.setAttribute("codeVerified", true);
            jsonResponse.put("success", true);
            // Giữ nguyên session cho bước reset password
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid verification code.");
            // Không cần set status, 200 OK là được
        }

    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response, Map<String, Object> jsonResponse) {
        HttpSession session = request.getSession(false);
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 1. Validate Session and Code Verification Status
        if (session == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Your session has expired. Please start over.");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String email = (String) session.getAttribute("resetEmail");
        Boolean codeVerified = (Boolean) session.getAttribute("codeVerified"); // Kiểm tra cờ xác thực

        if (email == null || codeVerified == null || !codeVerified) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Verification step incomplete or session invalid. Please start over.");
            response.setStatus(HttpServletResponse.SC_FORBIDDEN); // 403 Forbidden - Không được phép thực hiện hành động này
            session.invalidate(); // Hủy session lỗi/không hợp lệ
            return;
        }

        // 2. Validate Passwords
        if (password == null || password.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Password cannot be empty.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        if (!password.equals(confirmPassword)) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Passwords do not match.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        // *** Thêm kiểm tra độ mạnh mật khẩu phía server nếu cần ***
        if (password.length() < 8) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Password must be at least 8 characters long.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // 3. Hash Password and Update DB
        try {
            String hashedPassword = HashUtil.encodePasswordBase64(password);

            // *** THAY THẾ BẰNG LOGIC THỰC TẾ CỦA BẠN ***
            boolean success = accountService.resetPasswordByEmail(email, hashedPassword); // Giả định phương thức này tồn tại

            if (success) {
                jsonResponse.put("success", true);
                session.invalidate(); // Hủy session thành công sau khi đổi mật khẩu
                log("Password successfully reset for email: " + email);
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to update password. Please try again later.");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                log("Failed to reset password in DB for email: " + email);
            }
        } catch (Exception e) {
            log("Error during password reset for email: " + email, e);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "An error occurred while resetting the password.");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}