package controllers;

import java.io.*;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import models.Style;
import services.ToTalProductService;

@WebServlet(name = "AjaxProductServlet", value = "/ajax-product")
public class AjaxProductServlet extends HttpServlet {
    int nuPerPage = 12;

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Get parameters
        String option = request.getParameter("option");
        String selection = request.getParameter("selection");
        String param = request.getParameter("currentPage");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");

        // Set default values
        if (selection == null) selection = "all";
        if (option == null) option = "1";
        int currentPage = (param != null) ? Integer.parseInt(param) : 1;

        // Get products based on filters
        ToTalProductService ps = new ToTalProductService();
        List<Product> products = ps.getProducts(selection, currentPage, nuPerPage, option, minPrice, maxPrice);
        int nupage = ps.getNuPage(nuPerPage, selection);

        // Create JSON response
        JsonObject jsonResponse = new JsonObject();
        JsonArray productsArray = new JsonArray();

        // Format the products data
        for (Product product : products) {
            JsonObject productJson = new JsonObject();
            productJson.addProperty("id", product.getId());
            productJson.addProperty("name", product.getName());
            productJson.addProperty("description", product.getDescription());
            productJson.addProperty("image", product.getImage());
            productJson.addProperty("price", product.getPrice().getPrice());
            productJson.addProperty("lastPrice", product.getPrice().getLastPrice());
            productJson.addProperty("discountPercent", product.getPrice().getDiscountPercent());

            // Handle styles
            if (product.getStyles() != null && !product.getStyles().isEmpty()) {
                JsonArray stylesArray = new JsonArray();
                for (Style style : product.getStyles()) {
                    JsonObject styleJson = new JsonObject();
                    styleJson.addProperty("id", style.getId());
                    styleJson.addProperty("name", style.getName());
                    styleJson.addProperty("image", style.getImage());
                    stylesArray.add(styleJson);
                }
                productJson.add("styles", stylesArray);
            }

            productsArray.add(productJson);
        }

        // Add data to response
        jsonResponse.add("products", productsArray);
        jsonResponse.addProperty("pageNumber", nupage);
        jsonResponse.addProperty("currentPage", currentPage);
        jsonResponse.addProperty("option", option);
        jsonResponse.addProperty("selection", selection);
        jsonResponse.addProperty("minPrice", minPrice);
        jsonResponse.addProperty("maxPrice", maxPrice);

        // Write JSON response
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }
}
