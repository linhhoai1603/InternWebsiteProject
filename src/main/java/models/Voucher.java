package models;

public class Voucher {
    private int id;
    private String code;
    private double discountAmount;
    private double amount;
    public Voucher() {

    }
    public Voucher(int id,String code, double discountAmount, double amount) {
        this.id = id;
        this.code = code;
        this.discountAmount = discountAmount;
        this.amount = amount;
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

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
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
                ", amount=" + amount +
                '}';
    }
}
