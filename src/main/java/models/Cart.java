
package models;

import java.io.Serializable;
import java.util.List;

public class Cart implements Serializable {
   private int id;
   private int idUser;
   private double shippingFee;
    private double totalPrice;
    private int totalQuantity;
    private int totalItems;
   private List<CartItem> cartItems;

    public Cart(int id, int idUser) {
        this.id = id;
        this.idUser = idUser;
    }
    public Cart(){

    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = cartItems;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }


    @Override
    public String toString() {
        return "Cart{" +
                "id=" + id +
                ", idUser=" + idUser +
                ", shippingFee=" + shippingFee +
                ", cartItems=" + cartItems +
                '}';
    }
}
