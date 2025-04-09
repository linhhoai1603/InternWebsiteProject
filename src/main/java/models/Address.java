package models;

import java.io.Serializable;

public class Address implements Serializable {
    private int id;
    private String province;
    private String district;
    private String ward;
    private String detail;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public Address(int id, String province, String district, String ward, String detail) {
        this.id = id;
        this.province = province;
        this.district = district;
        this.ward = ward;
        this.detail = detail;
    }
    public Address() {
        super();
    }
    public String getAddressDetail(){
        return this.detail + ", " + this.ward + ", " + this.district + ", " + this.province;
    }
    @Override
    public String toString() {
        return "Address{" +
                "id=" + id +
                ", province='" + province + '\'' +
                ", city='" + district + '\'' +
                ", commune='" + ward + '\'' +
                ", street='" + detail + '\'' +
                '}';
    }
}
