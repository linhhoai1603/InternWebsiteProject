package models;

import java.io.Serializable;
import java.sql.Timestamp;

public class Inventory implements Serializable {
    private int id;
    private Timestamp creatDate;
    private String status;
    private String code;
    private String description;
    public Inventory(int id, Timestamp creatDate , String status, String code, String description) {
        this.id = id;
        this.creatDate = creatDate;
        this.status = status;
        this.code = code;
    }
    public Inventory(){}

    public String getStatus() {
        return status;
    }

    public void setStatus(String state) {
        this.status = state;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getCreatDate() {
        return creatDate;
    }

    public void setCreatDate(Timestamp creatDate) {
        this.creatDate = creatDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
