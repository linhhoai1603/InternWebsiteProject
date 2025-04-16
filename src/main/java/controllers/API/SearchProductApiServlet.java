package controllers.API;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.LocalDateAdapter;
import services.ProductService;
import services.ToTalProductService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SearchProductApiServlet", value = "/api/products")
public class SearchProductApiServlet extends HttpServlet {

    ToTalProductService productService = new ToTalProductService(); // Gọi service xử lý DB

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Lấy tham số
        String name = request.getParameter("name");
        String idRaw = request.getParameter("id");

        List<Product> result = new ArrayList<>();

        // Tìm theo id nếu có
        if (idRaw != null && !idRaw.isEmpty()) {
            try {
                int id = Integer.parseInt(idRaw);
                Product p = productService.getProductById(id);
                if (p != null) {
                    result.add(p);
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid id format");
                return;
            }
        }

        // Nếu không có id thì tìm theo tên gần đúng
        else if (name != null && !name.trim().isEmpty()) {
            result = productService.searchProductByName(name.trim());
        }

        // JSON Adapter
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                .setDateFormat("yyyy-MM-dd")
                .create();

        // Trả về dữ liệu JSON
        String json = gson.toJson(result);
        response.getWriter().write(json);
    }
}
