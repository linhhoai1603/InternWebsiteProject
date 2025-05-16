package services;

import dao.VoucherDao;
import models.Cart;
import models.Voucher;
import models.enums.DiscountType;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

public class VoucherService {
    private VoucherDao voucherDao;

    public VoucherService() {
        voucherDao = new VoucherDao();
    }

    public List<Voucher> getVoucherByValid(int valid) {
        return voucherDao.getVoucherByValid(valid);
    }

    public Voucher getVoucherByCode(String code) {
        return voucherDao.getVoucherByCode(code);
    }

    public boolean updateVoucher(Voucher voucher) {
        return voucherDao.updateVoucher(voucher);
    }

    public boolean addVoucher(Voucher voucher) {
        return voucherDao.addVoucher(voucher);
    }

    public boolean deleteVoucher(int id) {
        return voucherDao.deleteVoucher(id);
    }
    public int getVoucherUsageCount(String voucherCode) {
        Voucher voucher = getVoucherByCode(voucherCode);
        return voucherDao.getVoucherUsageCount(voucher.getIdVoucher());
    }
    // method to apply voucher in cart
    public boolean applyVoucherToCart(Cart cart, Voucher voucher) {
        // execute apply
        Boolean isApplied = voucherDao.applyVoucherToCart(cart.getId(), voucher);
        // discount price
        if (isApplied) {
            cart.setTotalPrice(cart.getTotalPrice() - voucher.getDiscountValue());
            return true;
        } else {
            return false;
        }
    }
}
