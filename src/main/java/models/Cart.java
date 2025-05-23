
package models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Cart implements Serializable {
    private int id;
    private int idUser;
    private double shippingFee;
    private double totalPrice;
    private int totalQuantity;
    private int totalItems;
    private List<CartItem> cartItems;
    private Voucher appliedVoucher;

    public Cart(int id, int idUser) {
        this.id = id;
        this.idUser = idUser;
        this.cartItems = new ArrayList<>();
        recalculateCartTotals();
    }

    public Cart() {
        this.cartItems = new ArrayList<>();
        recalculateCartTotals();
    }

    public Voucher getAppliedVoucher() {
        return appliedVoucher;
    }

    public void setAppliedVoucher(Voucher appliedVoucher) {
        this.appliedVoucher = appliedVoucher;
    }

    public List<CartItem> getCartItems() {
        if (this.cartItems == null) {
            this.cartItems = new ArrayList<>();
        }
        return cartItems;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = (cartItems == null) ? new ArrayList<>() : cartItems;
        recalculateCartTotals();
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

    public double getDiscountAmount() {
        if (this.appliedVoucher != null && this.appliedVoucher.isApplicable(this.totalPrice)) {
            return this.appliedVoucher.calculateDiscount(this.totalPrice);
        }
        return 0;
    }

    public double getLastPrice() {
        return this.totalPrice - getDiscountAmount() + this.shippingFee;
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

    public void recalculateCartTotals() {
        if (this.cartItems == null || this.cartItems.isEmpty()) {
            this.totalPrice = 0;
            this.totalQuantity = 0;
            this.totalItems = 0;
        } else {
            double currentTotalPrice = 0;
            int currentTotalQuantity = 0;
            for (CartItem item : this.cartItems) {
                if (item != null && item.getStyle() != null) {
                    currentTotalPrice += item.getUnitPrice();
                    currentTotalQuantity += item.getQuantity();
                }
            }
            this.totalPrice = currentTotalPrice;
            this.totalQuantity = currentTotalQuantity;
            this.totalItems = this.cartItems.size();
        }
    }

}
