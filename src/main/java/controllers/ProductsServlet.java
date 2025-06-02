package controllers;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import models.Category;
import services.ToTalProductService;
import services.CategoryService;

@WebServlet(name = "ProductsServlet", value = "/products")
public class ProductsServlet extends HttpServlet {
    int nuPerPage = 12;
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String option = request.getParameter("option");
            String selection = request.getParameter("selection");
            String param = request.getParameter("page");
            String minPrice = request.getParameter("minPrice");
            String maxPrice = request.getParameter("maxPrice");
            String[] categories = request.getParameterValues("categories");

            // Validate and set default values
            if (selection == null) selection = "all";
            int currentPage = 1;
            try {
                if (param != null) {
                    currentPage = Integer.parseInt(param);
                    if (currentPage < 1) currentPage = 1;
                }
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
            
            // Convert option to the correct format
            String sortOption = "latest";
            if (option != null && !option.isEmpty()) {
                switch (option) {
                    case "1":
                        sortOption = "latest";
                        break;
                    case "2":
                        sortOption = "expensive";
                        break;
                    case "3":
                        sortOption = "cheap";
                        break;
                    case "4":
                        sortOption = "bestselling";
                        break;
                    case "5":
                        sortOption = "discount";
                        break;
                    default:
                        sortOption = "latest";
                }
            }

            // Load categories for filter
            CategoryService categoryService = new CategoryService();
            List<Category> allCategories = categoryService.getAllCategories();
            request.setAttribute("categories", allCategories);

            ToTalProductService ps = new ToTalProductService();
            List<Product> products;
            
            // Apply filters
            if (categories != null && categories.length > 0) {
                // If categories are selected, filter by categories
                //products = ps.getProductsByCategories(categories, currentPage, nuPerPage, sortOption, minPrice, maxPrice);
            } else {
                // Otherwise use normal product loading
                products = ps.getProducts(selection, currentPage, nuPerPage, sortOption, minPrice, maxPrice);
            }
            
            int nupage = ps.getNuPage(nuPerPage, selection);

            //request.setAttribute("products", products);
            request.setAttribute("nupage", nupage);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("option", option);
            request.setAttribute("selection", selection);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("selectedCategories", categories);

            request.getRequestDispatcher("products.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the error
            e.printStackTrace();
            // Set error message
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách sản phẩm. Vui lòng thử lại sau.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }
}