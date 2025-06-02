package models;

import java.time.LocalDateTime;

public class Payment {
    private int id;
    private int idOrder;
    private int method; // 1: COD, 2: VNPAY
    private String status; // "Pending", "Completed", "Failed"
    private LocalDateTime time;
    private double price;
    private String vnpTxnRef;

    public Payment() {
    }

    public Payment(int idOrder, int method, String status, LocalDateTime time, double price, String vnpTxnRef) {
        this.idOrder = idOrder;
        this.method = method;
        this.status = status;
        this.time = time;
        this.price = price;
        this.vnpTxnRef = vnpTxnRef;
    }

    // Getters and Setters
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

    public int getMethod() {
        return method;
    }

    public void setMethod(int method) {
        this.method = method;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getVnpTxnRef() {
        return vnpTxnRef;
    }

    public void setVnpTxnRef(String vnpTxnRef) {
        this.vnpTxnRef = vnpTxnRef;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "id=" + id +
                ", idOrder=" + idOrder +
                ", method=" + method +
                ", status='" + status + '\'' +
                ", time=" + time +
                ", price=" + price +
                ", vnpTxnRef='" + vnpTxnRef + '\'' +
                '}';
    }
}