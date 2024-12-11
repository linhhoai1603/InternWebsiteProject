package models;

public class DetailOrder {
    private int id;
    private int idOrder;
    private Style style;
    private int quantity;
    private double totalPrice;
    public DetailOrder(int id, int idOrder, Style style, int quantity) {
        this.id = id;
        this.idOrder = idOrder;
        this.style = style;
        this.quantity = quantity;
        this.totalPrice = quantity * style.getPrice().getLastPrice();
    }
    public DetailOrder(){

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

    @Override
    public String toString() {
        return "DetailOrder{" +
                "id=" + id +
                ", idOrder=" + idOrder +
                ", style=" + style +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
