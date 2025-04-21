package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Voucher;
import models.enums.DiscountType;
import services.VoucherService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/admin/manager-voucher")
public class AdminManagerVoucher extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VoucherService voucherService = new VoucherService();
        List<Voucher> list = voucherService.getVoucherByValid(1);
        if (list.isEmpty()) {
            System.out.println("No voucher found");
        } else {
            for (Voucher voucher : list) {
                System.out.println(voucher.toString());
            }
        }
        request.setAttribute("vouchers", list);
        System.out.println("set voucher thành công");
        request.getRequestDispatcher("/admin/management-vouchers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if ("add".equals(method)) addVoucher(request, response);
        if ("update".equals(method)) updateVoucher(request, response);
        if ("delete".equals(method)) deleteVoucher(request, response);
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idVoucher"));
        VoucherService voucherService = new VoucherService();
        if (voucherService.deleteVoucher(id)) {
            request.setAttribute("message", "Xóa Voucher thành công  ");
            doGet(request, response);
        } else {
            request.setAttribute("message", "Xóa Voucher thất bại ");
            doGet(request, response);
        }
    }

    private void updateVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Voucher voucherToUpdate = new Voucher();
        VoucherService voucherService = new VoucherService();
        String successMessage = null;
        String errorMessage = null;
        String idParam = request.getParameter("idVoucher");

        if (idParam == null || idParam.trim().isEmpty()) {
            errorMessage = "Thiếu ID voucher cần cập nhật.";
        } else {
            try {
                // 1. Parse ID voucher (bắt buộc)
                int id = Integer.parseInt(idParam);
                voucherToUpdate.setIdVoucher(id);

                // 2. Lấy và Validate các tham số bắt buộc khác
                String code = request.getParameter("code");
                String discountTypeStr = request.getParameter("discountType");
                String discountValueStr = request.getParameter("discountValue");

                if (code == null || code.trim().isEmpty()) {
                    throw new IllegalArgumentException("Mã voucher không được để trống.");
                }
                voucherToUpdate.setCode(code.trim().toUpperCase());

                if (discountTypeStr == null || discountTypeStr.trim().isEmpty()) {
                    throw new IllegalArgumentException("Loại giảm giá không được để trống.");
                }
                try {
                    voucherToUpdate.setDiscountType(DiscountType.valueOf(discountTypeStr.toUpperCase()));
                } catch (IllegalArgumentException e) {
                    throw new IllegalArgumentException("Loại giảm giá không hợp lệ: " + discountTypeStr);
                }


                if (discountValueStr == null || discountValueStr.trim().isEmpty()) {
                    throw new IllegalArgumentException("Giá trị giảm không được để trống.");
                }
                try {
                    voucherToUpdate.setDiscountValue(Double.parseDouble(discountValueStr));
                    if (voucherToUpdate.getDiscountValue() < 0) throw new NumberFormatException();
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Giá trị giảm phải là một số không âm.");
                }

                // 3. Lấy và Parse các tham số tùy chọn (tương tự addVoucher)
                voucherToUpdate.setDescription(request.getParameter("description"));

                String minimumSpendStr = request.getParameter("minimumSpend");
                if (minimumSpendStr != null && !minimumSpendStr.trim().isEmpty()) {
                    try {
                        voucherToUpdate.setMinimumSpend(Double.parseDouble(minimumSpendStr));
                        if (voucherToUpdate.getMinimumSpend() < 0) throw new NumberFormatException();
                    } catch (NumberFormatException e) {
                        throw new IllegalArgumentException("Đơn hàng tối thiểu phải là một số không âm.");
                    }
                } else {
                    voucherToUpdate.setMinimumSpend(0.0);
                }


                String maxDiscountAmountStr = request.getParameter("maxDiscountAmount");
                if (maxDiscountAmountStr != null && !maxDiscountAmountStr.trim().isEmpty()) {
                    try {
                        voucherToUpdate.setMaxDiscountAmount(Double.parseDouble(maxDiscountAmountStr));
                        if (voucherToUpdate.getMaxDiscountAmount() < 0) throw new NumberFormatException();
                    } catch (NumberFormatException e) {
                        throw new IllegalArgumentException("Giảm giá tối đa phải là một số không âm.");
                    }
                } else {
                    voucherToUpdate.setMaxDiscountAmount(0.0);
                }

                String startDateStr = request.getParameter("startDate");
                if (startDateStr != null && !startDateStr.trim().isEmpty()) {
                    try {
                        voucherToUpdate.setStartDate(LocalDateTime.parse(startDateStr));
                    } catch (DateTimeParseException e) {
                        throw new IllegalArgumentException("Định dạng Ngày bắt đầu không hợp lệ.");
                    }
                } else {
                    voucherToUpdate.setStartDate(null);
                }

                String endDateStr = request.getParameter("endDate");
                if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                    try {
                        voucherToUpdate.setEndDate(LocalDateTime.parse(endDateStr));
                        if (voucherToUpdate.getStartDate() != null && voucherToUpdate.getEndDate().isBefore(voucherToUpdate.getStartDate())) {
                            throw new IllegalArgumentException("Ngày kết thúc phải sau hoặc bằng Ngày bắt đầu.");
                        }
                    } catch (DateTimeParseException e) {
                        throw new IllegalArgumentException("Định dạng Ngày kết thúc không hợp lệ.");
                    }
                } else {
                    voucherToUpdate.setEndDate(null);
                }


                String maxUsesStr = request.getParameter("maxUses");
                if (maxUsesStr != null && !maxUsesStr.trim().isEmpty()) {
                    try {
                        int maxUses = Integer.parseInt(maxUsesStr);
                        if (maxUses <= 0) throw new NumberFormatException();
                        voucherToUpdate.setMaxUses(maxUses);
                    } catch (NumberFormatException e) {
                        throw new IllegalArgumentException("Tổng lượt dùng tối đa phải là số nguyên dương.");
                    }
                } else {
                    voucherToUpdate.setMaxUses(null);
                }

                String usesPerCustomerStr = request.getParameter("usesPerCustomer");
                if (usesPerCustomerStr != null && !usesPerCustomerStr.trim().isEmpty()) {
                    try {
                        int usesPerCustomer = Integer.parseInt(usesPerCustomerStr);
                        if (usesPerCustomer <= 0) throw new NumberFormatException();
                        voucherToUpdate.setUsesPerCustomer(usesPerCustomer);
                    } catch (NumberFormatException e) {
                        throw new IllegalArgumentException("Lượt dùng/khách phải là số nguyên dương.");
                    }
                } else {
                    voucherToUpdate.setUsesPerCustomer(null);
                }

                String isActiveParam = request.getParameter("isActive");
                voucherToUpdate.setIsActive(isActiveParam != null && isActiveParam.equals("true") ? 1 : 0);

                // 4. Gọi Service để cập nhật voucher
                boolean success = voucherService.updateVoucher(voucherToUpdate);

                // 5. Đặt thông báo
                if (success) {
                    successMessage = "Cập nhật Voucher '" + voucherToUpdate.getCode() + "' (ID: " + id + ") thành công!";
                } else {
                    errorMessage = "Cập nhật Voucher (ID: " + id + ") thất bại. Voucher có thể không tồn tại hoặc đã xảy ra lỗi.";
                }

            } catch (NumberFormatException e) {
                System.err.println("Lỗi khi parse voucher ID để cập nhật: " + idParam);
                errorMessage = "ID Voucher không hợp lệ: " + idParam;
            } catch (IllegalArgumentException | DateTimeParseException e) {
                System.err.println("Lỗi khi cập nhật voucher ID: " + idParam + " - " + e.getMessage());
                errorMessage = "Lỗi dữ liệu đầu vào: " + e.getMessage();
            } catch (Exception e) {
                System.err.println("Lỗi không xác định khi cập nhật voucher ID: " + idParam);
                e.printStackTrace();
                errorMessage = "Đã xảy ra lỗi hệ thống khi cố gắng cập nhật voucher.";
            }
        }
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }
        doGet(request, response);
    }


    private void addVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Voucher voucher = new Voucher();
        VoucherService voucherService = new VoucherService();
        String errorMessage = null; // Lưu trữ thông báo lỗi

        try {
            // 1. Lấy và Validate các tham số bắt buộc
            String code = request.getParameter("code");
            String discountTypeStr = request.getParameter("discountType");
            String discountValueStr = request.getParameter("discountValue");

            if (code == null || code.trim().isEmpty()) {
                throw new IllegalArgumentException("Mã voucher không được để trống.");
            }
            voucher.setCode(code.trim().toUpperCase());

            if (discountTypeStr == null || discountTypeStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Loại giảm giá không được để trống.");
            }
            try {
                voucher.setDiscountType(DiscountType.valueOf(discountTypeStr.toUpperCase()));
            } catch (IllegalArgumentException e) {
                throw new IllegalArgumentException("Loại giảm giá không hợp lệ: " + discountTypeStr);
            }

            if (discountValueStr == null || discountValueStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Giá trị giảm không được để trống.");
            }
            try {
                voucher.setDiscountValue(Double.parseDouble(discountValueStr));
                if (voucher.getDiscountValue() < 0) throw new NumberFormatException(); // Không chấp nhận giá trị âm
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Giá trị giảm phải là một số không âm.");
            }

            // 2. Lấy và Parse các tham số tùy chọn
            voucher.setDescription(request.getParameter("description")); // Cho phép null/rỗng

            String minimumSpendStr = request.getParameter("minimumSpend");
            if (minimumSpendStr != null && !minimumSpendStr.trim().isEmpty()) {
                try {
                    voucher.setMinimumSpend(Double.parseDouble(minimumSpendStr));
                    if (voucher.getMinimumSpend() < 0) throw new NumberFormatException();
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Đơn hàng tối thiểu phải là một số không âm.");
                }
            } else {
                voucher.setMinimumSpend(0.0); // Giá trị mặc định nếu không nhập
            }

            String maxDiscountAmountStr = request.getParameter("maxDiscountAmount");
            if (maxDiscountAmountStr != null && !maxDiscountAmountStr.trim().isEmpty()) {
                try {
                    voucher.setMaxDiscountAmount(Double.parseDouble(maxDiscountAmountStr));
                    if (voucher.getMaxDiscountAmount() < 0) throw new NumberFormatException();
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Giảm giá tối đa phải là một số không âm.");
                }
            }

            String startDateStr = request.getParameter("startDate");
            if (startDateStr != null && !startDateStr.trim().isEmpty()) {
                try {
                    // Input datetime-local có dạng yyyy-MM-ddTHH:mm
                    voucher.setStartDate(LocalDateTime.parse(startDateStr));
                } catch (DateTimeParseException e) {
                    throw new IllegalArgumentException("Định dạng Ngày bắt đầu không hợp lệ.");
                }
            }

            String endDateStr = request.getParameter("endDate");
            if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                try {
                    voucher.setEndDate(LocalDateTime.parse(endDateStr));
                    if (voucher.getStartDate() != null && voucher.getEndDate().isBefore(voucher.getStartDate())) {
                        throw new IllegalArgumentException("Ngày kết thúc phải sau hoặc bằng Ngày bắt đầu.");
                    }
                } catch (DateTimeParseException e) {
                    throw new IllegalArgumentException("Định dạng Ngày kết thúc không hợp lệ.");
                }
            }

            String maxUsesStr = request.getParameter("maxUses");
            if (maxUsesStr != null && !maxUsesStr.trim().isEmpty()) {
                try {
                    int maxUses = Integer.parseInt(maxUsesStr);
                    if (maxUses <= 0) throw new NumberFormatException();
                    voucher.setMaxUses(maxUses);
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Tổng lượt dùng tối đa phải là số nguyên dương.");
                }
            }

            String usesPerCustomerStr = request.getParameter("usesPerCustomer");
            if (usesPerCustomerStr != null && !usesPerCustomerStr.trim().isEmpty()) {
                try {
                    int usesPerCustomer = Integer.parseInt(usesPerCustomerStr);
                    if (usesPerCustomer <= 0) throw new NumberFormatException();
                    voucher.setUsesPerCustomer(usesPerCustomer);
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Lượt dùng/khách phải là số nguyên dương.");
                }
            } else {
                voucher.setUsesPerCustomer(1);
            }

            String isActiveParam = request.getParameter("isActive");
            voucher.setIsActive(isActiveParam != null && isActiveParam.equals("true") ? 1 : 0);


            // 3. Gọi Service để thêm voucher
            boolean success = voucherService.addVoucher(voucher);

            // 4. Đặt thông báo và gọi lại doGet
            if (success) {
                request.setAttribute("successMessage", "Thêm Voucher '" + voucher.getCode() + "' thành công!");
            } else {
                errorMessage = "Thêm Voucher thất bại. Vui lòng thử lại.";
            }

        } catch (IllegalArgumentException | DateTimeParseException e) {
            System.err.println("Lỗi khi thêm voucher: " + e.getMessage());
            errorMessage = "Lỗi dữ liệu đầu vào: " + e.getMessage();
        } catch (Exception e) {
            System.err.println("Lỗi không xác định khi thêm voucher:");
            e.printStackTrace(); // In stack trace để debug
            errorMessage = "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.";
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }
        doGet(request, response);
    }
}