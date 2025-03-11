package services;

import dao.ProductDAO2;
import models.Product;

import java.util.List;


public class ProductService2 {
    private ProductDAO2 productDao;
    public List<Product> getAllProducts(int nuPage, int nuPerPage) {
        return productDao.getAllProducts(nuPage,nuPerPage);
    }


}
