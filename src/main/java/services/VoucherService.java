package services;

import dao.VoucherDao;
import models.Voucher;

import java.util.List;

public class VoucherService {
    private VoucherDao voucherDao;
    public VoucherService() {
        voucherDao = new VoucherDao();
    }
    public List<Voucher> getAllVouchers() {
    return voucherDao.getAllVouchers();
    }
        public List<Voucher> getVoucherByValid(int valid){
        return voucherDao.getVoucherByValid(valid);
    }
}
