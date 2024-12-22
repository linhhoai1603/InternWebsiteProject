package models;

import java.io.Serializable;

public class Voucher implements Serializable {
    private int id;
    private String code;
    private double discountAmount;
    private double conditionAmount;
    private int valid;
    public Voucher() {

    }
    public Voucher(int id,String code, double discountAmount, double amount, int valid) {
        this.id = id;
        this.code = code;
        this.discountAmount = discountAmount;
        this.conditionAmount = amount;
        this.valid = valid;
    }

    public int getValid() {
        return valid;
    }

    public void setValid(int valid) {
        this.valid = valid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public double getConditionAmount() {
        return conditionAmount;
    }

    public void setConditionAmount(double amount) {
        this.conditionAmount = amount;
    }
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "id=" + id +
                ", discountAmount=" + discountAmount +
                ", amount=" + conditionAmount +
                '}';
    }
}
