package controllers;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import services.ProductService;
import services.StyleService;

@WebServlet(name = "AdminManagerProduct", value = "/admin/admin-manager-products")
public class AdminManagerProduct extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String method = request.getParameter("method");
        if("getAllProducts".equals(method)) {
            getAllProducts(request, response);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        getAllProducts(request, response);
    }

    private void getAllProducts(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ProductService ps = new ProductService();
        StyleService ss = new StyleService();
        List<Product> products = ps.getProductsByCategorySort(0, 1, 20, 0);
        for(Product product : products){
            product.setStyles(ss.getAllStylesByIDProduct(product.getId()));
        }
        request.setAttribute("products", products);
        request.getRequestDispatcher("management-products.jsp").forward(request, response);
    }


}