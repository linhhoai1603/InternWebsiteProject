package controllers;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import services.ProductService;
import services.StyleService;

@WebServlet(name = "ProductsServlet", value = "/products")
public class ProductsServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int option = request.getParameter("option") == null ? 0 : Integer.parseInt(request.getParameter("option"));
        option = (option < 0 || option > 5) ? 0 : option;

        ProductService ps = new ProductService();

        int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

        List<Product> products = ps.getProductsByCategorySort(0, currentPage, 16, option);
        StyleService ss = new StyleService();
        for (Product product : products) {
            product.setStyles(ss.getAllStylesByIDProduct(product.getId()));
        }

        request.setAttribute("products", products);
        request.setAttribute("pageNumber", ps.getNumberOfPage(0, 16));
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("option", option);

        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

}