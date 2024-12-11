package models;

import java.time.LocalDateTime;

public class Delivery {
    private int id;
    private int idOrder;
    private int idAddress;
    private String fullName;
    private String numberPhone;
    private double weight;
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

    public String getNumberPhone() {
        return numberPhone;
    }

    public void setNumberPhone(String numberPhone) {
        this.numberPhone = numberPhone;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
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

    public Delivery(int id, int idOrder, int idAddress, String fullName, String numberPhone, double weight, double deliveryFee, String note, String status, LocalDateTime scheduledDateTime) {
        this.id = id;
        this.idOrder = idOrder;
        this.idAddress = idAddress;
        this.fullName = fullName;
        this.numberPhone = numberPhone;
        this.weight = weight;
        this.deliveryFee = deliveryFee;
        this.note = note;
        this.status = status;
        this.scheduledDateTime = scheduledDateTime;
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
                ", numberPhone='" + numberPhone + '\'' +
                ", weight=" + weight +
                ", deliveryFee=" + deliveryFee +
                ", note='" + note + '\'' +
                ", status='" + status + '\'' +
                ", scheduledDateTime=" + scheduledDateTime +
                '}';
    }
}
