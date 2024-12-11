package models;

public class AccountUser {
    private int id;
    private User user;
    private String username;
    private String password;
    private int role;
    private int locked;

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
}
