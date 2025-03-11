package services;

import dao.ProductDAO2;
import models.Product;

import java.util.List;


public class ProductService2 {
    private ProductDAO2 productDao;
    public List<Product> getAllProducts(int nuPage, int nuPerPage, String option) {
        return productDao.getAllProducts(nuPage,nuPerPage, option);
    }
    public List<Product> getProductByCategoryName(String nameCategory, int nuPage, int nuPerPage, String option) {
        return productDao.getProductByCategoryName(nameCategory, nuPage, nuPerPage, option);
    }

    public int getNuPage(int nuPerPage) {
        int nu = productDao.countProducts();
        int nuPage = nu % nuPerPage > 0
                ? nu / nuPerPage
                : nu / nuPerPage + 1 ;

        return nuPage;
    }
    public int getNuPerPage(int nuPerPage , String category) {
        int nu = productDao.countProductsByCategoryName(category);
        int nuPage = nu % nuPerPage > 0
                ? nu / nuPerPage
                : nu / nuPerPage + 1 ;

        return nuPage;
    }
}
