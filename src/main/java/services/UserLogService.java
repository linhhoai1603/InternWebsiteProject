package services;

import dao.UserLogDAO;
import models.UserLog;

import java.time.LocalDateTime;
import java.util.List;

public class UserLogService {
    private UserLogDAO userLogDAO;

    public UserLogService() {
        this.userLogDAO = new UserLogDAO();
    }

    public void logUserActivity(int userId, String action, String description, String ipAddress, String userAgent, String level) {
        UserLog log = new UserLog(userId, action, description, ipAddress, userAgent, level);
        userLogDAO.addLog(log);
    }

    public List<UserLog> getUserLogs(int userId) {
        return userLogDAO.getLogsByUserId(userId);
    }

    public List<UserLog> getAllLogs() {
        return userLogDAO.getAllLogs();
    }

    public List<UserLog> getLogsByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return userLogDAO.getLogsByDateRange(startDate, endDate);
    }
} 