package dao;

import connection.DBConnection;
import models.Style;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class StyleDao {
    private Jdbi jdbi;
    public StyleDao() {
        jdbi = DBConnection.getConnetion();
    }
    public Style findById(int id) {

        String sql = "SELECT * FROM styles WHERE id = :id";
        return jdbi.withHandle(h ->
                h.createQuery(sql).mapToBean(Style.class).findOne().orElse(null));
    }
    public Style findById(String name) {

        String sql = "SELECT * FROM styles WHERE name = :name";
        return jdbi.withHandle(h ->
                h.createQuery(sql).mapToBean(Style.class).findOne().orElse(null));
    }
    public List<Style> findAll() {

        String sql = "SELECT * FROM styles";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapToBean(Style.class).list());
    }
    public List<Style> getAllStylesByIDProduct(int idProduct){
        String query = "select * from styles where idProduct = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, idProduct)
                    .mapToBean(Style.class)
                    .list();
        });
}
