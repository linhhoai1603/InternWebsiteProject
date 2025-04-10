package models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class UserTokens implements Serializable {
    private int id;
    private int idUser;
    private String tokenHash;
    private TokenType tokenType;
    private LocalDateTime expiresAt, createdAt;

    public UserTokens() {
    }

    public UserTokens(int id, int idUser, String tokenHash, TokenType tokenType, LocalDateTime expiresAt, LocalDateTime createdAt) {
        this.id = id;
        this.idUser = idUser;
        this.tokenHash = tokenHash;
        this.tokenType = tokenType;
        this.expiresAt = expiresAt;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getTokenHash() {
        return tokenHash;
    }

    public void setTokenHash(String tokenHash) {
        this.tokenHash = tokenHash;
    }

    public TokenType getTokenType() {
        return tokenType;
    }

    public void setTokenType(TokenType tokenType) {
        this.tokenType = tokenType;
    }

    public LocalDateTime getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(LocalDateTime expiresAt) {
        this.expiresAt = expiresAt;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
