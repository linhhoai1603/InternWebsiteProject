package dao;

import connection.DBConnection;
import models.Message;
import models.User;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class MessageDAO {
    private Jdbi jdbi;
    public MessageDAO() {
        jdbi = DBConnection.getConnetion();
    }
    public void insertContact(int idUser, String title, String content) {
        String query = "INSERT INTO message (idUser, title, content) " +
                "VALUES (?, ?, ?)";
        jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, idUser)
                    .bind(1, title)
                    .bind(2, content)
                    .execute();
        });
    }


    public List<Message> getAllMessages() {
        String query = """
        SELECT m.*, u.fullNameGenerated, u.email, u.phoneNumber
        FROM message m
        JOIN users u ON m.idUser = u.id
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .map((rs, ctx) -> {

                            // Map the user data
                            User user = new User();
                            user.setId(rs.getInt("idUser"));
                            user.setFullname(rs.getString("fullNameGenerated"));
                            user.setEmail(rs.getString("email"));
                            user.setPhoneNumber(rs.getString("phoneNumber"));

                            // Map the message data
                            Message message = new Message();
                            message.setId(rs.getInt("id"));
                            message.setTitle(rs.getString("title"));
                            message.setContent(rs.getString("content"));

                            // Set the user to the message
                            message.setUser(user);

                            return message;
                        })
                        .list()
        );
    }
    public List<Message> getAllMessages(String name) {
        String query = """
        SELECT m.*, u.fullNameGenerated, u.email, u.phoneNumber
        FROM message m
        JOIN users u ON m.idUser = u.id
        WHERE u.fullNameGenerated LIKE :name
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("name", "%" + name + "%") // Bind the input name with wildcard for partial match
                        .map((rs, ctx) -> {
                            // Map the user data
                            User user = new User();
                            user.setId(rs.getInt("idUser"));
                            user.setFullname(rs.getString("fullNameGenerated"));
                            user.setEmail(rs.getString("email"));
                            user.setPhoneNumber(rs.getString("phoneNumber"));

                            // Map the message data
                            Message message = new Message();
                            message.setId(rs.getInt("id"));
                            message.setTitle(rs.getString("title"));
                            message.setContent(rs.getString("content"));

                            // Set the user to the message
                            message.setUser(user);

                            return message;
                        })
                        .list()
        );
    }

}
