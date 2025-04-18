package dao;

import connection.DBConnection;
import models.Voucher;
import models.enums.DiscountType;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDate;
import java.time.LocalDateTime;
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

    public List<Voucher> getVoucherByValid(int isActive) {
        String query = "SELECT * FROM vouchers WHERE isActive = :isActive;";
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery(query)
                            .bind("isActive", isActive)
                            .map((rs, ctx) -> {
                                Voucher voucher = new Voucher();
                                voucher.setIdVoucher(rs.getInt("idVoucher"));
                                voucher.setCode(rs.getString("code"));
                                voucher.setDescription(rs.getString("description"));
                                String discountTypeStr = rs.getString("discountType");
                                if (discountTypeStr != null) { //enum
                                    try {
                                        voucher.setDiscountType(DiscountType.valueOf(discountTypeStr));
                                    } catch (IllegalArgumentException e) {
                                        System.err.println("Invalid discountType value found in DB: " + discountTypeStr + " for voucher id: " + rs.getInt("idVoucher"));
                                        voucher.setDiscountType(null);
                                    }
                                } else {
                                    voucher.setDiscountType(null);
                                }
                                voucher.setDiscountValue(rs.getDouble("discountValue"));
                                voucher.setMinimumSpend(rs.getDouble("minimumSpend"));
                                voucher.setMaxDiscountAmount(rs.getDouble("maxDiscountAmount"));
                                voucher.setStartDate(rs.getObject("startDate", LocalDateTime.class));
                                voucher.setEndDate(rs.getObject("endDate", LocalDateTime.class));
                                voucher.setCreatedAt(rs.getObject("createdAt", LocalDateTime.class));
                                voucher.setUpdatedAt(rs.getObject("updatedAt", LocalDateTime.class));
                                voucher.setIsActive(rs.getInt("isActive"));
                                return voucher;
                            }).list()
            );
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy danh sách voucher: " + e.getMessage());
            return null;
        }
    }

    public static void main(String[] args) {
        VoucherDao voucherDao = new VoucherDao();
        System.out.println(voucherDao.getVoucherByValid(1).size());
    }

    public Voucher getVoucherByCode(String code) {
        String query = "SELECT * FROM vouchers WHERE code = ?;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, code)
                    .mapToBean(Voucher.class).findOne().orElse(null);
        });
    }


    public boolean updateVoucher(String id, double amount, double price) {
        String query = "UPDATE vouchers SET amount = :amount, condition_amount = :price WHERE idVoucher = :id";
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

    public boolean addVoucher(String code, int id, double amount, double condition) {

        String query = "INSERT INTO vouchers (idVoucher,code, amount, condition_amount, valid) " +
                "VALUES (:id,:code, :amount, :condition, 1)";
        try {
            int rowsInserted = jdbi.withHandle(handle ->
                    handle.createUpdate(query)
                            .bind("id", id)
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
        String query = "UPDATE vouchers SET valid = 0 WHERE idVoucher = :id";
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

    public Voucher getVoucherById(int idVoucher) {
        String query = "SELECT * FROM vouchers WHERE id = ?;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, idVoucher)
                    .mapToBean(Voucher.class)
                    .findOne()
                    .orElse(null);
        });
    }


}
