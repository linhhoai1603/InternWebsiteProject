package models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class VoucherUsage implements Serializable {
    private int VUId, voucherId, userId, orderId;
    private LocalDateTime usedAt;

    public VoucherUsage(int VUId, int voucherId, int userId, int orderId, LocalDateTime usedAt) {
        this.VUId = VUId;
        this.voucherId = voucherId;
        this.userId = userId;
        this.orderId = orderId;
        this.usedAt = usedAt;
    }

    public VoucherUsage() {
    }

    public int getVUId() {
        return VUId;
    }

    public void setVUId(int VUId) {
        this.VUId = VUId;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public LocalDateTime getUsedAt() {
        return usedAt;
    }

    public void setUsedAt(LocalDateTime usedAt) {
        this.usedAt = usedAt;
    }
}
