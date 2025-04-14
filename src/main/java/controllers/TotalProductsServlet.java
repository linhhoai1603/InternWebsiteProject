package controllers;

import java.io.*;
import java.time.LocalDate;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import services.LocalDateAdapter;
import services.ToTalProductService;

@WebServlet(name = "TotalProductsServlet", value = "/total-product")
public class TotalProductsServlet extends HttpServlet {
    int nuPerPage = 12;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String option = request.getParameter("option");
        String selection = request.getParameter("selection");
        String param = request.getParameter("currentPage");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");

        if (selection == null) selection = "all";
        int currentPage = (param != null) ? Integer.parseInt(param) : 1;
        if (option == null ||option.isEmpty()) option = "latest";

        ToTalProductService ps = new ToTalProductService();
        List<Product> products = ps.getProducts(selection, currentPage, nuPerPage, option, minPrice, maxPrice);
        int nupage = ps.getNuPage(nuPerPage, selection);

        request.setAttribute("nupage", nupage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("products", products);
        request.getRequestDispatcher("total-product.jsp").forward(request, response);

    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }

}