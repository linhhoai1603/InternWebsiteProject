package models;

import java.io.Serializable;

public class ContactInfo implements Serializable {
    private int id_contact;
    private Address address;
    private String email;
    private String website;
    private String hotLine;
    public ContactInfo(int id_contact, Address address, String email, String website, String hotLine) {
        this.id_contact = id_contact;
        this.address = address;
        this.email = email;
        this.website = website;
        this.hotLine = hotLine;
    }
    public ContactInfo(){};

    public int getId_contact() {
        return id_contact;
    }

    public void setId_contact(int id_contact) {
        this.id_contact = id_contact;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getHotLine() {
        return hotLine;
    }

    public void setHotLine(String hotLine) {
        this.hotLine = hotLine;
    }
}
