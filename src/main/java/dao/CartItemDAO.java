package dao;

import connection.DBConnection;
import org.jdbi.v3.core.Jdbi;

public class CartItemDAO {
    Jdbi jdbi;

    public CartItemDAO() {
        jdbi = DBConnection.getConnetion();
    }

    public double getUnitPrice(int cartId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT unitPrice FROM cart_items WHERE idCart = :cartId")
                        .bind("cartId", cartId)
                        .mapTo(Double.class)
                        .findOne()
                        .orElse(0.0)
        );
    }

    public int getIdStyleByidItem(int idItem) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT idStyle FROM cart_items WHERE id = :idItem")
                        .bind("idItem", idItem)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0)
        );
    }
}
