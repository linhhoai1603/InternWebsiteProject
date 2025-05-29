package controllers;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import connection.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.*;
import org.jdbi.v3.core.Jdbi;
import services.*;

@WebServlet(name = "OrderServlet", value = "/order")
public class OrderServlet extends HttpServlet {
    private OrderService orderService;
    private OrderDetailService orderDetailService;
    private DeliveryService deliveryService;
    private AddressService addressService;
    private StyleService styleService;

    @Override
    public void init() throws ServletException {
        super.init();
        orderService = new OrderService();
        orderDetailService = new OrderDetailService();
        deliveryService = new DeliveryService();
        addressService = new AddressService();
        styleService = new StyleService();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String paymentMethod = request.getParameter("payment");
        System.out.println("Payment Method chosen: " + paymentMethod);

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        try {
            if (cart == null || cart.getCartItems().isEmpty()) {
                throw new IllegalStateException("Giỏ hàng của bạn đang trống.");
            }
            // 5. BƯỚC 1: TẠO THÔNG TIN ĐƠN HÀNG CƠ BẢN (ORDER)
            // Gọi hàm processOrderCreation để tạo đối tượng Order, lưu vào DB và lấy lại Order đã có ID
            Order newOrder = processOrderCreation(request, user, cart, paymentMethod);

            // 6. BƯỚC 2: XỬ LÝ CHI TIẾT ĐƠN HÀNG (ORDER DETAILS) VÀ CẬP NHẬT KHO HÀNG
            // Gọi hàm processOrderDetailsAndUpdateStock để:
            // - Tạo các đối tượng OrderDetail cho từng sản phẩm trong giỏ hàng.
            // - Liên kết chúng với Order vừa tạo.
            // - Giảm số lượng tồn kho của sản phẩm tương ứng.
            // - Lưu các OrderDetail vào DB.
            List<OrderDetail> orderDetails = processOrderDetailsAndUpdateStock(newOrder.getId(), cart);
            newOrder.setListOfDetailOrder(orderDetails); // Gán danh sách chi tiết vào Order

            // 7. BƯỚC 3: XỬ LÝ THÔNG TIN ĐỊA CHỈ GIAO HÀNG (DELIVERY ADDRESS)
            // Gọi hàm processDeliveryAddress để:
            // - Xác định địa chỉ giao hàng dựa trên lựa chọn của người dùng (giống địa chỉ shipping hay địa chỉ khác).
            // - Tạo và lưu đối tượng Address cho việc giao hàng này vào DB.
            Address deliveryAddress = processDeliveryAddress(request, user);

            // 8. BƯỚC 4: TẠO THÔNG TIN VẬN CHUYỂN (DELIVERY INFORMATION)
            // Gọi hàm processDeliveryInformation để:
            // - Tạo đối tượng Delivery, liên kết với Order và Address giao hàng.
            // - Bao gồm thông tin người nhận, SĐT, ghi chú, phí ship, trạng thái vận chuyển.
            // - Lưu đối tượng Delivery vào DB.
            Delivery deliveryInfo = processDeliveryInformation(newOrder.getId(), deliveryAddress.getId(), request, cart, deliveryPersonNameFromRequest(request), deliveryPhoneFromRequest(request));

            // Sau khi tất cả thành công, xóa giỏ hàng
            removeCart(session);

            // Chuẩn bị dữ liệu cho trang thành công
            Ordered orderedDataForView = new Ordered(cart,
                    newOrder.getId(), newOrder.getTimeOrdered(), deliveryInfo.getFullName(),
                    deliveryInfo.getNote(), deliveryAddress.getAddressDetail(), deliveryInfo.getStatus(),
                    newOrder.getLastPrice(), paymentMethod);

            request.setAttribute("ordered", orderedDataForView);
            request.setAttribute("message", "Đặt hàng thành công!");
            request.getRequestDispatcher("payment-success.jsp").forward(request, response);

        } catch (IllegalStateException e) {
            e.printStackTrace();
            String currentStep = "shipping";
            if (request.getParameter("SameOtherAddress") != null) {
                currentStep = "payment";
            }
            response.sendRedirect("checkout.jsp?step=" + currentStep + "&errorMessage=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã có lỗi không mong muốn xảy ra.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }

    private void removeCart(HttpSession session) {
        session.removeAttribute("cart");
    }

    /**
     * Tạo và lưu đối tượng Order cơ bản.
     */
    private Order processOrderCreation(HttpServletRequest request, User user, Cart cart, String paymentMethod) {
        Voucher voucher = cart.getAppliedVoucher();
        String orderStatus = "Đang xử lý";
        if ("cod".equals(paymentMethod)) {
            orderStatus = "Đang giao hàng";
        } else if ("bank_transfer".equals(paymentMethod)) {
            orderStatus = "Chờ thanh toán";
        }

        double totalPrice = cart.getTotalPrice();
        double lastPrice = cart.getLastPrice();

        Order order = new Order(user, voucher, orderStatus, totalPrice, lastPrice);
        int idOrder = orderService.insertOrder(order);
        order.setId(idOrder);
        return order;
    }

    /**
     * Xử lý tạo các OrderDetail, cập nhật số lượng tồn kho.
     * Trả về danh sách OrderDetail đã được tạo.
     */
    private List<OrderDetail> processOrderDetailsAndUpdateStock(int orderId, Cart cart) {
        List<OrderDetail> createdOrderDetails = new ArrayList<>();
        for (CartItem item : cart.getCartItems()) {
            Style styleFromCart = item.getStyle();
            Style currentStyleInDB = styleService.getStyleByID(styleFromCart.getId());

            if (currentStyleInDB == null) {
                throw new IllegalStateException("Sản phẩm '" + styleFromCart.getProduct().getName() + " - " + styleFromCart.getName() + "' không còn tồn tại.");
            }

            int quantityOrdered = item.getQuantity();
            if (quantityOrdered <= 0) {
                throw new IllegalStateException("Số lượng đặt cho sản phẩm '" + styleFromCart.getProduct().getName() + "' phải lớn hơn 0.");
            }

            if (quantityOrdered > currentStyleInDB.getQuantity()) {
                throw new IllegalStateException("Sản phẩm '" + styleFromCart.getProduct().getName() + " - " + styleFromCart.getName() + "' không đủ số lượng. Yêu cầu: " + quantityOrdered + ", Hiện có: " + currentStyleInDB.getQuantity());
            }

            // Cập nhật số lượng trong DB
            boolean updateSuccess = styleService.decreaseStyleAndProductQuantity(currentStyleInDB.getId(), currentStyleInDB.getProduct().getId(), quantityOrdered);
            if (!updateSuccess) {
                throw new RuntimeException("Lỗi khi cập nhật số lượng cho sản phẩm: " + currentStyleInDB.getProduct().getName());
            }

            OrderDetail orderDetail = new OrderDetail(orderId, currentStyleInDB, quantityOrdered);
            orderDetailService.insertOrderDetail(orderDetail);
            createdOrderDetails.add(orderDetail);
        }
        return createdOrderDetails;
    }

    /**
     * Xác định tên người nhận hàng từ request.
     */
    private String deliveryPersonNameFromRequest(HttpServletRequest request) {
        String billingAddressOption = request.getParameter("SameOtherAddress");
        if ("same_as_shipping".equals(billingAddressOption)) {
            return request.getParameter("shippingFullNameHidden");
        } else {
            return request.getParameter("billingFullName");
        }
    }

    /**
     * Xác định số điện thoại nhận hàng từ request.
     */
    private String deliveryPhoneFromRequest(HttpServletRequest request) {
        String billingAddressOption = request.getParameter("SameOtherAddress");
        if ("same_as_shipping".equals(billingAddressOption)) {
            return request.getParameter("shippingPhoneHidden");
        } else {
            return request.getParameter("billingPhone");
        }
    }


    /**
     * Xử lý và tạo/lưu đối tượng Address cho việc giao hàng.
     * Trả về đối tượng Address đã được lưu.
     */
    private Address processDeliveryAddress(HttpServletRequest request, User user) {
        String billingAddressOption = request.getParameter("SameOtherAddress");
        String detail, ward, district, province;

        if ("same_as_shipping".equals(billingAddressOption)) {
            detail = request.getParameter("shippingDetailHidden");
            ward = request.getParameter("shippingWardHidden");
            district = request.getParameter("shippingDistrictHidden");
            province = request.getParameter("shippingProvinceHidden");
            System.out.println("địa chỉ: " + detail + ward + district + province);
            System.out.println("Servlet: Delivery address is SAME AS SHIPPING info from hidden fields.");
        } else {
            detail = request.getParameter("billingDetail");
            ward = request.getParameter("billingWard");
            district = request.getParameter("billingDistrict");
            province = request.getParameter("billingProvince");
            System.out.println("Servlet: Delivery address from DIFFERENT BILLING form.");
        }

        if (detail == null || detail.trim().isEmpty() || ward == null || ward.trim().isEmpty() || district == null || district.trim().isEmpty() || province == null || province.trim().isEmpty()) {
            throw new IllegalStateException("Thông tin địa chỉ giao hàng (chi tiết, phường/xã, quận/huyện, tỉnh/thành) không đầy đủ.");
        }

        // Cân nhắc việc tìm kiếm địa chỉ đã tồn tại trước khi tạo mới
        Address existingAddress = addressService.findAddress(province, district, ward, detail);
        if (existingAddress != null) {
            return existingAddress;
        } else {
            int idAddressForDelivery = existingAddress.getId() + 1;
            Address deliveryAddressObject = new Address(idAddressForDelivery, province, district, ward, detail);
            addressService.insertAddress(deliveryAddressObject);
            return deliveryAddressObject;
        }
    }

    /**
     * Tạo và lưu thông tin Delivery.
     * Trả về đối tượng Delivery đã được lưu.
     */
    private Delivery processDeliveryInformation(int orderId, int deliveryAddressId, HttpServletRequest request, Cart cart, String deliveryPersonName, String deliveryPhone) {
        String deliveryNotes = request.getParameter("shippingNotesHidden");

        // Kiểm tra tên người nhận và số điện thoại
        if (deliveryPersonName == null || deliveryPersonName.trim().isEmpty() || deliveryPhone == null || deliveryPhone.trim().isEmpty()) {
            throw new IllegalStateException("Tên người nhận hoặc số điện thoại giao hàng không được để trống.");
        }

        double shippingFee = cart.getShippingFee();
        String deliveryStatus = "Đang chuẩn bị hàng";

        Delivery delivery = new Delivery(orderId, deliveryAddressId, deliveryPersonName, deliveryPhone, 0, shippingFee, deliveryNotes, deliveryStatus);
        deliveryService.insertDelivery(delivery);
        return delivery;
    }
}