package dao;

import connection.DBConnection;
import models.Voucher;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class VoucherDao {
    private Jdbi jdbi;
    public VoucherDao() {
        jdbi = DBConnection.getConnetion();
    }
    public List<Voucher> getAllVouchers() {
        String query = "SELECT * FROM voucher;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .mapToBean(Voucher.class)
                    .list();
        });
    }
    public List<Voucher> getVoucherByValid(int valid){
        String query = "SELECT * FROM vouchers WHERE valid = ?;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, valid)
                    .mapToBean(Voucher.class).list();
        });
    }
    public Voucher getVoucherByCode(String code){
        String query = "SELECT * FROM vouchers WHERE code = ?;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, code)
                    .mapToBean(Voucher.class).findOne().orElse(null);
        });
    }
}
