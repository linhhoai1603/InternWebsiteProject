package services;

import dao.InventoryDao;

public class InventoryService {
    InventoryDao wareHouseDao;
    public InventoryService() {
        wareHouseDao = new InventoryDao();
    }
    public boolean createWareHouse() {
        return wareHouseDao.createWareHouse();
    }
}
