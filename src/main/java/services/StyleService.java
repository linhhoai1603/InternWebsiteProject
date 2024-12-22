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

}
