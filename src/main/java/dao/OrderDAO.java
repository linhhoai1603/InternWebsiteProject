package dao;

import connection.DBConnection;
import models.Address;
import models.Order;
import models.User;
import models.Voucher;
import org.jdbi.v3.core.Jdbi;
import services.OrderService;

import java.time.LocalDateTime;

public class OrderDAO {
    Jdbi jdbi;
    public OrderDAO(){
        jdbi = DBConnection.getConnetion();
    }
    public int insertOrder(Order order) {
        String query = "INSERT INTO orders (timeOrdered, userId, voucherId, status, totalPrice, lastPrice) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        return jdbi.withHandle(handle -> {
            // Đảm bảo bạn sử dụng LocalDateTime khi chèn vào cơ sở dữ liệu
            LocalDateTime timeOrdered = order.getTimeOrdered();  // Lấy thời gian từ Order (LocalDateTime)

            return handle.createUpdate(query)
                    .bind(0, timeOrdered)  // Lưu LocalDateTime
                    .bind(1, order.getUser().getId()) // Lấy user ID từ đối tượng User
                    .bind(2, order.getVoucher() != null ? order.getVoucher().getId() : null) // Xử lý voucher null
                    .bind(3, order.getStatus()) // Trạng thái đơn hàng
                    .bind(4, order.getTotalPrice()) // Tổng tiền đơn hàng
                    .bind(5, order.getLastPrice()) // Tổng tiền sau giảm giá
                    .executeAndReturnGeneratedKeys("id") // Lấy ID tự động tạo
                    .mapTo(Integer.class) // Chuyển đổi giá trị ID sang Integer
                    .findOnly(); // Trả về duy nhất 1 ID
        });
    }


    public int getLastId(){
        String query = "select max(id) from orders";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .mapTo(Integer.class)
                    .one();
        });
    }

    public static void main(String[] args) {
        // Tạo đối tượng User
        Address address = new Address(1, "123 Main Street", "Commune A", "Hanoi", "Vietnam");
        User user = new User(1, "nguyen@example.com", "Nguyen Van A", "0987654321", address, "profile_image.jpg");

        // Tạo đối tượng Voucher
        Voucher voucher = new Voucher(1, "VOUCHER10", 10.0, 100.0, 1);

        // Tạo đối tượng Order
        LocalDateTime timeOrdered = LocalDateTime.now(); // Thời gian hiện tại
        Order order = new Order(user, voucher, "Đang giao hàng", 500.0, 450.0);
        order.setTimeOrdered(timeOrdered);
        // Tạo đối tượng OrderService để gọi hàm insertOrder
        OrderService orderService = new OrderService();

        // Gọi hàm insertOrder và in kết quả ID
        int orderId = orderService.insertOrder(order);
        System.out.println("Inserted order ID: " + orderId);

        // Kiểm tra ID trả về có hợp lệ không
        if (orderId > 0) {
            System.out.println("Order inserted successfully with ID: " + orderId);
        } else {
            System.out.println("Order insertion failed.");
        }
    }
}
