package dao;

import connection.DBConnection;
import models.Product;
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
    public Product getProductByCategory(String name) {
        Jdbi jdbi = DBConnection.getConnetion();
        CategoryDao categoryDao = new CategoryDao();
        return null;
    }
}
