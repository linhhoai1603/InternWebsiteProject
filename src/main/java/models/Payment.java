package models;

import java.time.LocalTime;

public class Payment {
   private int id;
   private Order order;
   private int method;
   private int status;
   private LocalTime timePayment;
   private double price;
   public Payment(){

   }
   public Payment(int id, Order order, int method, int status, LocalTime timePayment) {
       this.id  = id;
       this.order = order;
       this.method = method;
       this.status = status;
       this.timePayment = timePayment;
       this.price = order.calculateLastPrice();
   }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public int getMethod() {
        return method;
    }

    public void setMethod(int method) {
        this.method = method;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public LocalTime getTimePayment() {
        return timePayment;
    }

    public void setTimePayment(LocalTime timePayment) {
        this.timePayment = timePayment;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
