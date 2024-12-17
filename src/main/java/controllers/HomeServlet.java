package controllers;

import java.io.*;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ProductDao ps = new ProductDao();
        HttpSession session = request.getSession();
        session.setAttribute("fabricHotSelling", ps.getProductsByCategoryBySort(2, 1, 4, 4));
        session.setAttribute("productHotSelling", ps.getProductsByCategoryBySort(1, 1, 8, 4));
        session.setAttribute("productMostDiscount", ps.getProductsByCategoryBySort(1, 1, 4, 5));
        session.setAttribute("mostProductNew", ps.getProductsByCategoryBySort(1, 1, 1, 1).getFirst());
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }
}