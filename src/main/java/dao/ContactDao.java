package dao;

import connection.DBConnection;
import org.jdbi.v3.core.Jdbi;

public class ContactDao {
    Jdbi jdbi;
    public ContactDao() {
        jdbi = DBConnection.getConnetion();
    }
    public boolean updateInfContact(String email, String website, String hotline){

    }
}
