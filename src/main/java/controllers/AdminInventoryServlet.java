package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ToTalProductService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AdminInventory", value = "/admin/inventory")
public class AdminInventoryServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        List<Integer> productIds = new ArrayList<>();
        String[] list = request.getParameterValues("id");

        if (list != null) {
            for (String idStr : list) {
                try {
                    productIds.add(Integer.parseInt(idStr));
                } catch (NumberFormatException e) {
                    // Có thể ghi log hoặc bỏ qua ID lỗi
                    System.err.println("ID không hợp lệ: " + idStr);
                }
            }
        }
        ToTalProductService service = new ToTalProductService();
        List<Product> products = service.getProductsByIds(productIds);

        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/inventory.jsp").forward(request, response);
    }


}
