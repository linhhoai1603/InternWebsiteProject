package services;

import dao.CategoryDao;
import dao.ProductDao;
import models.Product;

import java.util.List;

public class ProductService {
    ProductDao productDao;
    public ProductService() {
        productDao = new ProductDao();
    }

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
    public List<Product> getProductByCategory(String category) {
        List<Product> products = productDao.getProductByCategory(category);
        if (products.isEmpty()) {
            System.out.println("Không tìm thấy sản phẩm nào thuộc danh mục: " + category);
        }
        return products;
    }

    public static void main(String[] args) {
        ProductService productService = new ProductService();
        System.out.println(productService.getProductByCategory("Vải may mặc"));
    }
}
