
package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ProductService;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "ZipperServlet", value = "/product-zippers")
public class ZipperServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ZipperServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Xử lý tham số 'option'
        int option = 0;
        try {
            option = request.getParameter("option") == null ? 0 : Integer.parseInt(request.getParameter("option"));
            if (option < 0 || option > 5) {
                option = 0;
            }
        } catch (NumberFormatException e) {
            logger.warning("Invalid 'option' parameter: " + request.getParameter("option"));
            option = 0;
        }

        // Xử lý tham số 'page'
        int currentPage = 1;
        try {
            currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
            if (currentPage < 1) {
                currentPage = 1;
            }
        } catch (NumberFormatException e) {
            logger.warning("Invalid 'page' parameter: " + request.getParameter("page"));
            currentPage = 1;
        }

        // Xử lý các tham số 'minPrice' và 'maxPrice' từ request
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");

        Double minPrice = null;
        Double maxPrice = null;

        try {
            if (minPriceParam != null && !minPriceParam.isEmpty()) {
                minPrice = Double.parseDouble(minPriceParam);
                if (minPrice < 0) {
                    minPrice = 0.0; // Đảm bảo minPrice không âm
                }
            }
            if (maxPriceParam != null && !maxPriceParam.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceParam);
                if (maxPrice < 0) {
                    maxPrice = null; // Nếu maxPrice âm, bỏ qua
                }
            }
        } catch (NumberFormatException e) {
            logger.warning("Invalid price parameters: minPrice=" + minPriceParam + ", maxPrice=" + maxPriceParam);
            minPrice = null;
            maxPrice = null;
        }

        logger.info("Parameters - option: " + option + ", page: " + currentPage + ", minPrice: " + minPrice + ", maxPrice: " + maxPrice);

        ProductService ps = new ProductService();

        int idCategory = 4; // Giả sử idCategory=4 dành cho Dây Kéo, bạn cần xác nhận lại giá trị này
        int pageSize = 9;

        List<Product> products;
        int pageNumber;

        // Kiểm tra xem có bộ lọc giá không
        if (minPrice != null || maxPrice != null) {
            // Có bộ lọc giá
            products = ps.getProductsByCategorySortZipStar(idCategory, currentPage, pageSize, option, minPrice, maxPrice);
            // Đặt số trang dựa trên bộ lọc giá
            pageNumber = ps.getNumberOfPageZipStar(idCategory, pageSize, minPrice, maxPrice);
        } else {
            // Không có bộ lọc giá
            products = ps.getProductsByCategorySort(idCategory, currentPage, pageSize, option);
            // Đặt số trang không dựa trên bộ lọc giá
            pageNumber = ps.getNumberOfPage(idCategory, pageSize);
        }

        logger.info("Products retrieved: " + products.size() + ", Total pages: " + pageNumber);

        // Đặt các thuộc tính để chuyển tới JSP
        request.setAttribute("zippers", products);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("option", option);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);

        // Chuyển tiếp tới trang JSP
        request.getRequestDispatcher("zipstar-product.jsp").forward(request, response);
    }
}
