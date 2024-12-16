package models;

import java.io.Serializable;

public class OrderDetail implements Serializable {
    private int id;
    private int idOrder;
    private Style style;
    private int quantity;
    private double totalPrice;
    private double weight;
    public OrderDetail(int id, int idOrder, Style style, int quantity) {
        this.id = id;
        this.idOrder = idOrder;
        this.style = style;
        this.quantity = quantity;
        this.totalPrice = quantity * style.getProduct().getPrice().getLastPrice();
        this.weight = quantity * 0.5;
    }
    public OrderDetail(){

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

    public Style getStyle() {
        return style;
    }

    public void setStyle(Style style) {
        this.style = style;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
    public double getWeight() {
        return weight;
    }
    public void setWeight(double weight) {
        this.weight = weight;
    }

    @Override
    public String toString() {
        return "DetailOrder{" +
                "id=" + id +
                ", idOrder=" + idOrder +
                ", style=" + style +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                ", weight=" + weight +
                '}';
    }

}
