package models;

import java.io.Serializable;
import java.sql.Timestamp;

public class Inventory implements Serializable {
    private int id;
    private int type;
    private Timestamp creatDate;
    private String status;
    private String code;
    private String description;
    public Inventory(int id, int type,Timestamp creatDate , String status, String code, String description) {
        this.id = id;
        this.type = type;
        this.creatDate = creatDate;
        this.status = status;
        this.code = code;
    }
    public Inventory(){}

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

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
