package controllers;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import services.ProductService;
import services.StyleService;

@WebServlet(name = "ProductFabricServlet", value = "/product-fabric")
public class ProductFabricServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int option = request.getParameter("option") == null ? 0 : Integer.parseInt(request.getParameter("option"));
        option = (option < 0 || option > 5) ? 0 : option;

        ProductService ps = new ProductService();

        int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

        List<Product> products = ps.getProductsByCategorySort(2, currentPage, 12, option);

        request.setAttribute("fabric", products);
        request.setAttribute("pageNumber", ps.getNumberOfPage(2, 12));
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("option", option);

        request.getRequestDispatcher("fabric-product.jsp").forward(request, response);
    }
}
