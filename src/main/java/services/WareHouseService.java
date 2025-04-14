package services;

import dao.WareHouseDao;
import models.WareHouse;

public class WareHouseService {
    WareHouseDao wareHouseDao;
    public WareHouseService() {
        wareHouseDao = new WareHouseDao();
    }
    public boolean createWareHouse() {
        return wareHouseDao.createWareHouse();
    }
}
