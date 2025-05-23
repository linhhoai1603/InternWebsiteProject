package services;

import dao.ToTalProductDAO;
import models.Product;
import models.Style;

import java.util.List;


public class ToTalProductService {
    private ToTalProductDAO productDao;
    public ToTalProductService() {
        this.productDao = new ToTalProductDAO();

    }
    public List<Product> getProductsByIds(List<Integer> ids) {
        List<Product> products = productDao.getProductsByIds(ids);
        StyleService styleService = new StyleService();
        for (Product product : products) {
            List<Style> styles = styleService.getAllStylesByIDProduct(product.getId());
            product.setStyles(styles);
        }
        return products;
    }

    public List<Product> getAllProducts(int currentPage, int nuPerPage, String option) {
        return switch (option) {
            case "latest" -> productDao.getProductLatest(currentPage, nuPerPage);
            case "expensive" -> productDao.getProductByPrice(currentPage, nuPerPage, "decreasing");
            case "cheap" -> productDao.getProductByPrice(currentPage, nuPerPage, "ascending");
            case "discount" -> productDao.getProductBiggestDiscount(currentPage, nuPerPage);
            default -> productDao.getAllProducts(currentPage, nuPerPage);
        };
    }
    public List<Product> getProductByCategoryName(String selection, int currentPage, int nuPerPage, String option) {
        if(option.equals("")||option==null){
            return productDao.getProductByCategoryNameWithOption(selection,currentPage,nuPerPage, option);
        }
        return productDao.getProductByCategoryName(selection, currentPage, nuPerPage);
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

        if (selection == null) {
            selection = "all";
        }
        selection = switch (selection) {
            case "1" -> "Vải may mặc";
            case "2" -> "Vải nội thất";
            case "3" -> "Nút áo";
            case "4" -> "Dây kéo";
            default -> selection;
        };
        if (minPrice != null && maxPrice != null) {
            if (selection.equals("all")) {
                return productDao.getAllProductByPriceRange(currentPage, nuPerPage, minPrice, maxPrice);
            } else {
                return productDao.getProductByCategoryAndPriceRange(selection, currentPage, nuPerPage, minPrice, maxPrice);
            }
        }


        if (selection.equals("all")) {
            return getAllProducts(currentPage, nuPerPage, option);
        } else {
            return getProductByCategoryName(selection, currentPage, nuPerPage, option);
        }
    }
    public static void main(String[] args) {
        ToTalProductService service = new ToTalProductService();
        //System.out.println(service.getNuPage(1, "all"));
        System.out.println(service.getProducts("Vải may mặc",1,12,"latest",null,null));

    }
    public List<Product> searchProductByName(String name) {
        return productDao.searchProductByName(name);
    }
    public Product getProductByName(String name) {
        return productDao.getProductByName(name);
    }
    public Product getProductById(int id) {
        return productDao.getProductById(id);
    }

    public List<Product> getProductsBestSellerByCategory(String selection, int currentPage , int nuperPage) {
        return productDao.getProductsBestSellerByCategory( selection,  currentPage ,  nuperPage);
    }
}
