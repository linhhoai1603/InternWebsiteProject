package dao;

import connection.DBConnection;
import org.jdbi.v3.core.Jdbi;

public class ContactDAO {
    private Jdbi jdbi;
    public ContactDAO() {
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

    public static void main(String[] args) {
        ContactDAO contactDAO = new ContactDAO();
        contactDAO.insertContact(1, "title", "content");
    }
}
