package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.*;
import services.*;

@WebServlet(name = "OrderServlet", value = "/order")
public class OrderServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // get info and create order from cart
        // get method payment
        String methodPay = request.getParameter("payment");
        if("cash".equals(methodPay)) {
          Ordered ordered = createOrder(request, response);
            // remove cart
            removeCart(request, response);
            // set attribute
            request.setAttribute("ordered", ordered);
            // forward to payment-success.jsp
            request.setAttribute("message", "Đặt hàng thành công!");
            request.getRequestDispatcher("payment-success.jsp").forward(request, response);
        } else {

        }
    }

    private void removeCart(HttpServletRequest request, HttpServletResponse response) {
       Cart cart = new Cart();
         request.getSession().setAttribute("cart", cart);
    }

    private Ordered createOrder(HttpServletRequest request, HttpServletResponse response) {
        OrderService orderService = new OrderService();
        OrderDetailService orderDetailService = new OrderDetailService();
        DeliveryService deliveryService = new DeliveryService();
        AddressService addressService = new AddressService();
        StyleService styleService = new StyleService();


        // Kiểm tra session và lấy thông tin
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            throw new IllegalStateException("Giỏ hàng trống hoặc không tồn tại.");
        }

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            throw new IllegalStateException("Người dùng chưa đăng nhập.");
        }

        // Tạo order
        Voucher voucher = cart.getVoucher();
        String status = "Đang giao hàng";
        double totalPrice = cart.getTotalPrice();
        double lastPrice = cart.getLastPrice();
        Order order = new Order(user, voucher, status, totalPrice, lastPrice);
        int idOrder = orderService.insertOrder(order); // Trả về idOrder sau khi chèn

        // Tạo chi tiết đơn hàng
        for (CartItem item : cart.getItems().values()) {
            Style style = item.getStyle();
            int quantity = item.getQuantity();
            if (quantity > style.getProduct().getQuantity()) {
                throw new IllegalStateException("Số lượng sản phẩm không đủ.");
            }else{
                style.getProduct().setQuantity(style.getProduct().getQuantity() - quantity);
                style.setQuantity(style.getQuantity() - quantity);
                styleService.updateQuantityForStyle(style.getId(), style.getQuantity());
                styleService.updateQuantityForProduct(style.getProduct().getId(), style.getProduct().getQuantity());
                OrderDetail orderDetail = new OrderDetail(idOrder, style, quantity);
                orderDetailService.insertOrderDetail(orderDetail);
                order.getListOfDetailOrder().add(orderDetail);
            }
        }

        // Xử lý thông tin giao hàng
        String otherAddress = request.getParameter("otherAddress");
        String note = request.getParameter("note");
        Delivery delivery;

        if (otherAddress == null) {
            if (user.getAddress() == null) {
                throw new IllegalStateException("Người dùng không có địa chỉ mặc định.");
            }
            delivery = new Delivery(
                    idOrder, user.getAddress().getId(), user.getFullName(), user.getNumberPhone(),
                    cart.getTotalArea(), cart.getShippingFee(), note, "Đang giao hàng"
            );
        } else {
            int idAddress = addressService.getLastId() + 1;
            String street = request.getParameter("o-street");
            String commune = request.getParameter("o-commune");
            String city = request.getParameter("o-city");
            String province = request.getParameter("o-province");
            Address address = new Address(idAddress, street, commune, city, province);
            addressService.insertAddress(address);

            String fullName = request.getParameter("o-fullName");
            String phone = request.getParameter("o-phone");
            delivery = new Delivery(
                    idOrder, idAddress, fullName, phone,
                    cart.getTotalArea(), cart.getShippingFee(), note, "Đang giao hàng"
            );
        }

        deliveryService.insertDelivery(delivery);

        // Trả về đối tượng Ordered
        return new Ordered(
                cart, idOrder, order.getTimeOrdered(),
                user.getFullName(), delivery.getNote(),
                addressService.getAddressById(delivery.getIdAddress()).getAddressDetail(), delivery.getStatus()
        );
    }

}