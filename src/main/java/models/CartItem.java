
package models;

import java.time.LocalDate;

public class CartItem {
    private int id;
    private int idCart;
    private Style style;
    private int quantity;
    private double unitPrice;
    private LocalDate addedDate;
    public CartItem(int idCart , int idStyle, int quantity) {
        this.idCart = idCart;
        this.style = new Style();
        this.style.setId(idStyle);
        this.quantity = quantity;
        this.addedDate = LocalDate.now();
    }
    public CartItem(){

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCart() {
        return idCart;
    }

    public void setIdCart(int idCart) {
        this.idCart = idCart;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public LocalDate getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(LocalDate addedDate) {
        this.addedDate = addedDate;
    }

    public Style getStyle() {
        return style;
    }
    public void setStyle(Style product) {
        this.style = product;
    }
    public int getQuantity() {
        return quantity;
    }


    // method update số lượng sản phẩm
    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.unitPrice = quantity * style.getProduct().getPrice().getLastPrice();
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "id=" + id +
                ", idCart=" + idCart +
                ", style=" + style +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                ", addedDate=" + addedDate.toString() +
                '}';
    }
}
