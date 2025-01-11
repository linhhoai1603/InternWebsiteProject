
package services;

import dao.StyleDao;
import models.Style;

import java.util.List;

public class StyleService {
    private StyleDao styleDao;
    public StyleService() {
        styleDao = new StyleDao();
    }
    public List<Style> getAllStylesByIDProduct(int idProduct){
        return styleDao.getAllStylesByIDProduct(idProduct);
    }
    public Style getStyleByID(int idStyle){
        return styleDao.getStyleByID(idStyle);
    }


    //Thêm phương thức mới trong StyleService để sử dụng phương thức vừa tạo:
    public List<Style> getZipperStylesByIDProduct(int idProduct) {
        return styleDao.getZipperStylesByIDProduct(idProduct);
    }
    public void updateQuantityForStyle(int idStyle, int quantity){
        styleDao.updateQuantityForStyle(idStyle, quantity);
    }
    public void updateQuantityForProduct(int idProduct, int quantity){
        styleDao.updateQuantityForProduct(idProduct, quantity);
    }

}
