package dao;

import connection.DBConnection;
import models.Product;
import models.Style;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class StyleDao {
    private Jdbi jdbi;
    public StyleDao() {
        jdbi = DBConnection.getConnetion();
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
    public Style getStyleByID(int idStyle){
        String query = "select * from styles where id = ?";
        return jdbi.withHandle(handle -> {
           return handle.createQuery(query)
                   .bind(0, idStyle)
                   .map((rs, ctx) ->{
                       Style style = new Style();
                       style.setId(rs.getInt("id"));
                       style.setName(rs.getString("name"));
                       style.setImage(rs.getString("image"));
                       Product product = new Product();
                       product.setId(rs.getInt("idProduct"));
                       return style;
                   }).list().getFirst();
        });
    }
}
