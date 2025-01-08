package models;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Order implements Serializable {
   private int id;
   private User user;
   private LocalDateTime timeOrdered;
   private Voucher voucher;
   private String status;
   private double totalPrice;
   private double lastPrice;
   private List<OrderDetail> listOfDetailOrder = new ArrayList<OrderDetail>();
    public Order() {

    }
    public Order(int id, User user, List<OrderDetail> listOfDetailOrder, String status ) {
        this.id = id;
        this.user = user;
        this.timeOrdered = LocalDateTime.now();
        this.status = status;
        this.listOfDetailOrder = listOfDetailOrder;
        this.totalPrice = calculTotalPrice();
    }

    public double getLastPrice() {
        return lastPrice;
    }

    public void setLastPrice(double lastPrice) {
        this.lastPrice = lastPrice;
    }

    private double calculTotalPrice() {
        return 0.0;
    }

    public double calculateLastPrice() {
        return 0.0;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDateTime getTimeOrdered() {
        return timeOrdered;
    }

    public void setTimeOrdered(LocalDateTime timeOrdered) {
        this.timeOrdered = timeOrdered;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public List<OrderDetail> getListOfDetailOrder() {
        return listOfDetailOrder;
    }

    public void setListOfDetailOrder(List<OrderDetail> listOfDetailOrder) {
        this.listOfDetailOrder = listOfDetailOrder;
    }
    public Order(User user, Voucher voucher, String status, double totalPrice, double lastPrice) {
        this.user = user;
        this.timeOrdered = LocalDateTime.now();
        this.voucher = voucher;
        this.status = status;
        this.totalPrice = totalPrice;
        this.lastPrice = lastPrice;
    }
}
