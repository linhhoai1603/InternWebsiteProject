package models;

import java.time.LocalDateTime;

public class OrderDisplayInfor {
    private int idOrder;
    private LocalDateTime timeOrderedRaw;
    private String timeOrdered;
    private String personName;
    private String address;
    private Cart cart;
    private String methodPayment;
    private String note;

    public OrderDisplayInfor() {
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

    public LocalDateTime getTimeOrderedRaw() {
        return timeOrderedRaw;
    }

    public void setTimeOrderedRaw(LocalDateTime timeOrderedRaw) {
        this.timeOrderedRaw = timeOrderedRaw;
    }

    public String getTimeOrdered() {
        return timeOrdered;
    }

    public void setTimeOrdered(String timeOrdered) {
        this.timeOrdered = timeOrdered;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public String getMethodPayment() {
        return methodPayment;
    }

    public void setMethodPayment(String methodPayment) {
        this.methodPayment = methodPayment;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
