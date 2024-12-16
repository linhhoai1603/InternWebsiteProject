package models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Payment implements Serializable {
   private int id;
   private Order order;
   private int method;
   private int status;
   private LocalDateTime timePayment;
   private double price;
   public Payment(){

   }
   public Payment(int id, Order order, int method, int status, LocalDateTime timePayment) {
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

    public LocalDateTime getTimePayment() {
        return timePayment;
    }

    public void setTimePayment(LocalDateTime timePayment) {
        this.timePayment = timePayment;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Payment(int id, Order order, int method, int status, LocalDateTime timePayment, double price) {
        this.id = id;
        this.order = order;
        this.method = method;
        this.status = status;
        this.timePayment = timePayment;
        this.price = price;
    }
}
