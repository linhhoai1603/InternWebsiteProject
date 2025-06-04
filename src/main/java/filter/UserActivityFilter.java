package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;
import services.UserLogService;

import java.io.IOException;

@WebFilter(filterName = "UserActivityFilter", urlPatterns = {"/*"})
public class UserActivityFilter implements Filter {
    private UserLogService userLogService;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        userLogService = new UserLogService();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Skip logging for static resources and certain paths
        String path = httpRequest.getRequestURI();
        if (shouldSkipLogging(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Get user information if logged in
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // Log the activity
        if (user != null) {
            String action = httpRequest.getMethod() + " " + path;
            String description = "User accessed: " + path;
            String ipAddress = getClientIpAddress(httpRequest);
            String userAgent = httpRequest.getHeader("User-Agent");
            String level = "INFO";

            // Combine details into a single string
            String logDetails = "Action: " + action + ", Description: " + description + ", IP: " + ipAddress + ", User Agent: " + userAgent + ", Level: " + level;

            // Call the new logUserAction method
            userLogService.logUserAction(
                user.getId(),
                action, // Use action as the main action type
                logDetails
            );
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }

    private boolean shouldSkipLogging(String path) {
        // Skip logging for static resources and certain paths
        return path.contains("/css/") ||
               path.contains("/js/") ||
               path.contains("/images/") ||
               path.contains("/fonts/") ||
               path.contains("/assets/") ||
               path.contains("/error/") ||
               path.contains("/favicon.ico");
    }

    private String getClientIpAddress(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0];
        }
        return request.getRemoteAddr();
    }
} 