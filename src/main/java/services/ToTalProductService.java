package services;

import dao.ToTalProductDAO;
import models.Product;
import models.Style;

import java.util.List;
import java.util.ArrayList;

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
                return productDao.getProductBestSelling(currentPage, nuPerPage);
            case "discount":
                return productDao.getProductBiggestDiscount(currentPage, nuPerPage);
            default:
                return productDao.getAllProducts(currentPage, nuPerPage);
        }

    }
    public List<Product> getProductByCategoryName(String selection, int currentPage, int nuPerPage, String option) {
        if(option != null && !option.isEmpty()){
            return productDao.getProductByCategoryNameWithOption(selection,currentPage,nuPerPage, option);
        }
        return productDao.getProductByCategoryName(selection, currentPage, nuPerPage);
    }

    public int getNuPage(int nuPerPage, String selection) {
        int nu;
        if (selection == null || selection.equals("all")) {
            nu = productDao.countProducts();
        } else {
            nu = productDao.countProductsByCategoryName(selection);
        }

        int nuPage = (nu / nuPerPage) + (nu % nuPerPage > 0 ? 1 : 0);
        return nuPage;
    }

    public List<Product> getProducts(String selection, int currentPage, int nuPerPage, String option, String minPrice, String maxPrice) {
        List<Product> products;

        String finalSelection;
        if (selection == null || selection.equalsIgnoreCase("all") || selection.trim().isEmpty()) {
            finalSelection = "all";
        } else {
            finalSelection = switch (selection) {
                case "1" -> "Vải may mặc";
                case "2" -> "Vải nội thất";
                case "3" -> "Nút áo";
                case "4" -> "Dây kéo";
                default -> selection;
            };
        }

        boolean usePriceFilter = false;
        if (minPrice != null && !minPrice.trim().isEmpty() &&
                maxPrice != null && !maxPrice.trim().isEmpty()) {
            try {
                Double.parseDouble(minPrice);
                Double.parseDouble(maxPrice);
                usePriceFilter = true;
            } catch (NumberFormatException e) {
                usePriceFilter = false;
            }
        }

        if (usePriceFilter) {
            products = productDao.getProductByCategoryAndPriceRange(finalSelection, currentPage, nuPerPage, minPrice, maxPrice);
        } else {
            if ("all".equals(finalSelection)) {
                products = getAllProducts(currentPage, nuPerPage, option);
            } else {
                products = getProductByCategoryName(finalSelection, currentPage, nuPerPage, option);
            }
        }

        StyleService styleService = new StyleService();
        if (products != null) {
            for (Product product : products) {
                if (product != null) {
                    List<Style> styles = styleService.getAllStylesByIDProduct(product.getId());
                    product.setStyles(styles);
                }
            }
        } else {
            products = new ArrayList<>();
        }

        return products;
    }
    public static void main(String[] args) {
        ToTalProductService service = new ToTalProductService();
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

    public List<Product> getProductsByCategories(String[] categoryIds, int currentPage, int nuPerPage, String option, String minPrice, String maxPrice) {
        return ToTalProductDAO.getProductByCategories(categoryIds, currentPage, nuPerPage, option, minPrice, maxPrice);
    }
}