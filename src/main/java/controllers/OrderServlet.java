package controllers;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.*;
import services.*;
import utils.ConfigLoader;

@WebServlet(name = "OrderServlet", value = "/order")
public class OrderServlet extends HttpServlet {
    private OrderService orderService;
    private OrderDetailService orderDetailService;
    private AddressService addressService;
    private StyleService styleService;
    private PaymentService paymentService;
    private CartService cartService;

    // --- VNPAY CONFIGURATION ---
    private static final String VNP_VERSION = "2.1.0";
    private static final String VNP_COMMAND = "pay";
    private static final String VNP_TMNCODE = ConfigLoader.getProperty("vnp.tmncode");
    private static final String VNP_HASHSECRET = ConfigLoader.getProperty("vnp.hashsecret");
    private static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";

    @Override
    public void init() throws ServletException {
        super.init();
        orderService = new OrderService();
        orderDetailService = new OrderDetailService();
        DeliveryService deliveryService = new DeliveryService();
        addressService = new AddressService();
        styleService = new StyleService();
        paymentService = new PaymentService();
        cartService = new CartService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String paymentMethodChoice = request.getParameter("payment"); // "cod" hoặc "vnpay"
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        try {
            if (user == null) {
                session.setAttribute("redirectAfterLogin", request.getContextPath() + "/checkout.jsp");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            if (cart == null || cart.getCartItems().isEmpty()) {
                throw new IllegalStateException("Giỏ hàng trống.");
            }
            if (paymentMethodChoice == null || paymentMethodChoice.trim().isEmpty()) {
                throw new IllegalStateException("Vui lòng chọn phương thức thanh toán.");
            }

            String deliveryPersonName = getDeliveryPersonNameFromRequest(request, user);
            String deliveryPhone = getDeliveryPhoneFromRequest(request, user);
            Address rawDeliveryAddress = getRawDeliveryAddressFromRequest(request);
            String deliveryNotes = request.getParameter("shippingNotesHidden");
            if (deliveryNotes == null) deliveryNotes = "";

            if ("cod".equalsIgnoreCase(paymentMethodChoice)) {
                // XỬ LÝ COD

                // 2. Lưu Order
                Order newOrder = createAndSaveOrderToDb(user, cart, "Chờ xác nhận");

                // 3. Lưu OrderDetails và cập nhật kho
                List<OrderDetail> orderDetails = createAndSaveOrderDetailsAndUpdateStock(newOrder.getId(), cart);
                newOrder.setListOfDetailOrder(orderDetails);

                // 4. Lưu Delivery Info

                // 5. Lưu Payment record cho COD
                Payment codPayment = new Payment();
                codPayment.setIdOrder(newOrder.getId());
                codPayment.setMethod(1); // 1 = COD
                codPayment.setStatus("Pending");
                codPayment.setTime(LocalDateTime.now());
                codPayment.setPrice(cart.getLastPrice());
                codPayment.setVnpTxnRef(null);
                paymentService.insertPayment(codPayment);

                cartService.clearCartInDatabase(user.getId());
                removeCartFromSession(session);
                Cart newEmptyCart = new Cart();
                newEmptyCart.setIdUser(user.getId());
                session.setAttribute("cart", newEmptyCart);

                request.setAttribute("orderId", newOrder.getId());
                request.setAttribute("message", "Đặt hàng COD thành công!");
                request.getRequestDispatcher("payment-success.jsp").forward(request, response);

            } else if ("vnpay".equalsIgnoreCase(paymentMethodChoice)) {
                // XỬ LÝ VNPAY
                long amountVND = (long) cart.getLastPrice();
                if (amountVND <= 0) {
                    throw new IllegalStateException("Tổng giá trị đơn hàng không hợp lệ.");
                }

                String vnp_TxnRef = String.valueOf(System.currentTimeMillis()); // Mã giao dịch duy nhất cho VNPAY
                String orderInfoDescription = "Thanh toan don hang #" + vnp_TxnRef + " User: " + user.getEmail();

                // Lưu thông tin đơn hàng tạm vào session
                PendingOrderInfo pendingOrder = new PendingOrderInfo(
                        user, cart, rawDeliveryAddress,
                        deliveryPersonName, deliveryPhone, deliveryNotes,
                        paymentMethodChoice, vnp_TxnRef
                );
                session.setAttribute(vnp_TxnRef, pendingOrder);

                String vnp_IpAddr = getClientIpAddr(request);
                String paymentUrl = createVnpayPaymentUrl(vnp_TxnRef, amountVND, orderInfoDescription, vnp_IpAddr, request);

                response.sendRedirect(paymentUrl);

            } else {
                throw new IllegalArgumentException("Phương thức thanh toán không hỗ trợ.");
            }

        } catch (IllegalStateException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/checkout.jsp?errorMessage=" + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8));
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi xử lý đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error-page.jsp").forward(request, response);
        }
    }


    // Phương thức tạo Order và lưu vào DB (có thể điều chỉnh tên và tham số)
    private Order createAndSaveOrderToDb(User user, Cart cart, String initialStatusOrder) {
        Order order = new Order();
        order.setUser(user);
        if (cart.getAppliedVoucher() != null) {
            order.setVoucher(cart.getAppliedVoucher());
        }
        order.setTimeOrdered(LocalDateTime.now()); // Dùng LocalDateTime
        order.setStatus(initialStatusOrder); // Ví dụ: "Chờ xác nhận", "Đang xử lý"
        order.setTotalPrice(cart.getTotalPrice());
        order.setLastPrice(cart.getLastPrice());

        int newOrderId = orderService.insertOrder(order);
        if (newOrderId <= 0) {
            throw new RuntimeException("Lỗi khi tạo đơn hàng mới.");
        }
        order.setId(newOrderId);
        return order;
    }

    // Phương thức tạo OrderDetails và lưu, cập nhật kho
    private List<OrderDetail> createAndSaveOrderDetailsAndUpdateStock(int orderId, Cart cart) {
        List<OrderDetail> createdOrderDetails = new ArrayList<>();
        if (cart == null || cart.getCartItems().isEmpty()) {
            throw new IllegalStateException("Không thể tạo chi tiết đơn hàng từ giỏ hàng trống.");
        }

        for (CartItem item : cart.getCartItems()) {
            Style styleFromCart = item.getStyle();
            if (styleFromCart == null || styleFromCart.getProduct() == null) {
                throw new IllegalStateException("Một sản phẩm trong giỏ hàng có thông tin không hợp lệ.");
            }

            Style currentStyleInDB = styleService.getStyleByID(styleFromCart.getId());
            if (currentStyleInDB == null) {
                throw new IllegalStateException("Sản phẩm '" + styleFromCart.getProduct().getName() + " - " + styleFromCart.getName() + "' không còn tồn tại.");
            }

            int quantityOrdered = item.getQuantity();
            if (quantityOrdered <= 0) {
                throw new IllegalStateException("Số lượng đặt cho sản phẩm '" + styleFromCart.getProduct().getName() + "' phải lớn hơn 0.");
            }
            if (quantityOrdered > currentStyleInDB.getQuantity()) {
                throw new IllegalStateException("Sản phẩm '" + styleFromCart.getProduct().getName() + " - " + styleFromCart.getName() + "' không đủ số lượng. Yêu cầu: " + quantityOrdered + ", Hiện có: " + currentStyleInDB.getQuantity() + ".");
            }

            boolean updateSuccess = styleService.decreaseStyleAndProductQuantity(currentStyleInDB.getId(), currentStyleInDB.getProduct().getId(), quantityOrdered);
            if (!updateSuccess) {
                throw new RuntimeException("Lỗi khi cập nhật số lượng tồn kho cho sản phẩm: " + currentStyleInDB.getProduct().getName());
            }

            OrderDetail orderDetail = new OrderDetail(orderId, currentStyleInDB, quantityOrdered);
            orderDetailService.insertOrderDetail(orderDetail);
            createdOrderDetails.add(orderDetail);
        }
        return createdOrderDetails;
    }


    private Address getRawDeliveryAddressFromRequest(HttpServletRequest request) {
        String billingAddressOption = request.getParameter("SameOtherAddress");
        String detail, ward, district, province;

        if ("same_as_shipping".equals(billingAddressOption)) {
            detail = request.getParameter("shippingDetailHidden");
            ward = request.getParameter("shippingWardHidden");
            district = request.getParameter("shippingDistrictHidden");
            province = request.getParameter("shippingProvinceHidden");
        } else if ("different_billing".equals(billingAddressOption)) {
            detail = request.getParameter("billingDetail");
            ward = request.getParameter("billingWard");
            district = request.getParameter("billingDistrict");
            province = request.getParameter("billingProvince");
        } else {
            detail = request.getParameter("shippingDetailHidden");
            ward = request.getParameter("shippingWardHidden");
            district = request.getParameter("shippingDistrictHidden");
            province = request.getParameter("shippingProvinceHidden");
            if ((detail == null || detail.trim().isEmpty()) && (request.getParameter("billingDetail") != null && !request.getParameter("billingDetail").trim().isEmpty())) {
                detail = request.getParameter("billingDetail");
                ward = request.getParameter("billingWard");
                district = request.getParameter("billingDistrict");
                province = request.getParameter("billingProvince");
            }
        }
        if (detail == null || detail.trim().isEmpty() || ward == null || ward.trim().isEmpty() || district == null || district.trim().isEmpty() || province == null || province.trim().isEmpty()) {
            throw new IllegalStateException("Thông tin địa chỉ giao hàng không đầy đủ.");
        }
        return new Address(0, province.trim(), district.trim(), ward.trim(), detail.trim());
    }

    private Address findOrCreateAndSaveAddress(Address rawAddress) {
        Address existingAddress = addressService.findAddress(rawAddress.getProvince(), rawAddress.getDistrict(), rawAddress.getWard(), rawAddress.getAddressDetail());
        if (existingAddress != null) {
            return existingAddress;
        } else {
            int newAddressId = addressService.insertAddress(rawAddress);
            if (newAddressId <= 0) {
                throw new RuntimeException("Lỗi khi lưu địa chỉ mới.");
            }
            rawAddress.setId(newAddressId);
            return rawAddress;
        }
    }

    private String getDeliveryPersonNameFromRequest(HttpServletRequest request, User user) {
        String billingAddressOption = request.getParameter("SameOtherAddress");
        String name = null;
        if ("same_as_shipping".equals(billingAddressOption)) {
            name = request.getParameter("shippingFullNameHidden");
        } else if ("different_billing".equals(billingAddressOption)) {
            name = request.getParameter("billingFullName");
        }
        if (name == null || name.trim().isEmpty()) {
            name = (user != null && user.getFullname() != null) ? user.getFullname() : null;
        }
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalStateException("Tên người nhận hàng không được để trống.");
        }
        return name.trim();
    }

    private String getDeliveryPhoneFromRequest(HttpServletRequest request, User user) {
        String billingAddressOption = request.getParameter("SameOtherAddress");
        String phone = null;
        if ("same_as_shipping".equals(billingAddressOption)) {
            phone = request.getParameter("shippingPhoneHidden");
        } else if ("different_billing".equals(billingAddressOption)) {
            phone = request.getParameter("billingPhone");
        }
        if (phone == null || phone.trim().isEmpty()) {
            phone = (user != null && user.getPhoneNumber() != null) ? user.getPhoneNumber() : null;
        }
        if (phone == null || phone.trim().isEmpty()) {
            throw new IllegalStateException("Số điện thoại người nhận hàng không được để trống.");
        }
        return phone.trim();
    }

    private void removeCartFromSession(HttpSession session) {
        session.removeAttribute("cart");
    }

    private String getClientIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) ip = request.getHeader("Proxy-Client-IP");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) ip = request.getHeader("WL-Proxy-Client-IP");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) ip = request.getHeader("HTTP_CLIENT_IP");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip))
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) ip = request.getRemoteAddr();
        if (ip != null && ip.contains(",")) ip = ip.split(",")[0].trim();
        return ip;
    }

    public static String hmacSHA512(String key, String data) {
        try {
            Mac hmac512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac512.init(secretKey);
            byte[] bytes = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception ex) {
            throw new RuntimeException("HMAC SHA512 generation failed", ex);
        }
    }

    private String createVnpayPaymentUrl(String vnp_TxnRef, long amountVND, String orderInfo, String ipAddr, HttpServletRequest request) {
        long amountForVnpay = amountVND * 100;
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", VNP_VERSION);
        vnp_Params.put("vnp_Command", VNP_COMMAND);
        vnp_Params.put("vnp_TmnCode", VNP_TMNCODE);
        vnp_Params.put("vnp_Amount", String.valueOf(amountForVnpay));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", orderInfo);
        vnp_Params.put("vnp_OrderType", "other");
        vnp_Params.put("vnp_Locale", "vn");
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();
        String contextPath = request.getContextPath();
        String returnUrl = scheme + "://" + serverName + ((serverPort == 80 || serverPort == 443) ? "" : ":" + serverPort) + contextPath + "/vnpayreturn";
        vnp_Params.put("vnp_ReturnUrl", returnUrl);
        vnp_Params.put("vnp_IpAddr", ipAddr);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String vnp_CreateDate = LocalDateTime.now().format(formatter);
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = vnp_Params.get(fieldName);
            if ((fieldValue != null) && (!fieldValue.isEmpty())) {
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String secureHash = hmacSHA512(VNP_HASHSECRET, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + secureHash;
        return VNP_URL + "?" + queryUrl;
    }
}