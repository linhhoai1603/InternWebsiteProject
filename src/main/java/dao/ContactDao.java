package dao;

import connection.DBConnection;
import models.Address;
import models.ContactInfo;
import org.jdbi.v3.core.Jdbi;

public class ContactDao {
    Jdbi jdbi;
    AddressDao addressDao;
    public ContactDao() {
        jdbi = DBConnection.getConnetion();
    }

    public boolean updateInfContact(int idContact, String email, String website, String hotline) {
        String sql = "UPDATE contact_info SET email = ?, website_link = ?, hot_line = ? WHERE id_contact = ?";

        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, email)
                        .bind(1, website)
                        .bind(2, hotline)
                        .bind(3, idContact)
                        .execute()
        ) > 0;
    }
    public ContactInfo getContactById(int idContact) {
        String sql = "SELECT ci.id_contact, ci.email, ci.website_link, ci.hot_line, a.* " +
                "FROM contact_info ci " +
                "JOIN addresses a ON ci.id_address = a.id " +
                "WHERE ci.id_contact = ?";

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, idContact)
                        .mapTo(ContactInfo.class)
                        .findOne()
                        .orElse(null)
        );
    }
}
