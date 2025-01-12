package services;

import dao.VoucherDao;
import models.Voucher;
import org.mindrot.jbcrypt.BCrypt;

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
    public Voucher getVoucherByCode(String code){
        return voucherDao.getVoucherByCode(code);
    }


    public Voucher getVoucherById(int idVoucher) {
        return voucherDao.getVoucherById(idVoucher);
    }
}
