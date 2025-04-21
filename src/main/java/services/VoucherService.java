package services;

import dao.VoucherDao;
import models.Voucher;
import org.mindrot.jbcrypt.BCrypt;

import java.util.List;
import java.util.Random;

public class VoucherService {
    private VoucherDao voucherDao;
    public VoucherService() {
        voucherDao = new VoucherDao();
    }
    public List<Voucher> getVoucherByValid(int valid){
        return voucherDao.getVoucherByValid(valid);
    }
    public Voucher getVoucherByCode(String code){
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
}
