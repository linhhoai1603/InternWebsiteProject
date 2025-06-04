package dao;

import connection.DBConnection;
import models.Category;
import models.Price;
import models.Product;
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

    public List<Style> getAllStylesByIDProduct(int idProduct) {
        String query = "select * from styles where idProduct = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, idProduct)
                    .mapToBean(Style.class)
                    .list();
        });
    }
    public Style getStyleByID(int idStyle) {
        String query = "SELECT s.id, s.name, s.image, s.quantity AS styleQuantity, " +
                "p.id AS idProduct, p.name AS nameProduct, pr.lastPrice, p.idPrice, " +
                "c.id AS idCategory, p.quantity " +
                "FROM styles s " +
                "JOIN products p ON s.idProduct = p.id " +
                "JOIN prices pr ON p.idPrice = pr.id " +
                "JOIN categories c ON p.idCategory = c.id " +
                "WHERE s.id = :idStyle";

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("idStyle", idStyle)
                        .map((rs, ctx) -> {
                            Style style = new Style();
                            style.setId(rs.getInt("id"));
                            style.setName(rs.getString("name"));
                            style.setImage(rs.getString("image"));
                            style.setQuantity(rs.getInt("styleQuantity"));

                            Product product = new Product();
                            product.setId(rs.getInt("idProduct"));
                            product.setName(rs.getString("nameProduct"));
                            product.setQuantity(rs.getInt("quantity"));

                            Price price = new Price();
                            price.setId(rs.getInt("idPrice"));
                            price.setLastPrice(rs.getDouble("lastPrice"));

                            Category category = new Category();
                            category.setId(rs.getInt("idCategory"));

                            product.setCategory(category);
                            product.setPrice(price);
                            style.setProduct(product);

                            return style;
                        })
                        .findFirst()  // Tránh lỗi nếu không có kết quả
                        .orElse(null)
        );
    }



    //Thêm một phương thức mới trong StyleDao để lấy các styles liên quan đến dây kéo:
    public List<Style> getZipperStylesByIDProduct(int idProduct) {
        String query = "SELECT * FROM styles WHERE idProduct = ? AND " +
                "(LOWER(image) LIKE '%zipper%' OR LOWER(image) LIKE '%dây kéo%' " +
                "OR LOWER(image) LIKE '%pull%' OR LOWER(image) LIKE '%buckle%')";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, idProduct)
                    .mapToBean(Style.class)
                    .list();
        });
    }
    public void updateQuantityForStyle(int idStyle, int quantity){
        String query = "UPDATE styles SET quantity = ? WHERE id = ?";
        jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, quantity)
                    .bind(1, idStyle)
                    .execute();
        });
    }
    public void updateQuantityForProduct(int idProduct, int quantity){
        String query = "UPDATE products SET quantity = ? WHERE id = ?";
        jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, quantity)
                    .bind(1, idProduct)
                    .execute();
        });
    }

    public void deleteStyle(int styleId) {
        String query = "DELETE FROM styles WHERE id = ?";
        jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, styleId)
                    .execute();
        });
    }

    public void updateStyle(Style newStyle) {
        String query = "UPDATE styles SET name = ?, quantity = ? WHERE id = ?";
        jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, newStyle.getName())
                    .bind(1, newStyle.getQuantity())
                    .bind(2, newStyle.getId())
                    .execute();
        });
    }

    public void addStyle(Style style) {
        String query = "INSERT INTO styles(name, quantity, image, idProduct) VALUES(?, ?, ?, ?)";
        jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, style.getName())
                    .bind(1, style.getQuantity())
                    .bind(2, style.getImage())
                    .bind(3, style.getProduct().getId())
                    .execute();
        });
    }
}
