package services;

import dao.ProductDao;
import models.Product;

import java.util.List;

public class ProductService {
    static ProductDao productDao= new ProductDao();

    public List<Product> getAll(){
        return productDao.getAllProducts();
    }

    public Product getDetail(String in) {
        try {
            int id = Integer.parseInt(in);
            return productDao.getProductById(id);

        }catch (NumberFormatException e){
            return null;
        }
    }
}
