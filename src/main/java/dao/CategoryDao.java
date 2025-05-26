package dao;

import com.sun.jdi.connect.spi.Connection;
import connection.DBConnection;
import models.Category;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CategoryDao {
    public Category findByName(String name){
        Jdbi j = DBConnection.getConnetion();
        String sql = "select * from categories where name = :name";
        return j.withHandle(h->
            h.createQuery(sql)
                    .bind("name",name)
                    .mapToBean(Category.class)
                    .findFirst().orElse(null)
         );
    }
    public Category findById(int id){
        Jdbi j = DBConnection.getConnetion();
        String sql = "select * from categories where id = :id";
        return j.withHandle(h->
                h.createQuery(sql)
                        .bind("id",id)
                        .mapToBean(Category.class)
                        .findFirst().orElse(null)
        );
    }

    public List<Category> findAll() {
        Jdbi j = DBConnection.getConnetion();
        String sql = "select * from categories";
        return j.withHandle(h ->
            h.createQuery(sql)
                .mapToBean(Category.class)
                .list()
        );
    }

    public static void main(String[] args) {
        CategoryDao dao = new CategoryDao();
        System.out.println(dao.findById(1));
    }

}
