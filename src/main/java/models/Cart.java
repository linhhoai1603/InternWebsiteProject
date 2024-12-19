package models;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items;
    private int totalQuantity;
    private double totalPrice;
    private Voucher voucher;
    private double totalArea;
    private double shippingFee;


    // method add an item
    public void add(CartItem item) {
        int idStyle = item.getProduct().getId();
        // check contain
        if(items.containsKey(idStyle)) {
            // increment quantity
            CartItem existing = items.get(idStyle);
            existing.setQuantity(existing.getQuantity() + item.getQuantity());
        }else{
            items.put(idStyle, item);
        }
        totalQuantity += item.getQuantity();
        totalPrice += item.getTotalPrice();
        totalArea += item.getArea();
        this.shippingFee = calculateShippingFee();
    }

    private double calculateShippingFee() {
        int totalFabric = 0;
        for(CartItem item : items.values()) {
            if(item.getProduct().getProduct().getCategory().getId() == 1 || item.getProduct().getProduct().getCategory().getId() == 2){
                totalFabric++;
            }
        }
        // phải trong 10 sản phẩm có ít nhất 5 sản phẩm là vải mới được miễn ship
        if(totalQuantity >= 10 && totalFabric >= 5){
            return 0.0;
        }
        else{
            if(totalFabric <= 3){
                return 30000.0; // nếu sản phẩm vải mà bé hơn 3 thì đồng giá 30k
            }
        }
        return 5000.0 * totalFabric;
    }

    // method remove an item
    public boolean remove(int idStyle){
        return items.remove(idStyle) != null;
    }
    public Cart() {
        this.items = new HashMap<Integer, CartItem>();
        this.totalQuantity = 0;
        this.totalPrice = 0;
        this.voucher = null;
        this.totalArea = 0;
        this.shippingFee = 0;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public double getTotalArea() {
        return totalArea;
    }

    public void setTotalArea(double totalArea) {
        this.totalArea = totalArea;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
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
                ", totalArea=" + totalArea +
                ", shippingFee=" + shippingFee +
                '}';
    }
}
