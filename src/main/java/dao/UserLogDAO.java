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

    public boolean addLog(UserLog log) {
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
        return false;
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

    public List<UserLog> getLogsByDateRange(java.time.LocalDateTime fromDate, java.time.LocalDateTime toDate) {
        String query = """
            SELECT 
                id,
                user_id AS userId,
                action,
                description,
                ip_address AS ipAddress,
                user_agent AS userAgent,
                created_at AS createdAt,
                level
            FROM user_logs 
            WHERE created_at BETWEEN :fromDate AND :toDate
            ORDER BY created_at DESC
        """;
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                         .bind("fromDate", fromDate)
                         .bind("toDate", toDate)
                         .mapToBean(UserLog.class)
                         .list();
        });
    }

    public List<UserLog> getAllUserLogs() {
        String query = """
            SELECT 
                id,
                user_id AS userId,
                action,
                description,
                ip_address AS ipAddress,
                user_agent AS userAgent,
                created_at AS createdAt,
                level
            FROM user_logs 
            ORDER BY created_at DESC
        """;
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                         .mapToBean(UserLog.class)
                         .list();
        });
    }

    public int getTotalLogs() {
        String sql = "SELECT COUNT(*) FROM user_logs";
        return jdbi.withHandle(handle -> 
            handle.createQuery(sql)
                .mapTo(Integer.class)
                .findOne()
                .orElse(0)
        );
    }

    public List<UserLog> getUserLogsByPage(int offset, int pageSize) {
        String query = """
            SELECT 
                id,
                user_id AS userId,
                action,
                description,
                ip_address AS ipAddress,
                user_agent AS userAgent,
                created_at AS createdAt,
                level
            FROM user_logs 
            ORDER BY created_at DESC
            LIMIT :pageSize OFFSET :offset
        """;
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                         .bind("pageSize", pageSize)
                         .bind("offset", offset)
                         .mapToBean(UserLog.class)
                         .list();
        });
    }
} 