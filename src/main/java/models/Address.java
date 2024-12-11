package models;

public class Address {
    private String id;
    private String city;
    private String province;
    private String commune;

    public Address(String id, String city, String province, String commune) {
        this.id = id;
        this.city = city;
        this.province = province;
        this.commune = commune;
    }
    public Address(){};
    public String getId() {return id;};
    public String getCity() {return city;};
    public String getProvince() {return province;};
    public String getCommune() {return commune;};

}
