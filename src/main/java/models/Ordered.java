package models;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

public class Ordered {
    private Cart cart;
    private int idOrder;
    private LocalDateTime timeOrdered;
    private String personName;
    private String note;
    private String address;
    private String status;
    private double lastPrice;
    private String methodPayment;

    public double getLastPrice() {
        return lastPrice;
    }

    public void setLastPrice(double lastPrice) {
        this.lastPrice = lastPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Ordered(Cart cart, int idOrder, LocalDateTime timeOrdered, String personName,
                   String note, String address, String status, double lastPrice, String methodPayment) {
        this.cart = cart;
        this.idOrder = idOrder;
        this.timeOrdered = timeOrdered;
        this.personName = personName;
        this.note = note;
        this.address = address;
        this.status = status; // Thêm status
        this.lastPrice = lastPrice; // Thêm lastPrice
        this.methodPayment = methodPayment;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

    public LocalDateTime getTimeOrdered() {
        return timeOrdered;
    }

    public void setTimeOrdered(LocalDateTime timeOrdered) {
        this.timeOrdered = timeOrdered;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMethodPayment() {
        return methodPayment;
    }

    public void setMethodPayment(String methodPayment) {
        this.methodPayment = methodPayment;
    }

    public Ordered(Cart cart, int idOrder, LocalDateTime timeOrdered, String personName, String note, String address, String methodPayment) {
        this.cart = cart;
        this.idOrder = idOrder;
        this.timeOrdered = timeOrdered;
        this.personName = personName;
        this.note = note;
        this.address = address;
        this.methodPayment = methodPayment;
    }

    public Ordered() {
    }

}
