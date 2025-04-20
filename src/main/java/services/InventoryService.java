package services;

import dao.InventoryDao;
import models.Inventory;

public class InventoryService {
    InventoryDao inventoryDao;
    public InventoryService() {
        inventoryDao = new InventoryDao();
    }
    public int createInventory(String description,String status ) {
        return inventoryDao.createInventory(description,status );
    }


}
