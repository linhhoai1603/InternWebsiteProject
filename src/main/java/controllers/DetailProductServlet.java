package controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ProductService;

import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;

@WebServlet(value = "/detail-product")
public class DetailProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");
        String ajax = request.getParameter("ajax");

        ProductService ps = new ProductService();
        Product product = null;

        try {
            int productId = Integer.parseInt(productIdParam);
            product = ps.getDetail(String.valueOf(productId));
        } catch (NumberFormatException e) {
            // Log or handle invalid product ID format
            System.err.println("Invalid product ID format: " + productIdParam);
            if ("true".equals(ajax)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
                PrintWriter out = response.getWriter();
                out.print("{ \"error\": \"Invalid product ID format\" }");
                out.flush();
                return;
            } else {
                 response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
                 return;
            }
        }

        if ("true".equals(ajax)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            Gson gson = new Gson();

            if (product == null) {
                // Product not found
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 Not Found
                out.print("{ \"error\": \"Product not found\" }");
            } else {
                // Product found, return JSON
                out.print(gson.toJson(product));
            }
            out.flush();

        } else {
            // Handle normal request: forward to JSP
            if (product == null) {
                 // Product not found for normal request
                 response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            } else {
                request.setAttribute("product", product);
                request.getRequestDispatcher("detail-product.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}