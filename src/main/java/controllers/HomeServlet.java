package controllers;

import java.io.*;
import java.util.List;

import dao.ProductDao;
import dao.StyleDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ProductDao ps = new ProductDao();
        HttpSession session = request.getSession();
        session.setAttribute("fabricHotSelling", ps.getProductsByCategoryBySort(2, 1, 4, 4));
        List<Product> productsHotSelling = ps.getProductsByCategoryBySort(1, 1, 8, 4);

        StyleDao sd = new StyleDao();
        for (Product product : productsHotSelling) {
            product.setStyles(sd.getAllStylesByIDProduct(product.getId()));
        }

        session.setAttribute("productHotSelling", productsHotSelling);

        List<Product> productsMostDiscount =  ps.getProductsByCategoryBySort(1, 1, 4, 5);
        for(Product product : productsMostDiscount){
            product.setStyles(sd.getAllStylesByIDProduct(product.getId()));
        }

        session.setAttribute("productsMostDiscount", productsMostDiscount);
        session.setAttribute("mostProductNew", ps.getProductsByCategoryBySort(1, 1, 1, 1).getFirst());
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }
}