package models;

import models.enums.DiscountType;

import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class Voucher implements Serializable {
    private int idVoucher;
    private String code;
    private String description;
    private DiscountType discountType;
    private double discountValue;
    private double minimumSpend;
    private double maxDiscountAmount;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private Integer maxUses;
    private Integer usesPerCustomer;
    private int isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Voucher() {
    }

    public Voucher(int idVoucher, String code, String description, DiscountType discountType, double discountValue, double minimumSpend, double maxDiscountAmount, LocalDateTime startDate, LocalDateTime endDate, Integer maxUses, Integer usesPerCustomer, int isActive, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.idVoucher = idVoucher;
        this.code = code;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minimumSpend = minimumSpend;
        this.maxDiscountAmount = maxDiscountAmount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.maxUses = maxUses;
        this.usesPerCustomer = usesPerCustomer;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getIdVoucher() {
        return idVoucher;
    }

    public void setIdVoucher(int idVoucher) {
        this.idVoucher = idVoucher;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public DiscountType getDiscountType() {
        return discountType;
    }

    public void setDiscountType(DiscountType discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public double getMinimumSpend() {
        return minimumSpend;
    }

    public void setMinimumSpend(double minimumSpend) {
        this.minimumSpend = minimumSpend;
    }

    public double getMaxDiscountAmount() {
        return maxDiscountAmount;
    }

    public void setMaxDiscountAmount(double maxDiscountAmount) {
        this.maxDiscountAmount = maxDiscountAmount;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public Integer getMaxUses() {
        return maxUses;
    }

    public void setMaxUses(Integer maxUses) {
        this.maxUses = maxUses;
    }

    public Integer getUsesPerCustomer() {
        return usesPerCustomer;
    }

    public void setUsesPerCustomer(Integer usesPerCustomer) {
        this.usesPerCustomer = usesPerCustomer;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public void setIdVoucher(Integer id) {
        if (id != null) {
            this.idVoucher = id;
        }
    }

    public Date getStartDateAsDate() {
        // Chuyển LocalDateTime thành Timestamp (là con của Date)
        return (this.startDate == null) ? null : Timestamp.valueOf(this.startDate);
    }

    public Date getEndDateAsDate() {
        // Chuyển LocalDateTime thành Timestamp (là con của Date)
        return (this.endDate == null) ? null : Timestamp.valueOf(this.endDate);
    }

    public Date getCreatedAtAsDate() {
        return (this.createdAt == null) ? null : Timestamp.valueOf(this.createdAt);
    }

    public Date getUpdatedAtAsDate() {
        return (this.updatedAt == null) ? null : Timestamp.valueOf(this.updatedAt);
    }

    public boolean isApplicable(double currentOrderTotal) {
        LocalDateTime now = LocalDateTime.now();
        return this.isActive == 1 &&
                (this.startDate == null || !now.isBefore(this.startDate)) &&
                (this.endDate == null || !now.isAfter(this.endDate)) &&
                currentOrderTotal >= this.minimumSpend;
    }

    public double calculateDiscount(double orderTotal) {
        if (!isApplicable(orderTotal)) {
            return 0;
        }

        double discount = 0;
        if (this.discountType == DiscountType.PERCENTAGE) {
            discount = orderTotal * (this.discountValue / 100.0);
            if (this.maxDiscountAmount > 0 && discount > this.maxDiscountAmount) {
                discount = this.maxDiscountAmount;
            }
        } else if (this.discountType == DiscountType.FIXED) {
            discount = this.discountValue;
        }

        // Đảm bảo không giảm nhiều hơn tổng đơn hàng
        return Math.min(discount, orderTotal);
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "idVoucher=" + idVoucher +
                ", code='" + code + '\'' +
                ", description='" + description + '\'' +
                ", discountType=" + discountType +
                ", discountValue=" + discountValue +
                ", minimumSpend=" + minimumSpend +
                ", maxDiscountAmount=" + maxDiscountAmount +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", maxUses=" + maxUses +
                ", usesPerCustomer=" + usesPerCustomer +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
