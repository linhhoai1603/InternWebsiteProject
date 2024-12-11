package models;

import java.sql.Date;

public class TechnicalInfo {
    int id;
    String specification;
    Date manufactureDate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification;
    }

    public Date getManufactureDate() {
        return manufactureDate;
    }

    public void setManufactureDate(Date manufactureDate) {
        this.manufactureDate = manufactureDate;
    }

    @Override
    public String toString() {
        return "TechnicalInfo{" +
                "id=" + id +
                ", specification='" + specification + '\'' +
                ", manufactureDate='" + manufactureDate + '\'' +
                '}';
    }
}
