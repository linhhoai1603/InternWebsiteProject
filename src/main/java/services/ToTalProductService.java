package services;

import dao.ToTalProductDAO;
import models.Product;

import java.util.List;


public class ToTalProductService {
    private ToTalProductDAO productDao;
    public ToTalProductService() {
        this.productDao = new ToTalProductDAO();
    }
    public List<Product> getAllProducts(int currentPage, int nuPerPage, String option) {
        return productDao.getAllProducts(currentPage,nuPerPage, option);
    }
    public List<Product> getProductByCategoryName(String selection, int currentPage, int nuPerPage, String option) {
        return productDao.getProductByCategoryName(selection, currentPage, nuPerPage, option);
    }

    public int getNuPage(int nuPerPage, String selection) {
        int nu;
        // Đảm bảo selection không null
        if (selection == null || selection.equals("all")) {
            nu = productDao.countProducts();
        } else {
            nu = productDao.countProductsByCategoryName(selection);
        }

        int nuPage = (nu / nuPerPage) + (nu % nuPerPage > 0 ? 1 : 0);
        return nuPage;
    }

    public List<Product> getProducts(String selection, int currentPage, int nuPerPage, String option, String minPrice, String maxPrice) {
        // Đảm bảo selection không null
        if (selection == null) {
            selection = "all";
        }

        // Check price range selection
        if (minPrice != null && maxPrice != null) {
            if (selection.equals("all")) {
                return productDao.getAllProductByPriceRange(currentPage, nuPerPage, option, minPrice, maxPrice);
            } else {
                return productDao.getProductByPriceRange(selection, currentPage, nuPerPage, option, minPrice, maxPrice);
            }
        }

        // Check type category has been selected
        if (selection.equals("all")) {
            return getAllProducts(currentPage, nuPerPage, option); // Sửa lại tham số đầu tiên
        } else {
            return getProductByCategoryName(selection, currentPage, nuPerPage, option);
        }
    }
    public static void main(String[] args) {
        ToTalProductService service = new ToTalProductService();
        //System.out.println(service.getNuPage(1, "all"));
        System.out.println(service.getProducts("Vải may mặc",1,12,"mới",null,null));

    }
}
