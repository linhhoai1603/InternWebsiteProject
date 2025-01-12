package models;

import java.io.Serializable;

public class Voucher implements Serializable {
    private int idVoucher;
    private String code;
    private double discountAmount;
    private double conditionAmount;
    private int valid;
    public Voucher() {

    }
    public Voucher(int idVoucher,String code, double discountAmount, double amount, int valid) {
        this.idVoucher = idVoucher;
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

    public int getIdVoucher() {
        return idVoucher;
    }

    public void setIdVoucher(Integer id) {
        if (id != null) {
            this.idVoucher = id;
        }
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
    public void setIdVoucher(Integer id) {
        if (id != null) {
            this.idVoucher = id;
        }
    }
    @Override
    public String toString() {
        return "Voucher{" +
                "id=" + idVoucher +
                ", discountAmount=" + discountAmount +
                ", amount=" + conditionAmount +
                '}';
    }
    public void setIdVoucher(int idVoucher) {
        this.idVoucher = idVoucher;
    }
}
