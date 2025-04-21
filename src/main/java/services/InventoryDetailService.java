package services;

import constant.HashCode;
import dao.InventoryDao;
import dao.InventoryDetailDao;
import models.InventoryDetail;

public class InventoryDetailService {
    InventoryDetailDao inventoryDetailDao;
    public InventoryDetailService() {
        inventoryDetailDao = new InventoryDetailDao();
    }
    public int createInventoryDetail(int idInventory,int idProduct ,int quantityBefore,int quantityTotal ) {
        int quantityLoss  = quantityBefore -quantityTotal ;
        return inventoryDetailDao.createInventory(idInventory,idProduct,quantityBefore,quantityTotal,quantityLoss);
    }

    public boolean updateQuantityActualAndLoss(int idinventoryDetail, int befor, int total) {
        return inventoryDetailDao.updateQuantityActualAndLoss(idinventoryDetail,befor,total);
    }

    public int createInventoryInDetail(int idinventory, int productId,  int totalImport) {

        return inventoryDetailDao.createInventoryIn(idinventory,productId,totalImport);
    }
}
