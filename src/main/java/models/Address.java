package models;

import java.io.Serializable;

public class Address implements Serializable {
    private int id;
    private String province;
    private String city;
    private String commune;
    private String street;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCommune() {
        return commune;
    }

    public void setCommune(String commune) {
        this.commune = commune;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public Address(int id, String province, String city, String commune, String street) {
        this.id = id;
        this.province = province;
        this.city = city;
        this.commune = commune;
        this.street = street;
    }
    public Address() {
        super();
    }
    public String getAddressDetail(){
        return this.street + ", " + this.commune + ", " + this.city + ", " + this.province;
    }
    @Override
    public String toString() {
        return "Address{" +
                "id=" + id +
                ", province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", commune='" + commune + '\'' +
                ", street='" + street + '\'' +
                '}';
    }
}
