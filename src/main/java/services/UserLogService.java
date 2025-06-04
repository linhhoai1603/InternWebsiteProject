package services;

import dao.UserLogDAO;
import models.UserLog;

import java.util.List;

public class UserLogService {
    private UserLogDAO userLogDAO;

    public UserLogService() {
        userLogDAO = new UserLogDAO();
    }

    public boolean logUserAction(int userId, String action, String details) {
        UserLog log = new UserLog();
        log.setUserId(userId);
        log.setAction(action);
        log.setCreatedAt(java.time.LocalDateTime.now());
        log.setDescription(details);
        return userLogDAO.addLog(log);
    }

    public List<UserLog> getAllUserLogs() {
        try {
            System.out.println("UserLogService: Getting all user logs");
            List<UserLog> logs = userLogDAO.getAllUserLogs();
            System.out.println("UserLogService: Found " + (logs != null ? logs.size() : 0) + " logs");
            return logs;
        } catch (Exception e) {
            System.out.println("UserLogService: Exception getting all user logs: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public List<UserLog> getLogsByDateRange(java.time.LocalDateTime fromDate, java.time.LocalDateTime toDate) {
        try {
            System.out.println("UserLogService: Getting logs by date range from " + fromDate + " to " + toDate);
            List<UserLog> logs = userLogDAO.getLogsByDateRange(fromDate, toDate);
            System.out.println("UserLogService: Found " + (logs != null ? logs.size() : 0) + " logs in date range");
            return logs;
        } catch (Exception e) {
            System.out.println("UserLogService: Exception getting logs by date range: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public List<UserLog> getAllLogs() {
        return userLogDAO.getAllLogs();
    }

    public int getTotalLogs() {
        try {
            return userLogDAO.getTotalLogs();
        } catch (Exception e) {
            System.out.println("UserLogService: Exception getting total logs: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    public List<UserLog> getUserLogsByPage(int page, int pageSize) {
        try {
            int offset = (page - 1) * pageSize;
            return userLogDAO.getUserLogsByPage(offset, pageSize);
        } catch (Exception e) {
            System.out.println("UserLogService: Exception getting logs by page: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}