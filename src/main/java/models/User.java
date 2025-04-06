package models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class User implements Serializable {
//    private int id;
//    private String email;
//    private String fullName;
//    private String numberPhone;
//    private Address address;
//    private String image;
//    private int orderCount;
//    private double totalSpent;
//
//    public User() {
//
//    }
//
//    public int getId() {
//        return id;
//    }
//
//    public void setId(int id) {
//        this.id = id;
//    }
//
//    public String getEmail() {
//        return email;
//    }
//
//    public void setEmail(String email) {
//        this.email = email;
//    }
//
//    public String getFullName() {
//        return fullName;
//    }
//
//    public void setFullName(String fullName) {
//        this.fullName = fullName;
//    }
//
//    public String getNumberPhone() {
//        return numberPhone;
//    }
//
//    public void setNumberPhone(String numberPhone) {
//        this.numberPhone = numberPhone;
//    }
//
//    public Address getAddress() {
//        return address;
//    }
//
//    public void setAddress(Address address) {
//        this.address = address;
//    }
//    public String getImage() {
//        return image;
//    }
//    public void setImage(String image) {
//        this.image = image;
//    }
//
//    public int getOrderCount() {
//        return orderCount;
//    }
//
//    public void setOrderCount(int orderCount) {
//        this.orderCount = orderCount;
//    }
//
//    public double getTotalSpent() {
//        return totalSpent;
//    }
//
//    public void setTotalSpent(double totalSpent) {
//        this.totalSpent = totalSpent;
//    }
//
//    public User(int id, String email, String fullName, String numberPhone, Address address, String image) {
//        this.id = id;
//        this.email = email;
//        this.fullName = fullName;
//        this.numberPhone = numberPhone;
//        this.address = address;
//        this.image = image;
//    }
//
//    @Override
//    public String toString() {
//        return "User{" +
//                "id=" + id +
//                ", email='" + email + '\'' +
//                ", fullName='" + fullName + '\'' +
//                ", numberPhone='" + numberPhone + '\'' +
//                ", address=" + address.toString() +
//                '}';
//    }

    private int id;
    private String email, firstname, lastname, fullname, phoneNumber;
    private Address address;
    private String image;
    private int orderCount;
    private double totalSpent;
    private LocalDateTime createdAt, updatedAt;

    public User(int id, String email, String firstname, String lastname,
                String phoneNumber, Address address, String image, int orderCount, double totalSpent, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.fullname = firstname + " " + lastname;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.image = image;
        this.orderCount = orderCount;
        this.totalSpent = totalSpent;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public User() {
    }

    public int getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(int orderCount) {
        this.orderCount = orderCount;
    }

    public double getTotalSpent() {
        return totalSpent;
    }

    public void setTotalSpent(double totalSpent) {
        this.totalSpent = totalSpent;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getFullName() {
        return fullname;
    }

    public void setFullName(String fullname) {
        this.fullname = fullname;
    }

    public String getNumberPhone() {
        return phoneNumber;
    }

    public void setNumberPhone(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
