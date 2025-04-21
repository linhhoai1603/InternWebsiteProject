package services;

import dao.InventoryStyleDetailDao;
import models.InventoryStyleDetail;

public class InventoryStyleDetailService {
    InventoryStyleDetailDao inventoryStyleDetailDao;
    public InventoryStyleDetailService() {
        inventoryStyleDetailDao = new InventoryStyleDetailDao();
    }
    public boolean createInventoryStyleDetail(int idInventoryDetail, int idStyle , int stockQuantity, int actualQuantity) {
        int discrepancy = stockQuantity - actualQuantity;
        return inventoryStyleDetailDao.create( idInventoryDetail,  idStyle ,  stockQuantity,  actualQuantity);
    }
}
