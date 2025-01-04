package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ProductService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "MayMacervlet",value = "/may-mac")
public class MayMacServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int loca = request.getParameter("loca") == null ? 1 : Integer.parseInt(request.getParameter("loca"));
        int psize =12;
        ProductService ps = new ProductService();
        List<Product> list = ps.getProductByCategory("Vải may mặc");
        int nuPage = ps.getNumberOfPage(list,psize);
        List<Product> products = ps.getProductByCategory("Vải may mặc",psize,loca);


        request.setAttribute("loca",loca);
        request.setAttribute("garment", products);
        request.setAttribute("nuPage", nuPage);

        request.getRequestDispatcher("garment-product.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}