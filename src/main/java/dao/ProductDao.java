package dao;

import connection.DBConnection;
import models.Category;
import models.Price;
import models.Product;
import models.TechnicalInfo;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ProductDao {
    public Product getProductById(int id) {
        Jdbi j = DBConnection.getConnetion();
        String sql = "select * from products where id = :id";
        return j.withHandle(h->
                h.createQuery(sql).bind("id",id)
                        .mapToBean(Product.class)
                        .findOne().orElse(null)
                );
    }
    public List<Product> getAllProducts() {
        Jdbi jdbi = DBConnection.getConnetion();
        String sql = "select * from products";
        List<Product> list = jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Product.class).list());
        return list;
    }
    public Product getProductById(String name) {
        Jdbi j = DBConnection.getConnetion();
        String sql = "select * from products where name = :name";
        return j.withHandle(h->
                h.createQuery(sql).bind("name",name)
                        .mapToBean(Product.class)
                        .findOne().orElse(null)
        );
    }
    public List<Product> getProductByCategory(String name) {
        Jdbi jdbi = DBConnection.getConnetion();
        String sql = """
       SELECT
           p.id, p.name, p.quantity, p.addedDate, p.description, p.area, p.selling, p.img,
           c.id AS category_id, c.name AS category_name,
           pr.id AS price_id, pr.price, pr.discountPercent, pr.lastPrice,
           ti.id AS technical_info_id, ti.specifications, ti.manufactureDate
       FROM
           products p
       JOIN
           categories c ON p.idCategory = c.id
       JOIN
           prices pr ON p.idPrice = pr.id
       LEFT JOIN
           technical_information ti ON p.idTechnical = ti.id
       WHERE
           c.name = :categoryName
       LIMIT 6
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryName", name)
                        .map((rs, ctx) -> {

                            Category category = new Category();
                            category.setId(rs.getInt("category_id"));
                            category.setName(rs.getString("category_name"));

                            Product product = new Product();
                            product.setId(rs.getInt("id"));
                            product.setName(rs.getString("name"));
                            product.setQuantity(rs.getInt("quantity"));
                            product.setDate(rs.getTimestamp("addedDate").toLocalDateTime());
                            product.setDescription(rs.getString("description"));
                            product.setArea(rs.getDouble("area"));
                            product.setSelling(rs.getInt("selling"));
                            product.setImage(rs.getString("img"));
                            product.setCategory(category); // Gắn Category vào Product

                            TechnicalInfo technicalInfo = new TechnicalInfo();
                            technicalInfo.setId(rs.getInt("technical_info_id"));
                            technicalInfo.setSpecification(rs.getString("specifications"));
                            technicalInfo.setManufactureDate(rs.getDate("manufactureDate"));
                            product.setTechnicalInfo(technicalInfo);

                            Price price = new Price();
                            price.setId(rs.getInt("price_id"));
                            price.setPrice(rs.getDouble("price"));
                            price.setDiscountAmount(rs.getDouble("discountPercent"));
                            price.setLastPrice(rs.getDouble("lastPrice"));
                            product.setPrice(price);

                            return product;
                        })
                        .list()
        );
    }

    public static void main(String[] args) {
        ProductDao dao = new ProductDao();
        System.out.println(dao.getProductByCategory("Vải may mặc"));
    }

}

