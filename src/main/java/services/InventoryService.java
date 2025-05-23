package services;

import constant.HashCode;
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


    public int createInventoryIn(String note, String totalAmount, String supplier, String status) {
        String delimiter = HashCode.DISCRIMINATION;
        String description = note + delimiter + totalAmount + delimiter + supplier;

        return inventoryDao.createInventory(description,status );
    }
}
