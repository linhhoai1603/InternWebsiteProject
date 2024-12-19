package models;

import java.util.Map;

public class CartItem {
   private Style product;
   private int quantity;
   private double totalPrice;
   private double area;
   public CartItem(Style product) {
       this.product = product;
       this.quantity = 1;
       this.totalPrice = product.getProduct().getPrice().getLastPrice();
       this.area = product.getProduct().getArea();
   }
   public CartItem(Style product, int quantity) {
       this.product = product;
       this.quantity = quantity;
       this.totalPrice = quantity * product.getProduct().getPrice().getLastPrice();
       this.area = quantity * product.getProduct().getArea();
   }
   public Style getProduct() {
       return product;
   }
   public void setProduct(Style product) {
       this.product = product;
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
   public double getArea() {
       return area;
   }
   public void setArea(double area) {
       this.area = area;
   }
   public String toString(){
       return this.product.toString() + " " + this.quantity + " " + this.totalPrice + " " + this.area;
   }

}
