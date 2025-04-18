
package models;

import models.enums.DiscountType;

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
    private double totalArea;

    // method add an item
    public void add(CartItem item) {
        // kiểm tra số lượng là âm
        if (item.getQuantity() < 0) return;
        int idStyle = item.getStyle().getId();
        // check contain
        if (!items.containsKey(idStyle) || items.get(idStyle) == null) {
            items.put(idStyle, item);
        } else {
            // increment quantity
            CartItem existing = items.get(idStyle);
            existing.setQuantity(existing.getQuantity() + item.getQuantity());
        }
        // method tính tổng số lượng sản phẩm, tổng số lượng tiền và tính tiền ship
        this.calculateInfo();
    }

    // method tính các chi phí
    private void calculateInfo() {
        int totalFabric = 0;
        double price = 0.0;
        int quantity = 0;
        double area = 0.0;
        for (CartItem item : items.values()) {
            quantity += item.getQuantity();
            price += item.getTotalPrice();
            if (item.getStyle().getProduct().getCategory().getId() == 1 || item.getStyle().getProduct().getCategory().getId() == 2) {
                totalFabric += item.getQuantity();
                area += item.getArea() * item.getQuantity();
            }
        }
        // phải trong 10 sản phẩm có ít nhất 5 sản phẩm là vải mới được miễn ship
        if (quantity >= 10 && totalFabric >= 5) {
            this.shippingFee = 0.0;
        } else {
            if (totalFabric <= 3) {
                this.shippingFee = 30000.0; // nếu sản phẩm vải mà bé hơn 3 thì đồng giá 30k
            } else {
                this.shippingFee = 5000.0 * totalFabric;
            }
        }
        if (quantity == 0) {
            this.shippingFee = 0.0;
        }
        // gán giá trị
        this.totalQuantity = quantity;
        this.totalPrice = price;
        this.lastPrice = this.totalPrice + this.shippingFee;
        if (this.voucher != null) {
            if (this.lastPrice >= this.voucher.getMinimumSpend() && this.voucher.getDiscountType() == DiscountType.fixed) {
                this.lastPrice = this.lastPrice - this.voucher.getDiscountValue();
            } else {
                this.lastPrice = this.lastPrice + (this.lastPrice * this.voucher.getDiscountValue() / 100.0);
            }
        }
    }

    // method remove an item
    public void remove(int idStyle) {
        items.remove(idStyle);
        this.calculateInfo();
    }

    // method update quantity for item
    public void updateQuantity(int idStyle, int quantity) {
        CartItem item = items.get(idStyle);
        item.setQuantity(quantity);
        this.calculateInfo();
    }

    // method apply voucher
    public boolean applyVoucher(Voucher voucher) {
        if (totalPrice >= voucher.getMinimumSpend()) {
            this.voucher = voucher;
            this.calculateInfo();
            return true;
        }
        return false;

    }

    public List<CartItem> getValues() {
        return items.values().stream().toList();
    }

    public Cart() {
        this.items = new HashMap<Integer, CartItem>();
        this.totalQuantity = 0;
        this.totalPrice = 0;
        this.voucher = null;
        this.shippingFee = 0;
        this.lastPrice = 0.0;
    }

    public double getLastPrice() {
        return lastPrice;
    }

    public void setLastPrice(double lastPrice) {
        this.lastPrice = lastPrice;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public double getTotalArea() {
        return totalArea;
    }

    public void setTotalArea(double totalArea) {
        this.totalArea = totalArea;
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

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void setItems(Map<Integer, CartItem> items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "items=" + items +
                ", totalQuantity=" + totalQuantity +
                ", totalPrice=" + totalPrice +
                ", voucher=" + voucher +
                ", shippingFee=" + shippingFee +
                '}';
    }
}
