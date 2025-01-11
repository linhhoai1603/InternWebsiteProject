package controllers;

import java.io.*;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Category;
import models.Price;
import models.Product;
import models.TechnicalInfo;
import services.PriceService;
import services.ProductService;
import services.StyleService;
import services.TechnicalService;

@WebServlet(name = "AdminManagerProduct", value = "/admin/admin-manager-products")
public class AdminManagerProduct extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String method = request.getParameter("method");
        if("getAllProducts".equals(method)) {
            getAllProducts(request, response);
        }
        if("addProduct".equals(method)) {
            addProduct(request, response);
        }
        if("searchProduct".equals(method)) {
            searchProduct(request, response);
        }
    }

    private void searchProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputName = request.getParameter("inputName");
        List<Product> products = new ProductService().getProductsByID(0, 1, 20, 0, Integer.parseInt(inputName));
        request.setAttribute("products", products);
        request.setAttribute("pageNumber", new ProductService().getNumberOfPage(products, 20));
        request.setAttribute("currentPage", 1);
        request.setAttribute("option", 0);
        request.setAttribute("message", "Kết quả tìm kiếm cho: " + inputName+" có "+products.size()+" sản phẩm");
        request.getRequestDispatcher("management-products.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int category = Integer.parseInt(request.getParameter("category"));
        double area = Double.parseDouble(request.getParameter("area"));
        String description = request.getParameter("description");
        String sellingStr = request.getParameter("selling");
        int selling = 0;
        if("active".equals(sellingStr)) {
            selling = 1;
        }
        String image = request.getParameter("image");
        String specification = request.getParameter("specification");
        LocalDate manufactureDate = LocalDate.parse(request.getParameter("manufactureDate"));
        double price = Double.parseDouble(request.getParameter("price"));
        double discountPercent = Double.parseDouble(request.getParameter("discountPercent"));
        // create object
        ProductService ps = new ProductService();
        TechnicalService ts = new TechnicalService();
        PriceService priceService = new PriceService();
        // category
        Category categoryObj = new Category();
        categoryObj.setId(category);
        // add technical and return id
        TechnicalInfo technicalInfo = new TechnicalInfo();
        technicalInfo.setSpecification(specification);
        technicalInfo.setManufactureDate(manufactureDate);
        // add price and return id
        Price priceObj = new Price();
        priceObj.setPrice(price);
        priceObj.setDiscountPercent(discountPercent);
        // add product
        Product product = new Product();
        product.setName(name);
        product.setQuantity(quantity);
        product.setArea(area);
        product.setDescription(description);
        product.setSelling(selling);
        product.setImage(image);
        product.setCategory(categoryObj);
        product.setTechnicalInfo(technicalInfo);
        product.setPrice(priceObj);
        product.setDateAdded(LocalDate.now());
        int idProduct = ps.addProduct(product);
        request.setAttribute("message", "Thêm sản phẩm thành công với id: " + idProduct);
        request.setAttribute("products", ps.getProductsByCategorySort(0, 1, 20, 0));
        request.getRequestDispatcher("management-products.jsp").forward(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        getAllProducts(request, response);
    }

    private void getAllProducts(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int option = request.getParameter("option") == null ? 0 : Integer.parseInt(request.getParameter("option"));
        option = (option < 0 || option > 5) ? 0 : option;

        ProductService ps = new ProductService();

        int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

        List<Product> products = ps.getProductsByCategorySort(0, currentPage, 20, option);

        request.setAttribute("products", products);
        request.setAttribute("pageNumber", ps.getNumberOfPage(0, 20));
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("option", option);

        request.getRequestDispatcher("management-products.jsp").forward(request, response);
    }


}