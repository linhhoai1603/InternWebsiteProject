package controllers;

import java.io.*;
import java.util.List;

import com.google.gson.Gson;
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
        boolean isAjax = "true".equals(request.getParameter("isAjax"));

        if (selection == null) selection = "all";
        if (option == null) option = "1";
        int currentPage = (param != null) ? Integer.parseInt(param) : 1;
        if (option.isEmpty()) option = "Mới nhất";

        ToTalProductService ps = new ToTalProductService();
        List<Product> products = ps.getProducts(selection, currentPage, nuPerPage, option, minPrice, maxPrice);
        int nupage = ps.getNuPage(nuPerPage, selection);

        // Nếu là AJAX request => Trả về JSON
        if (isAjax) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Gson gson = new Gson();
            String jsonResponse = gson.toJson(products);

            response.getWriter().write(jsonResponse);
        } else {
            // Nếu không phải AJAX => Load trang bình thường
            request.setAttribute("products", products);
            request.setAttribute("pageNumber", nupage);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("option", option);
            request.setAttribute("selection", selection);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);

            request.getRequestDispatcher("total-product.jsp").forward(request, response);
        }
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }

}