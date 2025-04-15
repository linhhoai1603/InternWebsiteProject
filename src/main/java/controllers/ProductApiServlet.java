package controllers;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ToTalProductService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import services.LocalDateAdapter;

@WebServlet(name = "ProductApiServlet", value = "/api/products")
public class ProductApiServlet extends HttpServlet {
    int nuPerPage = 12;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String option = request.getParameter("option");
        String selection = request.getParameter("selection");
        String param = request.getParameter("currentPage");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");

        if (selection == null || selection.isBlank() ) selection = "all";

        int currentPage = (param != null) ? Integer.parseInt(param) : 1;
        if (option == null || option.isEmpty()) option = "latest";

        ToTalProductService ps = new ToTalProductService();
        List<Product> products = ps.getProducts(selection, currentPage, nuPerPage, option, minPrice, maxPrice);
        int nupage = ps.getNuPage(nuPerPage, selection);

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                .setDateFormat("yyyy-MM-dd") // Optional: định dạng ngày tổng thể
                .create();
        // Tạo đối tượng để chứa dữ liệu trả về
        Map<String, Object> data = new HashMap<>();
        data.put("products", products);
        data.put("selection", selection);
        data.put("nupage", nupage);
        data.put("currentPage", currentPage);

        // Chuyển đổi sang JSON
        String json = gson.toJson(data);

        response.getWriter().write(json);
    }

}