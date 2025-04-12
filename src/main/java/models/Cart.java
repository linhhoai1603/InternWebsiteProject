
package models;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart implements Serializable {
    private Map<Integer, CartItem> items;
    private int totalQuantity;
    private double totalPrice;
    private Voucher voucher;
    private double shippingFee;
    private double lastPrice;
    private double totalWeight;

    public Cart(Map<Integer, CartItem> items, int totalQuantity, double totalPrice, Voucher voucher, double shippingFee, double lastPrice, double totalWeight) {
        this.items = items;
        this.totalQuantity = totalQuantity;
        this.totalPrice = totalPrice;
        this.voucher = voucher;
        this.shippingFee = shippingFee;
        this.lastPrice = lastPrice;
        this.totalWeight = totalWeight;
    }
    public Cart() {}

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public double getLastPrice() {
        return lastPrice;
    }

    public double getTotalWeight() {
        return totalWeight;
    }

    public void setItems(Map<Integer, CartItem> items) {
        this.items = items;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public void setLastPrice(double lastPrice) {
        this.lastPrice = lastPrice;
    }

    public void setTotalWeight(double totalWeight) {
        this.totalWeight = totalWeight;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "items=" + items +
                ", totalQuantity=" + totalQuantity +
                ", totalPrice=" + totalPrice +
                ", voucher=" + voucher +
                ", shippingFee=" + shippingFee +
                ", lastPrice=" + lastPrice +
                ", totalWeight=" + totalWeight +
                '}';
    }
}
