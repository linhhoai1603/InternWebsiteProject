package dao;

import connection.DBConnection;

import models.*;

import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class OrderDetailDAO {
    Jdbi jdbi;
    public OrderDetailDAO(){ this.jdbi = DBConnection.getConnetion();
    }
    public boolean insertOrderDetail(OrderDetail detail){
        String query = "insert into order_details values (?,?,?,?,?,?)";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, detail.getId())
                    .bind(1, detail.getIdOrder())
                    .bind(2, detail.getStyle().getId())
                    .bind(3, detail.getQuantity())
                    .bind(4, detail.getTotalPrice())
                    .bind(5, detail.getWeight())
                    .execute() > 0;
        });
    }

    public List<OrderDetail> getOrderDetailByOrder(int idOrder) {
        String query = """
        SELECT od.id AS idOrderDetail,
               od.idOrder,
               od.idStyle,
               od.quantity,
               od.totalPrice,
               od.weight,
               s.name AS styleName,
               p.name AS productName,
               p.id AS productId,

               c.id AS categoryId,
                c.name AS categoryName,
                pr.id AS priceId,
                pr.lastPrice
        FROM order_details od
        JOIN styles s ON od.idStyle = s.id
        JOIN products p ON s.idProduct = p.id
        JOIN categories c ON p.idCategory = c.id
        JOIN prices pr ON p.idPrice = pr.id

        WHERE od.idOrder = :idOrder;
    """;
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind("idOrder", idOrder)
                    .map((rs, ctx) -> {
                        OrderDetail orderDetail = new OrderDetail();
                        orderDetail.setId(rs.getInt("idOrderDetail"));
                        orderDetail.setIdOrder(rs.getInt("idOrder"));
                        orderDetail.setQuantity(rs.getInt("quantity"));
                        orderDetail.setTotalPrice(rs.getDouble("totalPrice"));
                        orderDetail.setWeight(rs.getDouble("weight"));


                        Style style = new Style();
                        style.setId(rs.getInt("idStyle"));
                        style.setName(rs.getString("styleName"));
                        orderDetail.setStyle(style);

                        Product product = new Product();
                        product.setName(rs.getString("productName"));
                        product.setId(rs.getInt("productId"));
                        style.setProduct(product);

                        Price price = new Price();
                        price.setId(rs.getInt("priceId"));
                        price.setLastPrice(rs.getDouble("lastPrice"));
                        product.setPrice(price);

                        Category category = new Category();
                        category.setId(rs.getInt("categoryId"));
                        category.setName(rs.getString("categoryName"));
                        product.setCategory(category);


                        return orderDetail;
                    })
                    .list();
        });
    }

    public OrderDetail getOrderDetailById(int id) {
        String query = """
        SELECT od.id AS idOrderDetail,
               od.idOrder,
               od.idStyle,
               od.quantity,
               od.totalPrice,
               od.weight,
               s.name AS styleName,
               p.name AS productName,
               p.id AS productId,
               c.id AS categoryId,
               c.name AS categoryName,
               pr.id AS priceId,
               pr.lastPrice
        FROM order_details od
        JOIN styles s ON od.idStyle = s.id
        JOIN products p ON s.idProduct = p.id
        JOIN categories c ON p.idCategory = c.id
        JOIN prices pr ON p.idPrice = pr.id
        WHERE od.id = :id;
    """;
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind("id", id)
                    .map((rs, ctx) -> {
                        OrderDetail orderDetail = new OrderDetail();
                        orderDetail.setId(rs.getInt("idOrderDetail"));
                        orderDetail.setIdOrder(rs.getInt("idOrder"));
                        orderDetail.setQuantity(rs.getInt("quantity"));
                        orderDetail.setTotalPrice(rs.getDouble("totalPrice"));
                        orderDetail.setWeight(rs.getDouble("weight"));

                        Style style = new Style();
                        style.setId(rs.getInt("idStyle"));
                        style.setName(rs.getString("styleName"));
                        orderDetail.setStyle(style);

                        Product product = new Product();
                        product.setName(rs.getString("productName"));
                        product.setId(rs.getInt("productId"));
                        style.setProduct(product);

                        Price price = new Price();
                        price.setId(rs.getInt("priceId"));
                        price.setLastPrice(rs.getDouble("lastPrice"));
                        product.setPrice(price);

                        Category category = new Category();
                        category.setId(rs.getInt("categoryId"));
                        category.setName(rs.getString("categoryName"));
                        product.setCategory(category);

                        return orderDetail;
                    })
                    .findOne().orElse(null);
        });
    }

    public static void main(String[] args) {
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailByOrder(1);
        System.out.println(orderDetails);
    }

    public boolean deleteOrderDetailById(int id) {
        String query = "DELETE FROM order_details WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bind("id", id)
                        .execute() > 0
        );
    }

    public boolean updateOrderDetail(OrderDetail orderDetail) {
        String query = "UPDATE order_details SET idStyle = :idStyle, quantity = :quantity, " +
                "totalPrice = :totalPrice, weight = :weight WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bind("idStyle", orderDetail.getStyle().getId())
                        .bind("quantity", orderDetail.getQuantity())
                        .bind("totalPrice", orderDetail.getTotalPrice())
                        .bind("weight", orderDetail.getWeight())
                        .bind("id", orderDetail.getId())
                        .execute() > 0
        );
    }
}
