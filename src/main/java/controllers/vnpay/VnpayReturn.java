package controllers.vnpay;

import controllers.OrderServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.*;
import services.*;
import utils.ConfigLoader;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet(name = "VnpayReturn", value = "/vnpayreturn")
public class VnpayReturn extends HttpServlet {
    private OrderService orderService;
    private OrderDetailService orderDetailService;
    private PaymentService paymentService;
    private StyleService styleService;
    private AddressService addressService;
    private CartService cartService;

    private static final String VNP_HASHSECRET = ConfigLoader.getProperty("vnp.hashsecret");

    @Override
    public void init() throws ServletException {
        super.init();
        orderService = new OrderService();
        orderDetailService = new OrderDetailService();
        paymentService = new PaymentService();
        styleService = new StyleService();
        addressService = new AddressService();
        cartService = new CartService();
        // deliveryService = new DeliveryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (!fieldValue.isEmpty())) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) fields.remove("vnp_SecureHashType");
        if (fields.containsKey("vnp_SecureHash")) fields.remove("vnp_SecureHash");

        // Sắp xếp và tạo hashData để kiểm tra
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = fields.get(fieldName);
            if ((fieldValue != null) && (!fieldValue.isEmpty())) {
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
            }
            if (itr.hasNext()) hashData.append('&');
        }
        String calculatedSecureHash = OrderServlet.hmacSHA512(VNP_HASHSECRET, hashData.toString());

        String vnp_TxnRefFromVnpay = request.getParameter("vnp_TxnRef");
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_AmountStr = request.getParameter("vnp_Amount");

        PendingOrderInfo pendingOrder = (PendingOrderInfo) session.getAttribute(vnp_TxnRefFromVnpay);

        if (pendingOrder == null) {
            request.setAttribute("errorMessage", "Không tìm thấy thông tin đơn hàng chờ xử lý (VNPAY).");
            request.getRequestDispatcher("/WEB-INF/views/payment-failure.jsp").forward(request, response);
            return;
        }

        // 1. KIỂM TRA CHỮ KÝ
        if (!calculatedSecureHash.equals(vnp_SecureHash)) {
            request.setAttribute("errorMessage", "Giao dịch VNPAY không hợp lệ (sai chữ ký).");
            session.removeAttribute(vnp_TxnRefFromVnpay);
            request.getRequestDispatcher("/WEB-INF/views/payment-failure.jsp").forward(request, response);
            return;
        }

        // 2. KIỂM TRA TRẠNG THÁI THANH TOÁN
        if ("00".equals(vnp_ResponseCode)) {
            // Thanh toán thành công
            try {
                User user = pendingOrder.getUser();
                Cart cart = pendingOrder.getCart();
                Address rawDeliveryAddress = pendingOrder.getDeliveryAddressDetails();

                // A. Lưu Address  - logic giống OrderServlet
                Address savedDeliveryAddress = findOrCreateAndSaveAddressInReturn(rawDeliveryAddress);


                // B. Lưu Order
                // Trạng thái đơn hàng sau khi VNPAY thành công
                Order newOrder = createAndSaveOrderToDbInReturn(user, cart);

                // C. Lưu OrderDetails và cập nhật kho - logic giống OrderServlet
                List<OrderDetail> orderDetails = createAndSaveOrderDetailsAndUpdateStockInReturn(newOrder.getId(), cart);
                newOrder.setListOfDetailOrder(orderDetails);

                // D. Lưu Delivery Info

                // E. LƯU PAYMENT RECORD CHO VNPAY
                Payment vnpayPayment = new Payment();
                vnpayPayment.setIdOrder(newOrder.getId());
                vnpayPayment.setMethod(2); // 2 = VNPAY
                vnpayPayment.setStatus("Completed"); // Giao dịch VNPAY thành công
                vnpayPayment.setTime(LocalDateTime.now());
                if (vnp_AmountStr != null) {
                    vnpayPayment.setPrice(Double.parseDouble(vnp_AmountStr) / 100.0);
                } else {
                    vnpayPayment.setPrice(cart.getLastPrice());
                }
                vnpayPayment.setVnpTxnRef(vnp_TxnRefFromVnpay); // Lưu mã giao dịch VNPAY
                paymentService.insertPayment(vnpayPayment);

                // Xóa thông tin tạm và giỏ hàng

                if (user != null) {
                    cartService.clearCartInDatabase(user.getId());
                }
                session.removeAttribute("cart");
                session.removeAttribute(vnp_TxnRefFromVnpay);
                Cart newEmptyCart = new Cart();
                if (user != null) newEmptyCart.setIdUser(user.getId());
                session.setAttribute("cart", newEmptyCart);


                request.setAttribute("orderId", newOrder.getId());
                request.setAttribute("message", "Thanh toán VNPAY và đặt hàng thành công!");
                request.getRequestDispatcher("payment-success.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                // Quan trọng: Log lỗi VNPAY thành công nhưng hệ thống lỗi.
                request.setAttribute("errorMessage", "VNPAY thành công nhưng có lỗi xử lý đơn hàng: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/error-page.jsp").forward(request, response);
            }
        } else {
            // Thanh toán VNPAY thất bại
            request.setAttribute("errorMessage", "Thanh toán VNPAY thất bại. Mã lỗi VNPAY: " + vnp_ResponseCode);
            session.removeAttribute(vnp_TxnRefFromVnpay); // Xóa thông tin tạm
            request.getRequestDispatcher("/WEB-INF/views/payment-failure.jsp").forward(request, response);
        }
    }

    private Order createAndSaveOrderToDbInReturn(User user, Cart cart) {
        Order order = new Order();
        order.setUser(user);
        if (cart.getAppliedVoucher() != null) order.setVoucher(cart.getAppliedVoucher());
        order.setTimeOrdered(LocalDateTime.now());
        order.setStatus("Đã thanh toán VNPAY");
        order.setTotalPrice(cart.getTotalPrice());
        order.setLastPrice(cart.getLastPrice());
        int newOrderId = orderService.insertOrder(order);
        if (newOrderId <= 0) throw new RuntimeException("Lỗi tạo đơn hàng (VNPAY Return).");
        order.setId(newOrderId);
        return order;
    }

    private List<OrderDetail> createAndSaveOrderDetailsAndUpdateStockInReturn(int orderId, Cart cart) {
        List<OrderDetail> createdOrderDetails = new ArrayList<>();
        for (CartItem item : cart.getCartItems()) {
            Style styleFromCart = item.getStyle();
            Style currentStyleInDB = styleService.getStyleByID(styleFromCart.getId());
            if (currentStyleInDB == null)
                throw new IllegalStateException("Sản phẩm " + styleFromCart.getProduct().getName() + " không tồn tại (VNPAY Return).");
            int quantityOrdered = item.getQuantity();
            if (quantityOrdered <= 0)
                throw new IllegalStateException("Số lượng đặt cho " + styleFromCart.getProduct().getName() + " phải > 0 (VNPAY Return).");
            if (quantityOrdered > currentStyleInDB.getQuantity())
                throw new IllegalStateException(styleFromCart.getProduct().getName() + " không đủ số lượng (VNPAY Return).");
            styleService.decreaseStyleAndProductQuantity(currentStyleInDB.getId(), currentStyleInDB.getProduct().getId(), quantityOrdered);
            OrderDetail orderDetail = new OrderDetail(orderId, currentStyleInDB, quantityOrdered);
            orderDetailService.insertOrderDetail(orderDetail);
            createdOrderDetails.add(orderDetail);
        }
        return createdOrderDetails;
    }

    private Address findOrCreateAndSaveAddressInReturn(Address rawAddress) {
        Address existingAddress = addressService.findAddress(rawAddress.getProvince(), rawAddress.getDistrict(), rawAddress.getWard(), rawAddress.getAddressDetail());
        if (existingAddress != null) return existingAddress;
        int newAddressId = addressService.insertAddress(rawAddress);
        if (newAddressId <= 0) throw new RuntimeException("Lỗi lưu địa chỉ (VNPAY Return).");
        rawAddress.setId(newAddressId);
        return rawAddress;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}