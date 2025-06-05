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
        switch (option) {
            case "latest":
                return productDao.getProductLatest(currentPage, nuPerPage);
            case "expensive":
                return productDao.getProductByPrice(currentPage, nuPerPage, "decreasing");
            case "cheap":
                return productDao.getProductByPrice(currentPage, nuPerPage, "ascending");
            case "bestselling":
                return productDao.getProductsBestSellerByCategory("all", currentPage, nuPerPage);
            case "discount":
                return productDao.getProductBiggestDiscount(currentPage, nuPerPage);
            default:
                return productDao.getAllProducts(currentPage, nuPerPage);
        }
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
        // Handle null selection
        if (selection == null) {
            selection = "all";
        }

        // Map numeric categories to names
        selection = switch (selection) {
            case "1" -> "Vải may mặc";
            case "2" -> "Vải nội thất";
            case "3" -> "Nút áo";
            case "4" -> "Dây kéo";
            default -> selection;
        };

        // Check if price parameters are valid
        boolean hasValidPriceRange = minPrice != null && maxPrice != null && 
                                   !minPrice.trim().isEmpty() && !maxPrice.trim().isEmpty();
        
        if (hasValidPriceRange) {
            try {
                // Validate that the values can be parsed as doubles
                Double.parseDouble(minPrice);
                Double.parseDouble(maxPrice);
                if (selection.equals("all")) {
                    return productDao.getAllProductByPriceRange(currentPage, nuPerPage, minPrice, maxPrice);
                } else {
                    return productDao.getProductByCategoryAndPriceRange(selection, currentPage, nuPerPage, minPrice, maxPrice);
                }
            } catch (NumberFormatException e) {
                // If price parsing fails, fall back to normal category search
                if (selection.equals("all")) {
                    return getAllProducts(currentPage, nuPerPage, option);
                } else {
                    return getProductByCategoryName(selection, currentPage, nuPerPage, option);
                }
            }
        } else {
            // No price range, use normal category search
            if (selection.equals("all")) {
                return getAllProducts(currentPage, nuPerPage, option);
            } else {
                return getProductByCategoryName(selection, currentPage, nuPerPage, option);
            }
        }
    }

    public List<Product> searchProductByName(String name) {
        return productDao.searchProductByName(name);
    }

    public Product getProductByName(String name) {
        return productDao.getProductByName(name);
    }

    public Product getProductById(int id) {
        Product product = productDao.getProductById(id);
        StyleService styleService = new StyleService();
        product.setStyles(styleService.getAllStylesByIDProduct(id));
        return product;
    }

    public List<Product> getProductsBestSellerByCategory(String selection, int currentPage, int nuperPage) {
        return productDao.getProductsBestSellerByCategory(selection, currentPage, nuperPage);
    }
    public boolean addProduct(int id, int quantity) {
        Product product = productDao.getProductById(id);
        return productDao.addProduct(product ,quantity);
    }
    public boolean updateQuantityProduct(int id, int quantity) {
        Product product = productDao.getProductById(id);
        return productDao.updateQuantityProduct(product ,quantity);
    }
}
