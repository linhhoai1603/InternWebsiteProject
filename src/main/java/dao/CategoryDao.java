package dao;

import com.sun.jdi.connect.spi.Connection;
import connection.DBConnection;
import models.Category;
import org.jdbi.v3.core.Jdbi;

public class CategoryDao {
    public Category findByName(String name){
        Jdbi j = DBConnection.getConnetion();
        String sql = "select * from categories where name = :name";
        return j.withHandle(h->
            h.createQuery(sql)
                    .bind("kind",name)
                    .mapToBean(Category.class)
                    .findFirst().orElse(null)
         );
    }
}
