package services;

import dao.ProductDao;
import models.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductService {
    private ProductDao productDao;
    public ProductService() {
        productDao = new ProductDao();
    }
    public int getNumberOfPage(int idCategory, int pageSize){
        return productDao.getNumberPageProductByCategory(idCategory, pageSize);
    }
    public List<Product> getProductsByCategorySort(int idCategory, int pageNumber, int pageSize, int option){
       List<Product> products = productDao.getProductsByCategoryBySort(idCategory, pageNumber, pageSize, option);
       StyleService ss = new StyleService();
       for(Product product : products){
           product.setStyles(ss.getAllStylesByIDProduct(product.getId()));
       }
        return  products;
    }
}
