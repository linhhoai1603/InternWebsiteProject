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

    public boolean updateVoucher(String id, double amount, double price) {
        return voucherDao.updateVoucher(id,amount,price);
    }
    public static String generateRandomString(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder randomString = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(characters.length());
            randomString.append(characters.charAt(index));
        }
        return randomString.toString();
    }

    public boolean addVoucher(double amount, double condition) {
        int id = getAllVouchers().size()+1;
        String code = generateRandomString(8)+id;
        return voucherDao.addVoucher(code,id,amount,condition);
    }

    public boolean deleteVoucher(int id) {
        return voucherDao.deleteVoucher(id);
    }
}
