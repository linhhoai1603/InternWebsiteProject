package dao;

import connection.DBConnection;
import models.Style;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class StyleDao {
    public Style findById(int id) {
        Jdbi j = DBConnection.getConnetion();
        String sql = "SELECT * FROM styles WHERE id = :id";
        return j.withHandle(h ->
                h.createQuery(sql).mapToBean(Style.class).findOne().orElse(null));
    }
    public Style findById(String name) {
        Jdbi j = DBConnection.getConnetion();
        String sql = "SELECT * FROM styles WHERE name = :name";
        return j.withHandle(h ->
                h.createQuery(sql).mapToBean(Style.class).findOne().orElse(null));
    }
    public List<Style> findAll() {
        Jdbi j = DBConnection.getConnetion();
        String sql = "SELECT * FROM styles";
        return j.withHandle(handle ->
                handle.createQuery(sql).mapToBean(Style.class).list());
    }

}
