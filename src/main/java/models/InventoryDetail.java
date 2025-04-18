package models;

import java.io.Serializable;
import java.util.Date;

public class InventoryDetail implements Serializable {
    private int id;
    private int idProduct;
    private int idInventory;
    private int quantityBefore;
    private int quantityLoss;
    private int quantityImported;
    private int quantityTotal;
    private Date importDate;

    // Constructors
    public InventoryDetail() {}

    public InventoryDetail(int id, int idProduct, int idInventory, int quantityBefore, int quantityLoss,
                           int quantityImported, int quantityTotal, Date importDate) {
        this.id = id;
        this.idProduct = idProduct;
        this.idInventory = idInventory;
        this.quantityBefore = quantityBefore;
        this.quantityLoss = quantityLoss;
        this.quantityImported = quantityImported;
        this.quantityTotal = quantityTotal;
        this.importDate = importDate;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdProduct() { return idProduct; }
    public void setIdProduct(int idProduct) { this.idProduct = idProduct; }

    public int getIdWareHouse() { return idInventory; }
    public void setIdWareHouse(int idWareHouse) { this.idInventory = idWareHouse; }

    public int getQuantityBefore() { return quantityBefore; }
    public void setQuantityBefore(int quantityBefore) { this.quantityBefore = quantityBefore; }

    public int getQuantityLoss() { return quantityLoss; }
    public void setQuantityLoss(int quantityLoss) { this.quantityLoss = quantityLoss; }

    public int getQuantityImported() { return quantityImported; }
    public void setQuantityImported(int quantityImported) { this.quantityImported = quantityImported; }

    public int getQuantityTotal() { return quantityTotal; }
    public void setQuantityTotal(int quantityTotal) { this.quantityTotal = quantityTotal; }

    public Date getImportDate() { return importDate; }
    public void setImportDate(java.sql.Date importDate) { this.importDate = importDate; }
}