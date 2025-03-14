package services;

import dao.ToTalProductDAO;
import models.Product;

import java.util.List;


public class ToTalProductService {
    private ToTalProductDAO productDao;
    public List<Product> getAllProducts(int currentPage, int nuPerPage, String option) {
        return productDao.getAllProducts(currentPage,nuPerPage, option);
    }
    public List<Product> getProductByCategoryName(String selection, int currentPage, int nuPerPage, String option) {
        return productDao.getProductByCategoryName(selection, currentPage, nuPerPage, option);
    }

    public int getNuPage(int nuPerPage , String selection) {
        int nu ;
        if(selection.equals("all"))
            nu = productDao.countProducts();
        else
            nu = productDao.countProductsByCategoryName(selection);
        int nuPage = nu % nuPerPage > 0
                ? nu / nuPerPage
                : nu / nuPerPage + 1 ;

        return nuPage;
    }

    public List<Product> getProducts(String selection, int currentPage, int nuPerPage, String option ,String minPrice,String maxPrice) {
        // Check price range selection
        if(minPrice != null && maxPrice != null){
            if(selection.equals("all"))
                return productDao.getAllProductByPriceRange(currentPage, nuPerPage, option , minPrice,maxPrice);
            else
                return productDao.getProductByPriceRange(selection, currentPage, nuPerPage, option , minPrice,maxPrice);
        }
        // check type category has been selected
        if(selection.equals("all") || selection == null)
            return getAllProducts(nuPerPage,nuPerPage,option);
        else
            return getProductByCategoryName(selection, currentPage, nuPerPage, option);
    }
}
