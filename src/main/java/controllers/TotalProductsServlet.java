package controllers;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
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
        if (option == null) option = "1";
        int currentPage = (param != null) ? Integer.parseInt(param) : 1;
        if(option.isEmpty() || option == null) option = "Mới nhất";

        ToTalProductService ps = new ToTalProductService();

        List<Product>products = ps.getProducts(selection,currentPage,nuPerPage,option, minPrice, maxPrice);
        int nupage = ps.getNuPage(nuPerPage,selection);

        request.setAttribute("products", products);
        request.setAttribute("pageNumber", nupage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("option", option);
        request.setAttribute("selection", selection);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);

        request.getRequestDispatcher("total-product.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }

}