package controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import services.OrderService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "manager-order", value = "/admin/manager-order")
public class AdminManagerOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int loca = request.getParameter("loca") == null ? 1 : Integer.parseInt(request.getParameter("loca"));
        OrderService os = new OrderService();
        int nuPage = os.getNuPage(5);
        List<Order> orders = os.getOrdersByPage(loca,5);
        request.setAttribute("orders", orders);
        request.setAttribute("nuPage", nuPage);
        request.setAttribute("loca", loca);

        request.getRequestDispatcher("management-orders.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            int id = Integer.parseInt(request.getParameter("idOrder"));
            OrderService os = new OrderService();
            Order order = os.getOrder(id);

            if(order == null){
                request.setAttribute("error", "Đơn hàng không tồn tại");
                request.getRequestDispatcher("management-orders.jsp").forward(request, response);
                return;
            }else {
                response.sendRedirect(request.getContextPath() + "/admin/order-detail?orderId="+order.getId());
            }

        }catch (NumberFormatException e){
            request.setAttribute("error", "Không tồn mã đơn hang");
            request.getRequestDispatcher("management-orders.jsp").forward(request, response);
        }
    }

}