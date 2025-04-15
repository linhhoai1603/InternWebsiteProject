package dao;

import connection.DBConnection;
import models.UserProviders;
import org.jdbi.v3.core.Jdbi;

import java.util.Optional;

public class UserProviderDao {
    private Jdbi jdbi;

    public UserProviderDao() {
        this.jdbi = DBConnection.getJdbi();
    }

    public Jdbi getJdbi() {
        return jdbi;
    }

    public Optional<UserProviders> findByProvider(String providerName, String providerId) {
        String sql = "SELECT id, user_id AS userId, provider_name AS providerName, " +
                "provider_id AS providerId, provider_email AS providerEmail, " +
                "created_at AS createdAt, updated_at AS updatedAt " +
                "FROM user_providers " +
                "WHERE provider_name = :providerName AND provider_id = :providerId";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("providerName", providerName)
                        .bind("providerId", providerId)
                        .mapToBean(UserProviders.class)
                        .findOne()
        );
    }

    public void createProviderLink(UserProviders provider) {
        String sql = "INSERT INTO user_providers (user_id, provider_name, provider_id, provider_email, created_at, updated_at) " +
                "VALUES (:userId, :providerName, :providerId, :providerEmail, NOW(), NOW())";
        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(provider)
                        .execute()
        );
    }
}
