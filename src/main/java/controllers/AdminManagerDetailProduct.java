package controllers;

import java.io.*;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Price;
import models.Product;
import models.Style;
import models.TechnicalInfo;
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
        if("updateProduct".equals(method)){
            updateProduct(request,response);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // xu ly thong tin cho technical
        TechnicalInfo technicalInfo = new TechnicalInfo();
        int idTechnical = Integer.parseInt(request.getParameter("idTechnical"));
        String specification = request.getParameter("technical_specifications");
        LocalDate manufactureDate = LocalDate.parse(request.getParameter("manufacture_date"));
        technicalInfo.setId(idTechnical);
        technicalInfo.setSpecification(specification);
        technicalInfo.setManufactureDate(manufactureDate);

        // xu ly thong tin cho price
        int idPrice = Integer.parseInt(request.getParameter("idPrice"));
        double price = Double.parseDouble(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discountPercent"));
        Price priceObj = new Price();
        priceObj.setId(idPrice);
        priceObj.setPrice(price);
        priceObj.setDiscountPercent(discount);

        // xy ly thong tin cho product
        int idProduct = Integer.parseInt(request.getParameter("idProduct"));
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String description = request.getParameter("description");
        Product product = new Product();
        product.setId(idProduct);
        product.setName(name);
        product.setQuantity(quantity);
        product.setDescription(description);
        product.setTechnicalInfo(technicalInfo);
        product.setPrice(priceObj);

        ProductService ps = new ProductService();
        ps.updateProduct(product);

        request.setAttribute("product", ps.getProductsByID(0, 1, 1, 0, idProduct).get(0));
        request.getRequestDispatcher("management-detail-products.jsp").forward(request, response);
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