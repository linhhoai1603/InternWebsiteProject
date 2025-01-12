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
        String query = "SELECT * FROM vouchers;";
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

    public boolean updateVoucher(String id, double amount, double price) {
        String query = "UPDATE vouchers SET discountAmount = :amount, conditionAmount = :price WHERE code = :id";
        try {
            int rowsUpdated = jdbi.withHandle(handle ->
                    handle.createUpdate(query)
                            .bind("amount", amount)
                            .bind("price", price)
                            .bind("id", id)
                            .execute()
            );
            return rowsUpdated > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (Exception e) {
            System.out.println("Lỗi khi cập nhật voucher: " + e.getMessage());
            return false;
        }
    }

    public boolean addVoucher(String code, String id, double amount, double condition) {
        String query = "INSERT INTO vouchers (code, discountAmount, conditionAmount, valid) " +
                "VALUES (:code, :amount, :condition, 1)";
        try {
            int rowsInserted = jdbi.withHandle(handle ->
                    handle.createUpdate(query)
                            .bind("code", code)
                            .bind("amount", amount)
                            .bind("condition", condition)
                            .execute()
            );
            return rowsInserted > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi thêm voucher: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteVoucher(int id) {
        String query = "UPDATE vouchers SET valid = 0 WHERE id = :id";
        try {
            int rowsUpdated = jdbi.withHandle(handle ->
                    handle.createUpdate(query)
                            .bind("id", id)
                            .execute()
            );
            return rowsUpdated > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa voucher: " + e.getMessage());
            return false; // Trả về false nếu có lỗi
        }
    }
}
