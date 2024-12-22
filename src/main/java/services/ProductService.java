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
    public List<Product> getProductByCategory(String category,int psize,int nupa) {
        List<Product> products = productDao.getProductByCategory(category,psize,nupa);
        if (products.isEmpty()) {
            System.out.println("Không tìm thấy sản phẩm nào thuộc danh mục: " + category);
        }
        return products;
    }
    public int getNumberOfPage(List<Product> products,int psize) {
        int nuP = products.size();
        return (nuP % psize == 0) ? nuP / psize : nuP / psize + 1;
    }

    public static void main(String[] args) {
        ProductService productService = new ProductService();
        List<Product> products = productService.getProductByCategory("Vải may mặc",12,4);
        int nu =productService.getNumberOfPage(products,12);
        System.out.println(products);
        System.out.println(nu);
    }
}
