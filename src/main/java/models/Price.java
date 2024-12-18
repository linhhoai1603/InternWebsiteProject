package models;

import java.io.Serializable;

public class Price implements Serializable {
     private int id;
     private double price;
     private double discountPercent;
     private double lastPrice;

    public Price(int id, double price, double discountPercent, double lastPrice) {
        this.id = id;
        this.price = price;
        this.discountPercent= discountPercent;
        this.lastPrice = price - (discountPercent * lastPrice);
    }
    public Price(){

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountAmount) {
        this.discountPercent = discountAmount;
    }

    public double getLastPrice() {
        return lastPrice;
    }

    public void setLastPrice(double lastPrice) {
        this.lastPrice = lastPrice;
    }

    @Override
    public String toString() {
        return "Price{" +
                "id=" + id +
                ", price=" + price +
                ", discountAmount=" + discountPercent +
                ", lastPrice=" + lastPrice +
                '}';
    }
}
