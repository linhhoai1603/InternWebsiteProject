package models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Delivery implements Serializable {
    private int id;
    private int idOrder;
    private int idAddress;
    private String fullName;
    private String phoneNumber;
    private double area;
    private double deliveryFee;
    private String note;
    private String status;
    private LocalDateTime scheduledDateTime;

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

    public int getIdAddress() {
        return idAddress;
    }

    public void setIdAddress(int idAddress) {
        this.idAddress = idAddress;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setNumberPhone(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public double getDeliveryFee() {
        return deliveryFee;
    }

    public void setDeliveryFee(double deliveryFee) {
        this.deliveryFee = deliveryFee;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getScheduledDateTime() {
        return scheduledDateTime;
    }

    public void setScheduledDateTime(LocalDateTime scheduledDateTime) {
        this.scheduledDateTime = scheduledDateTime;
    }

    public Delivery(int idOrder, int idAddress, String fullName, String phoneNumber, double area, double deliveryFee, String note, String status) {
        this.idOrder = idOrder;
        this.idAddress = idAddress;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.area = area;
        this.deliveryFee = deliveryFee;
        this.note = note;
        this.status = status;
        this.scheduledDateTime = LocalDateTime.now().plusDays(2); // Ngày hiện tại + 2 ngày
    }
    public Delivery() {

    }


    @Override
    public String toString() {
        return "Delivery{" +
                "id=" + id +
                ", idOrder=" + idOrder +
                ", idAddress=" + idAddress +
                ", fullName='" + fullName + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", area=" + area +
                ", deliveryFee=" + deliveryFee +
                ", note='" + note + '\'' +
                ", status='" + status + '\'' +
                ", scheduledDateTime=" + scheduledDateTime +
                '}';
    }
}
