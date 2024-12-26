package models;

import java.io.Serializable;

public class AccountUser implements Serializable {
    private int id;
    private User user;
    private String username;
    private String password;
    private int role;
    private int locked;
    private int code;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public int getLocked() {
        return locked;
    }

    public void setLocked(int locked) {
        this.locked = locked;
    }

    @Override
    public String toString() {
        return "AccountUser{" +
                "id=" + id +
                ", user=" + user +
                ", username='" + username + '\'' +
                ", role=" + role +
                ", locked=" + locked +
                '}';
    }

    public AccountUser(int id, User user, String username, String password, int role, int locked) {
        this.id = id;
        this.user = user;
        this.username = username;
        this.password = password;
        this.role = role;
        this.locked = locked;
    }
    public AccountUser() {
    }
}
