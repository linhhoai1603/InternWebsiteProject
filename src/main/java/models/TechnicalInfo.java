package models;

import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDate;

public class TechnicalInfo implements Serializable {
   private int id;
   private String specification;
   private Date manufactureDate;

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
