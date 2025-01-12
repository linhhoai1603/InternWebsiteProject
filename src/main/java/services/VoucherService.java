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

    public static void main(String[] args) {
        BCrypt bCrypt = new BCrypt();
        String pass = "123456";
        String hash = bCrypt.hashpw(pass, bCrypt.gensalt());
        System.out.println(hash);
        System.out.println(bCrypt.checkpw(pass, hash));
    }

    public boolean updateVoucher(String id, double amount, double price) {
        return voucherDao.updateVoucher(id,amount,price);
    }
}
