package models;

import java.io.Serializable;

public class Message implements Serializable {
    private int id;
    private User user;
    private String title;
    private String content;

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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Message(String content, String title, User user, int id) {
        this.content = content;
        this.title = title;
        this.user = user;
        this.id = id;
    }
    public Message() {

    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", user=" + user +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}
