
package services;

import dao.StyleDao;
import models.Product;
import models.Style;
import org.jdbi.v3.core.Handle;

import java.util.List;

import static connection.DBConnection.jdbi;

public class StyleService {
    private StyleDao styleDao;

    public StyleService() {
        styleDao = new StyleDao();
    }

    public List<Style> getAllStylesByIDProduct(int idProduct) {
        return styleDao.getAllStylesByIDProduct(idProduct);
    }

    public Style getStyleByID(int idStyle) {
        return styleDao.getStyleByID(idStyle);
    }


    //Thêm phương thức mới trong StyleService để sử dụng phương thức vừa tạo:
    public List<Style> getZipperStylesByIDProduct(int idProduct) {
        return styleDao.getZipperStylesByIDProduct(idProduct);
    }

    public void updateQuantityForStyle(int idStyle, int quantity) {
        styleDao.updateQuantityForStyle(idStyle, quantity);
    }

    public void updateQuantityForProduct(int idProduct, int quantity) {
        styleDao.updateQuantityForProduct(idProduct, quantity);
    }

    public void deleteStyle(int styleId) {
        styleDao.deleteStyle(styleId);
    }

    public void updateStyle(Style newStyle) {
        styleDao.updateStyle(newStyle);
    }

    public void addStyle(Style style) {
        styleDao.addStyle(style);
    }

    public boolean decreaseStyleAndProductQuantity(int styleId, int productId, int quantityToDecrease) {
        if (quantityToDecrease <= 0) {
            System.out.println("Số lượng cần giảm không hợp lệ: " + quantityToDecrease);
            return true;
        }

        return jdbi.inTransaction((Handle handle) -> {
            StyleDao styleDAO = new StyleDao();

            // 1. Kiểm tra số lượng tồn kho của Style
            Style style = styleDAO.getStyleByID(styleId);
            System.out.println("style quantiy: " + style.getQuantity());
            int currentStyleQuantity = style.getQuantity();
            if (currentStyleQuantity == -1) {
                throw new RuntimeException("Style với ID " + styleId + " không tồn tại.");
            }
            if (currentStyleQuantity < quantityToDecrease) {
                throw new IllegalStateException("Không đủ số lượng tồn kho cho Style ID " + styleId +
                        ". Yêu cầu: " + quantityToDecrease + ", Hiện có: " + currentStyleQuantity);
            }

            // 2. Kiểm tra số lượng tồn kho của Product
            int currentProductQuantity = styleDAO.getProductQuantity(productId);
            if (currentProductQuantity == -1) {
                throw new RuntimeException("Product với ID " + productId + " không tồn tại.");
            }
            if (currentProductQuantity < quantityToDecrease) {
                throw new IllegalStateException("Không đủ số lượng tồn kho cho Product ID " + productId +
                        ". Yêu cầu: " + quantityToDecrease + ", Hiện có: " + currentProductQuantity);
            }

            // 3. Thực hiện giảm số lượng Style
            int styleRowsAffected = styleDAO.decreaseStyleQuantity(styleId, quantityToDecrease);
            if (styleRowsAffected == 0) {
                throw new RuntimeException("Không thể giảm số lượng cho Style ID " + styleId +
                        ". Số lượng có thể đã thay đổi hoặc style không tồn tại.");
            }
            System.out.println("Đã giảm số lượng cho Style ID " + styleId + " đi " + quantityToDecrease);

            // 4. Thực hiện giảm số lượng Product
            int productRowsAffected = styleDAO.decreaseProductQuantity(productId, quantityToDecrease);
            if (productRowsAffected == 0) {
                throw new RuntimeException("Không thể giảm số lượng cho Product ID " + productId +
                        ". Số lượng có thể đã thay đổi hoặc product không tồn tại.");
            }
            System.out.println("Đã giảm số lượng cho Product ID " + productId + " đi " + quantityToDecrease);

            return true;
        });
    }
    public boolean addStyle(int id, int quantity) {
        Style style = styleDao.getStyleByID(id);
        return styleDao.addMoreStyle(style ,quantity);
    }
    public boolean updateQuantityStyle(int id, int quantity) {
        Style style = styleDao.getStyleByID(id);
        return styleDao.updateQuantityStyle(style ,quantity);
    }
}
