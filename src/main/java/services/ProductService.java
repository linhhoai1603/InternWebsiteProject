
package services;

import dao.DashboardDAO;
import dao.ProductDao;
import models.Order;
import models.Product;
import models.Style;

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
    public List<Product> getAll(){
        return productDao.getAllProducts();
    }

    public Product getDetail(String in) {
        StyleService ss = new StyleService();
        try {
            int id = Integer.parseInt(in);
            Product product = productDao.getProductById(id);
            product.setStyles(ss.getAllStylesByIDProduct(product.getId()));
            return product;
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
        StyleService ss = new StyleService();
        for(Product product : products){
            product.setStyles(ss.getAllStylesByIDProduct(product.getId()));
        }
        if (products.isEmpty()) {
            System.out.println("Không tìm thấy sản phẩm nào thuộc danh mục: " + category);
        }
        return products;
    }
    public int getNumberOfPage(List<Product> products,int psize) {
        int nuP = products.size();
        return (nuP % psize == 0) ? nuP / psize : nuP / psize + 1;
    }
    public List<Product> getProductsBySearch(int idCategory, int pageNumber, int pageSize, int options,String inputName){
        List<Product> products =  productDao.getProductsBySearch(idCategory, pageNumber, pageSize, options, inputName);
        StyleService styleService = new StyleService();
        for(Product product : products){
            product.setStyles(styleService.getAllStylesByIDProduct(product.getId()));
        }
        return products;
    }



    // Phương thức mới để lấy sản phẩm có bộ lọc giá duy nhất
//    public List<Product> getProductsByCategorySortButton(int idCategory, int pageNumber, int pageSize, int option, Double minPrice, Double maxPrice){
//        return productDao.getProductsByCategoryBySortButton(idCategory, pageNumber, pageSize, option, minPrice, maxPrice);
//    }


    //Dòng chỉnh sửa ở đây
//    public List<Product> getProductsByCategorySortButton(int idCategory, int pageNumber, int pageSize, int option, Double minPrice, Double maxPrice) {
//        List<Product> products = productDao.getProductsByCategoryBySortButton(idCategory, pageNumber, pageSize, option, minPrice, maxPrice);
//
//        // Gắn styles cho từng sản phẩm
//        StyleService styleService = new StyleService();
//        for (Product product : products) {
//            if (product.getStyles() == null) {
//                product.setStyles(new ArrayList<>());
//            }
//
//            List<Style> styles = styleService.getAllStylesByIDProduct(product.getId());
//            for (Style style : styles) {
//                if (!product.getStyles().contains(style)) {
//                    product.getStyles().add(style);
//                }
//            }
//        }
//
//        return products;
//    }

    public List<Product> getProductsByCategorySortButton(int idCategory, int pageNumber, int pageSize, int option, Double minPrice, Double maxPrice) {
        List<Product> products = productDao.getProductsByCategoryBySortButton(idCategory, pageNumber, pageSize, option, minPrice, maxPrice);

        // Gắn styles cho từng sản phẩm
        StyleService styleService = new StyleService();
        for (Product product : products) {
            if (product.getStyles() == null) {
                product.setStyles(new ArrayList<>());
            }

            List<Style> styles = styleService.getAllStylesByIDProduct(product.getId());
            for (Style style : styles) {
                if (!product.getStyles().contains(style)) {
                    product.getStyles().add(style);
                }
            }
        }

        return products;
    }

    // Phương thức mới để lấy số trang dựa trên bộ lọc giá
    public int getNumberOfPageButton(int idCategory, int pageSize, Double minPrice, Double maxPrice){
        return productDao.getNumberPageProductByCategoryButton(idCategory, pageSize, minPrice, maxPrice);
    }

    // Phương thức mới để lấy sản phẩm có bộ lọc giá duy nhất
//    public List<Product> getProductsByCategorySortZipStar(int idCategory, int pageNumber, int pageSize, int option, Double minPrice, Double maxPrice){
//        return productDao.getProductsByCategoryBySortButton(idCategory, pageNumber, pageSize, option, minPrice, maxPrice);
//    }

//    public List<Product> getProductsByCategorySortZipStar(int idCategory, int pageNumber, int pageSize, int option, Double minPrice, Double maxPrice) {
//        List<Product> products = productDao.getProductsByCategoryBySortButton(idCategory, pageNumber, pageSize, option, minPrice, maxPrice);
//        StyleService styleService = new StyleService();
//        for (Product product : products) {
//            List<Style> zipperStyles = styleService.getZipperStylesByIDProduct(product.getId());
//            product.setStyles(zipperStyles);
//        }
//        return products;
//    }

    public List<Product> getProductsByCategorySortZipStar(int idCategory, int pageNumber, int pageSize, int option, Double minPrice, Double maxPrice) {
        List<Product> products = productDao.getProductsByCategoryBySortButton(idCategory, pageNumber, pageSize, option, minPrice, maxPrice);

        // Thay vì chỉ lấy các Style liên quan đến zipper, hãy lấy tất cả các Style
        StyleService styleService = new StyleService();
        for (Product product : products) {
            List<Style> allStyles = styleService.getAllStylesByIDProduct(product.getId());
            product.setStyles(allStyles);
        }
        return products;
    }


    // Phương thức mới để lấy số trang dựa trên bộ lọc giá
//    public int getNumberOfPageZipStar(int idCategory, int pageSize, Double minPrice, Double maxPrice){
//        return productDao.getNumberPageProductByCategoryZipStar(idCategory, pageSize, minPrice, maxPrice);
//    }

    public int getNumberOfPageZipStar(int idCategory, int pageSize, Double minPrice, Double maxPrice){
        return productDao.getNumberPageProductByCategoryZipStar(idCategory, pageSize, minPrice, maxPrice);
    }


    public int addProduct(Product product) {
      return  productDao.addProduct(product);
    }
    public List<Product> getProductsByID(int idCategory, int pageNumber, int pageSize, int option, int id){
       List<Product> products = productDao.getProductsById(idCategory, pageNumber, pageSize, option, id);
        StyleService styleService = new StyleService();
        for(Product product : products){
            product.setStyles(styleService.getAllStylesByIDProduct(product.getId()));
        }
        return products;
    }
    public void stopSelling(int id){
        productDao.stopBuyProduct(id);
    }
    public void startSelling(int id){
        productDao.startBuyProduct(id);
    }
    public List<Product> getAllProducts(int idCategory, int pageNumber, int pageSize, int option){
        List<Product> products = productDao.getAllProductForAdmin(idCategory, pageNumber, pageSize, option);
        return  products;
    }

    public void updateProduct(Product product) {
        productDao.updateProduct(product);
    }
    public int getIdProductByIdStyle(int idStyle) {
        return productDao.getProductByIdStyle(idStyle);
    }

    public double getPriceByIdProduct(int idProduct) {
        return productDao.getPriceByIdProduct(idProduct);
    }
}
