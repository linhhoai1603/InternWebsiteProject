package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.AccountUser;

import java.io.IOException;

@WebFilter(filterName = "AdminFilter" , urlPatterns = "/admin/*")
public class AdminFilter implements Filter {


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false); // Lấy session hiện tại, không tạo mới
        AccountUser acc = (session != null) ? (AccountUser) session.getAttribute("account") : null;

        // Kiểm tra nếu người dùng chưa đăng nhập hoặc không có quyền admin
        if (acc == null || acc.getRole() < 1) {
            response.sendRedirect("../index.jsp");
            return;
        }

        // Nếu người dùng có quyền, cho phép tiếp tục
        filterChain.doFilter(request, response);
    }


    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
