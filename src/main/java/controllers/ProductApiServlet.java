package controllers;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ToTalProductService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductApiServlet", value = "/api/products")
public class ProductApiServlet extends HttpServlet {
    int nuPerPage = 12;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String option = request.getParameter("option");
        String selection = request.getParameter("selection");
        String param = request.getParameter("currentPage");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");

        if (selection == null) selection = "all";
        int currentPage = (param != null) ? Integer.parseInt(param) : 1;
        if (option == null || option.isEmpty()) option = "latest";

        ToTalProductService ps = new ToTalProductService();
        List<Product> products = ps.getProducts(selection, currentPage, nuPerPage, option, minPrice, maxPrice);
        int nupage = ps.getNuPage(nuPerPage, selection);

        // Tạo đối tượng để chứa dữ liệu trả về
        Map<String, Object> data = new HashMap<>();
        data.put("products", products);
        data.put("nupage", nupage);
        data.put("currentPage", currentPage);

        // Chuyển đổi sang JSON
        String json = new Gson().toJson(data);
        response.getWriter().write(json);
    }
}