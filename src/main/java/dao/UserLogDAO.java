package dao;

import connection.DBConnection;
import models.UserLog;
import org.jdbi.v3.core.Jdbi;

import java.util.List;
import java.time.LocalDateTime;

public class UserLogDAO {
    private Jdbi jdbi;

    public UserLogDAO() {
        jdbi = DBConnection.getConnetion();
    }

    public void addLog(UserLog log) {
        String sql = "INSERT INTO user_logs (user_id, action, description, ip_address, user_agent, level) " +
                    "VALUES (:userId, :action, :description, :ipAddress, :userAgent, :level)";
        
        jdbi.withHandle(handle -> 
            handle.createUpdate(sql)
                .bind("userId", log.getUserId())
                .bind("action", log.getAction())
                .bind("description", log.getDescription())
                .bind("ipAddress", log.getIpAddress())
                .bind("userAgent", log.getUserAgent())
                .bind("level", log.getLevel())
                .execute()
        );
    }

    public List<UserLog> getLogsByUserId(int userId) {
        String sql = "SELECT * FROM user_logs WHERE user_id = :userId ORDER BY created_at DESC";
        
        return jdbi.withHandle(handle -> 
            handle.createQuery(sql)
                .bind("userId", userId)
                .mapToBean(UserLog.class)
                .list()
        );
    }

    public List<UserLog> getAllLogs() {
        String sql = "SELECT * FROM user_logs ORDER BY created_at DESC";
        
        return jdbi.withHandle(handle -> 
            handle.createQuery(sql)
                .mapToBean(UserLog.class)
                .list()
        );
    }

    public List<UserLog> getLogsByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        String sql = "SELECT * FROM user_logs WHERE created_at BETWEEN :startDate AND :endDate ORDER BY created_at DESC";
        
        return jdbi.withHandle(handle -> 
            handle.createQuery(sql)
                .bind("startDate", startDate)
                .bind("endDate", endDate)
                .mapToBean(UserLog.class)
                .list()
        );
    }
} 