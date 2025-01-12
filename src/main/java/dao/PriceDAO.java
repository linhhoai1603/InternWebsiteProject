package dao;

import connection.DBConnection;
import models.Price;
import org.jdbi.v3.core.Jdbi;

public class PriceDAO {
    Jdbi jdbi;
    public PriceDAO(){
        jdbi = DBConnection.getConnetion();
    }
    public int addPrice(Price price) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO prices (price, discountPercent) " +
                                "VALUES (?, ?)")
                        .bind(0, price.getPrice())
                        .bind(1,price.getDiscountPercent())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one());
    }
}
