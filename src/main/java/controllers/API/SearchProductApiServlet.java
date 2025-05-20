package controllers.API;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.LocalDateAdapter;
import services.ToTalProductService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SearchProductApiServlet", value = "/api/products")
public class SearchProductApiServlet extends HttpServlet {
    int nuPerPage = 12;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String input = request.getParameter("input");


        ToTalProductService ps = new ToTalProductService();
        List<Product> products = ps.searchProductByName(input);


        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                .setDateFormat("yyyy-MM-dd") // Optional: định dạng ngày tổng thể
                .create();
        // Tạo đối tượng để chứa dữ liệu trả về
        Map<String, Object> data = new HashMap<>();
        data.put("products", products);

        String json = gson.toJson(data);

        response.getWriter().write(json);
    }

}