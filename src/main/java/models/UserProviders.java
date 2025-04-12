package models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class UserProviders implements Serializable {
    private int id, userId;
    private String providerName, providerId, providerEmail;
    private LocalDateTime createdAt, updatedAt;

    public UserProviders() {
    }

    public UserProviders(int id, int userId, String providerName, String providerId, String providerEmail, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.userId = userId;
        this.providerName = providerName;
        this.providerId = providerId;
        this.providerEmail = providerEmail;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    public String getProviderId() {
        return providerId;
    }

    public void setProviderId(String providerId) {
        this.providerId = providerId;
    }

    public String getProviderEmail() {
        return providerEmail;
    }

    public void setProviderEmail(String providerEmail) {
        this.providerEmail = providerEmail;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
