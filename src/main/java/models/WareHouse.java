package models;

import java.sql.Timestamp;

public class WareHouse {
    private int id;
    private Timestamp import_date;
    private Timestamp updatedAt;
    public WareHouse(int id, Timestamp import_date, Timestamp updatedAt) {
        this.id = id;
        this.import_date = import_date;
        this.updatedAt = updatedAt;
    }
    public WareHouse(){}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getImport_date() {
        return import_date;
    }

    public void setImport_date(Timestamp import_date) {
        this.import_date = import_date;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
