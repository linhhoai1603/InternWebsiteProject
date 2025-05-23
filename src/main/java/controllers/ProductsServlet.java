package controllers;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import services.ProductService;
import services.StyleService;
import services.ToTalProductService;

@WebServlet(name = "ProductsServlet", value = "/products")
public class ProductsServlet extends HttpServlet {
    int nuPerPage = 12;
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String option = request.getParameter("option");
            String selection = request.getParameter("selection");
            String param = request.getParameter("currentPage");
            String minPrice = request.getParameter("minPrice");
            String maxPrice = request.getParameter("maxPrice");

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
            
            if(option == null || option.isEmpty()) option = "latest";

            ToTalProductService ps = new ToTalProductService();
            List<Product> products = ps.getProducts(selection, currentPage, nuPerPage, option, minPrice, maxPrice);
            int nupage = ps.getNuPage(nuPerPage, selection);

            request.setAttribute("products", products);
            request.setAttribute("nupage", nupage);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("option", option);
            request.setAttribute("selection", selection);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);

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