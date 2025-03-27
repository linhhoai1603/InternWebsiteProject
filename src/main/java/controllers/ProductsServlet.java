package controllers;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import services.ProductService;
import services.StyleService;

@WebServlet(name = "ProductsServlet", value = "/product")
public class ProductsServlet extends HttpServlet {
    int nuPerPage = 12;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String option = request.getParameter("option");
        String selection = request.getParameter("selection");
        String param = request.getParameter("currentPage");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");

        int currentPage = (param != null) ? Integer.parseInt(param) : 1;
        if(option.isEmpty() || option == null) option = "Mới nhất";

        ProductService ps = new ProductService();


        request.setAttribute("currentPage", currentPage);
        request.setAttribute("option", option);
        request.setAttribute("selection", selection);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);

        request.getRequestDispatcher("zipstar-product.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }

}