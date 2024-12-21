package models;

import java.io.Serializable;

    public class Price implements Serializable {
         private int id;
         private double price;
         private double discountAmount;
         private double lastPrice;

    public Price(int id, double price, double discountAmount, double lastPrice) {
        this.id = id;
        this.price = price;
        this.discountAmount = discountAmount;
        this.lastPrice = price - (discountAmount * lastPrice);
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

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
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
                ", discountAmount=" + discountAmount +
                ", lastPrice=" + lastPrice +
                '}';
    }
}
