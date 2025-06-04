package models;

import java.io.Serializable;

public class InventoryStyleDetail implements Serializable {
    private int id;
    private int idInventoryDetail;
    private int idStyle;
    private int stockQuantity;
    private int actualQuantity;
    private int imported;
    private int discrepancy;

    public InventoryStyleDetail(int id, int idInventoryDetail, int idStyle, int stockQuantity, int actualQuantity, int imported,int discrepancy) {
        this.id = id;
        this.idInventoryDetail = idInventoryDetail;
        this.idStyle = idStyle;
        this.stockQuantity = stockQuantity;
        this.actualQuantity = actualQuantity;
        this.discrepancy = discrepancy;
    }

    public InventoryStyleDetail() {
    }

    public int getQuantityImported() {
        return imported;
    }

    public void setQuantityImported(int imported) {
        this.imported = imported;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdInventoryDetail() {
        return idInventoryDetail;
    }

    public void setIdInventoryDetail(int idInventoryDetail) {
        this.idInventoryDetail = idInventoryDetail;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public int getIdStyle() {
        return idStyle;
    }

    public void setIdStyle(int idStyle) {
        this.idStyle = idStyle;
    }

    public int getDiscrepancy() {
        return discrepancy;
    }

    public void setDiscrepancy(int discrepancy) {
        this.discrepancy = discrepancy;
    }

    public int getActualQuantity() {
        return actualQuantity;
    }

    public void setActualQuantity(int actualQuantity) {
        this.actualQuantity = actualQuantity;
    }
}
