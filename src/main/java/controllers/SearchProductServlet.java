package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ToTalProductService;

import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String input = request.getParameter("input");

        ToTalProductService ps = new ToTalProductService();
        List<Product> products = ps.searchProductByName(input);
        request.setAttribute("products", products);
        
        request.getRequestDispatcher("total-product.jsp").forward(request, response);
    }


}