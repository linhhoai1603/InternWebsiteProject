package services;

import dao.ProductDao;
import models.Product;

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
        return  productDao.getProductsByCategoryBySort(idCategory, pageNumber, pageSize, option);
    }
}
