package dao;

import connection.DBConnection;
import models.Cart;
import models.CartItem;
import models.Style;
import models.Voucher;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDate;
import java.util.List;

public class CartDAO {
    Jdbi jdbi;
    public CartDAO() {
        jdbi = DBConnection.getConnetion();
    }
    public int createCart(int userId) {
        return jdbi.withHandle(handle -> {
            String insert = "INSERT INTO cart(idUser) VALUES (:userId)";
            return handle.createUpdate(insert)
                    .bind("userId", userId)
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();
        });
    }
    public Cart getCartByUserId(int userId) {
        return jdbi.withHandle(handle -> {
            String query = "SELECT * FROM cart WHERE idUser = :userId";
            return handle.createQuery(query)
                    .bind("userId", userId)
                    .map((rs, ctx) -> {
                        Cart cart = new Cart();
                        cart.setId(rs.getInt("id"));
                        cart.setIdUser(rs.getInt("idUser"));

                        // kiểm tra nếu voucherId không null trong DB thì set, còn không thì để null
                        int voucherId = rs.getInt("idVoucher");
                        if (!rs.wasNull()) {
//                            cart.setVoucher(voucher);
                        } else {
                            cart.setVoucher(null);
                        }

                        return cart;
                    })
                    .findOne()
                    .orElse(null);
        });
    }

    public List<CartItem> getCartItemsByCartId(int cartId) {
        StyleDao styleDao = new StyleDao();
        return jdbi.withHandle(handle -> {
            String query = "SELECT * FROM cart_items WHERE idCart = :cartId";
            return handle.createQuery(query)
                    .bind("cartId", cartId)
                    .map((rs, ctx) -> {
                        CartItem item = new CartItem();
                        item.setId(rs.getInt("id"));
                        item.setIdCart(rs.getInt("idCart"));
                        int idStyle = rs.getInt("idStyle");
                        Style style = styleDao.getStyleByID(idStyle);
                        item.setStyle(style);
                        item.setQuantity(rs.getInt("quantity"));
                        item.setUnitPrice(rs.getDouble("unitPrice"));
                        item.setAddedDate(rs.getDate("addedAt").toLocalDate());

                        return item;
                    })
                    .list();
        });
    }

    public void addToCart( CartItem newItem) {
        jdbi.useTransaction(handle -> {
            String insertQuery = "INSERT INTO cart_items (idCart, idStyle, quantity, unitPrice, addedAt) " +
                    "VALUES (:idCart, :idStyle, :quantity, :unitPrice, :addedDate)";
            handle.createUpdate(insertQuery)
                    .bind("idCart", newItem.getIdCart())
                    .bind("idStyle", newItem.getStyle().getId())  // assuming style is a simple object, if not you might need to handle it
                    .bind("quantity", newItem.getQuantity())
                    .bind("unitPrice", newItem.getUnitPrice())
                    .bind("addedDate", newItem.getAddedDate())
                    .execute();
        });
    }
    public void updateCartItem(int cartItemId, int quantity, LocalDate addedDate) {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Số lượng phải lớn hơn 0");
        }
        if (addedDate == null) {
            throw new IllegalArgumentException("Ngày thêm vào không được null");
        }

        jdbi.useTransaction(handle -> {
            String updateQuery = "UPDATE cart_items SET quantity = :quantity, addedAt = :addedAt WHERE id = :id";
            handle.createUpdate(updateQuery)
                    .bind("quantity", quantity)
                    .bind("addedAt", addedDate)
                    .bind("id", cartItemId)
                    .execute();
        });
    }
    public void removeCartItem(int idCart,int cartItemId) {
        jdbi.useTransaction(handle -> {
            // Xóa cart item theo ID
            String deleteQuery = "DELETE FROM cart_items WHERE id = :cartItemId And idCart = :idCart";
            handle.createUpdate(deleteQuery)
                    .bind("cartItemId", cartItemId)
                    .bind("idCart", idCart)
                    .execute();
        });
    }
    // Method to apply a voucher to a cart and return the applied Voucher object
    public Voucher applyVoucherToCart(int cartId, String voucherCode, double totalPriceInCart) {
        return jdbi.inTransaction(handle -> {
            // 1. Tìm kiếm thông tin voucher dựa vào mã
            String voucherQuery = "SELECT * FROM vouchers WHERE code = :code AND condition_amount < :totalPriceInCart";
            Voucher voucher = handle.createQuery(voucherQuery)
                    .bind("code", voucherCode)
                    .bind("totalPriceInCart", totalPriceInCart)
                    .mapToBean(Voucher.class)
                    .findOne()
                    .orElse(null);

            if (voucher == null) {
                return null; // Không tìm thấy voucher hoặc giỏ hàng đó không đủ điều kiện
            }

            // 2. Gán voucher cho giỏ hàng
            String updateQuery = "UPDATE cart SET idVoucher = :idVoucher, updatedAt = :now WHERE id = :idCart";
            handle.createUpdate(updateQuery)
                    .bind("idVoucher", voucher.getIdVoucher())
                    .bind("idCart", cartId)
                    .bind("now", LocalDate.now())
                    .execute();

            // 3. Trả về đối tượng voucher đã áp dụng
            return voucher;
        });
    }


}
