package controllers;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import services.ProductService2;
import services.StyleService;

@WebServlet(name = "ProductsServlet", value = "/products")
public class ProductsServlet extends HttpServlet {
    int nuPerPage = 12;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String option = request.getParameter("option");
        String category = request.getParameter("category");

        String param = request.getParameter("currentPage");
        int currentPage = (param != null) ? Integer.parseInt(param) : 1;

        if(option.isEmpty() || option == null) option = "Mới nhất";

        List<Product> products;
        ProductService2 ps = new ProductService2();
        int nupage = ps.getNuPage(nuPerPage);
        if(category.isEmpty() || category == null){
            products = ps.getAllProducts(currentPage,nuPerPage,option);

        }else{
            products = ps.getProductByCategoryName(category,currentPage,nuPerPage,option);

        }
        request.setAttribute("products", products);
        request.setAttribute("pageNumber", nupage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("option", option);

        request.getRequestDispatcher("zipstar-product.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }

}