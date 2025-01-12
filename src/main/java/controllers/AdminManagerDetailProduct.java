package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Product;
import models.Style;
import services.ProductService;
import services.StyleService;

@WebServlet(name = "AdminManagerDetailProduct", value = "/admin/admin-manager-detail-product")
public class AdminManagerDetailProduct extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String method = request.getParameter("method");
        if ("updateStyle".equals(method)) {
            updateStyle(request, response);
        }
        if("deleteStyle".equals(method)){
            deleteStyle(request,response);
        }
        if("addStyle".equals(method)){
            addStyle(request,response);
        }
    }

    private void addStyle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("fabricName");
            String quantityStr = request.getParameter("fabricQuantity");
            String image = request.getParameter("fabricImage");
            String idProductStr = request.getParameter("idProduct");

            if (name == null || quantityStr == null || image == null || idProductStr == null) {
                throw new IllegalArgumentException("Missing required parameters");
            }

            int quantity = Integer.parseInt(quantityStr);
            int idProduct = Integer.parseInt(idProductStr);

            // Logic thêm style
            StyleService ss = new StyleService();
            Style style = new Style();
            style.setName(name);
            style.setQuantity(quantity);
            style.setImage(image);

            Product productForStyle = new Product();
            productForStyle.setId(idProduct);
            style.setProduct(productForStyle);

            ss.addStyle(style);

            ProductService ps = new ProductService();
            // Set thuộc tính và chuyển tiếp
            request.setAttribute("product", ps.getProductsByID(0, 1, 1, 0, idProduct).get(0));
            request.getRequestDispatcher("management-detail-products.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format for quantity or product ID");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }

    }

    private void deleteStyle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int styleId = Integer.parseInt(request.getParameter("styleId"));
        int id = Integer.parseInt(request.getParameter("id"));
        StyleService ss = new StyleService();
        ProductService ps = new ProductService();
        ss.deleteStyle(styleId);
        request.setAttribute("product", ps.getProductsByID(0, 1, 1, 0, id).get(0));
        request.getRequestDispatcher("management-detail-products.jsp").forward(request,response);
    }

    private void updateStyle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int styleId = Integer.parseInt(request.getParameter("styleId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String name = request.getParameter("nameStyle");
        StyleService ss = new StyleService();
        Style newStyle = new Style();
        newStyle.setId(styleId);
        newStyle.setQuantity(quantity);
        newStyle.setName(name);
        ss.updateStyle(newStyle);
        int idProduct = Integer.parseInt(request.getParameter("id"));
        ProductService ps = new ProductService();
        request.setAttribute("product", ps.getProductsByID(0, 1, 1, 0, idProduct).get(0));
        request.getRequestDispatcher("management-detail-products.jsp").forward(request,response);
    }
}