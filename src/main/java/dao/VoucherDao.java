package dao;

import connection.DBConnection;
import models.Voucher;
import models.VoucherUsage;
import models.enums.DiscountType;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public class VoucherDao {
    private Jdbi jdbi;

    public VoucherDao() {
        jdbi = DBConnection.getConnetion();
    }

    public List<Voucher> getAllVouchers() {
        String query = "SELECT * FROM vouchers ORDER BY createdAt DESC;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Voucher.class).list();
        });
    }

    public List<Voucher> getVoucherByValid(int isActive) {
        String query = "SELECT * FROM vouchers WHERE isActive = :isActive;";
        try {
            return jdbi.withHandle(handle -> handle.createQuery(query).bind("isActive", isActive).map((rs, ctx) -> {
                Voucher voucher = new Voucher();
                voucher.setIdVoucher(rs.getInt("idVoucher"));
                voucher.setCode(rs.getString("code"));
                voucher.setDescription(rs.getString("description"));
                String discountTypeStr = rs.getString("discountType");
                if (discountTypeStr != null) { //enum
                    try {
                        voucher.setDiscountType(DiscountType.valueOf(discountTypeStr.toUpperCase()));
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
                voucher.setUsesPerCustomer(rs.getInt("usesPerCustomer"));
                voucher.setStartDate(rs.getObject("startDate", LocalDateTime.class));
                voucher.setEndDate(rs.getObject("endDate", LocalDateTime.class));
                voucher.setCreatedAt(rs.getObject("createdAt", LocalDateTime.class));
                voucher.setUpdatedAt(rs.getObject("updatedAt", LocalDateTime.class));
                voucher.setIsActive(rs.getInt("isActive"));
                return voucher;
            }).list());
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy danh sách voucher: " + e.getMessage());
            return null;
        }
    }

    public static void main(String[] args) {
        VoucherDao dao = new VoucherDao();
        System.out.println(dao.getVoucherByValid(1));
    }

    public Boolean applyVoucherToCart(int idCart, Voucher voucher) {
        int idVoucher = voucher.getIdVoucher();
        String query = "UPDATE cart set idVoucher = :idVoucher WHERE id = :idCart";
        try {
            int rowsUpdated = jdbi.withHandle(handle -> handle.createUpdate(query).bind("idVoucher", idVoucher).bind("idCart", idCart).execute());
            return rowsUpdated > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi cập nhật voucher: " + e.getMessage());
            return false;
        }
    }

    public int getVoucherUsageCount(int voucherId) {
        String query = "SELECT count(*) FROM voucher_usage WHERE voucher_id = :voucherId;";
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery(query)
                            .bind("voucherId", voucherId)
                            .mapTo(Integer.class)
                            .one()
            );
        } catch (Exception e) {
            System.err.println("Lỗi khi đếm số lần sử dụng voucher " + voucherId + ": " + e.getMessage());
            return 0;
        }
    }

    public Voucher getVoucherByCode(String code) {
        String query = "SELECT * FROM vouchers WHERE code = ?;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query).bind(0, code).mapToBean(Voucher.class).findOne().orElse(null);
        });
    }


    public boolean updateVoucher(String id, double amount, double price) {
        String query = "UPDATE vouchers SET amount = :amount, condition_amount = :price WHERE idVoucher = :id";
        try {
            int rowsUpdated = jdbi.withHandle(handle -> handle.createUpdate(query).bind("amount", amount).bind("price", price).bind("id", id).execute());
            return rowsUpdated > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi cập nhật voucher: " + e.getMessage());
            return false;
        }
    }

    public boolean updateVoucher(Voucher voucher) {
        String sql = "UPDATE vouchers SET " + "code = :code, " + "description = :description, " + "discountType = :discountType, " +
                "discountValue = :discountValue, " + "minimumSpend = :minimumSpend, " + "maxDiscountAmount = :maxDiscountAmount, " +
                "startDate = :startDate, " + "endDate = :endDate, " + "maxUses = :maxUses, " + "usesPerCustomer = :usesPerCustomer, "
                + "isActive = :isActive, " + "updatedAt = CURRENT_TIMESTAMP " + "WHERE idVoucher = :idVoucher";
        if (voucher == null || voucher.getIdVoucher() <= 0) {
            System.err.println("Lỗi DAO: Không thể cập nhật voucher với ID không hợp lệ hoặc đối tượng null.");
            return false;
        }

        try {
            int rowsAffected = jdbi.withHandle(handle -> {
                Update updateStatement = handle.createUpdate(sql);

                updateStatement.bindBean(voucher);

                if (voucher.getDiscountType() != null) {
                    updateStatement.bind("discountType", voucher.getDiscountType().name());
                } else {
                    updateStatement.bindNull("discountType", java.sql.Types.VARCHAR);
                }

                updateStatement.bind("isActive", voucher.getIsActive());

                updateStatement.bind("idVoucher", voucher.getIdVoucher());

                return updateStatement.execute();
            });
            return rowsAffected == 1;

        } catch (Exception e) {
            System.err.println("Lỗi DAO khi cập nhật voucher ID: " + voucher.getIdVoucher());
            if (e.getCause() instanceof SQLException) {
                SQLException sqlEx = (SQLException) e.getCause();
                if (sqlEx.getErrorCode() == 1062) { // Mã lỗi trùng UNIQUE của MySQL
                    System.err.println("Lỗi: Mã voucher '" + voucher.getCode() + "' đã tồn tại cho một voucher khác.");
                }
            }
            e.printStackTrace();
            return false;
        }
    }

    public boolean addVoucher(Voucher voucher) {
        String sql = "INSERT INTO vouchers (" + "code, description, discountType, discountValue, minimumSpend, " + "maxDiscountAmount, startDate, endDate, maxUses, usesPerCustomer, isActive" + ") VALUES (" + ":code, :description, :discountType, :discountValue, :minimumSpend, " + ":maxDiscountAmount, :startDate, :endDate, :maxUses, :usesPerCustomer, :isActive" + ")";
        try {
            int rowsAffected = jdbi.withHandle(handle -> {
                Update updateStatement = handle.createUpdate(sql);
                updateStatement.bindBean(voucher);

                if (voucher.getDiscountType() != null) {
                    updateStatement.bind("discountType", voucher.getDiscountType().name());
                } else {
                    updateStatement.bindNull("discountType", java.sql.Types.VARCHAR);
                }
                updateStatement.bind("isActive", voucher.getIsActive());
                updateStatement.bind("startDate", voucher.getStartDate());

                return updateStatement.execute();
            });

            return rowsAffected == 1;

        } catch (Exception e) {
            System.err.println("Lỗi DAO khi thêm voucher với mã: " + (voucher != null ? voucher.getCode() : "null"));

            if (e.getCause() instanceof SQLException) {
                SQLException sqlEx = (SQLException) e.getCause();
                if (sqlEx.getErrorCode() == 1062) {
                    System.err.println("Lỗi: Mã voucher đã tồn tại.");
                }
            }

            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteVoucher(int id) {
        String query = "UPDATE vouchers SET isActive = 0,  endDate = CURRENT_TIMESTAMP WHERE idVoucher = :id";
        try {
            int rowsUpdated = jdbi.withHandle(handle -> handle.createUpdate(query).bind("id", id).execute());
            return rowsUpdated > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa voucher: " + e.getMessage());
            return false; // Trả về false nếu có lỗi
        }
    }

    public Voucher getVoucherById(int idVoucher) {
        String query = "SELECT * FROM vouchers WHERE id = ?;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query).bind(0, idVoucher).mapToBean(Voucher.class).findOne().orElse(null);
        });
    }


}
