package services;

import constant.HashCode;
import dao.InventoryDao;
import dao.InventoryDetailDao;
import dao.InventoryStyleDetailDao;
import models.Inventory;

public class InventoryService {
    InventoryDao inventoryDao;
    InventoryDetailDao inventoryDetailDao;
    InventoryStyleDetailDao inventoryStyleDetailDao;
    public InventoryService() {
        this.inventoryDao = new InventoryDao();
        this.inventoryDetailDao = new InventoryDetailDao();
        this.inventoryStyleDetailDao = new InventoryStyleDetailDao();
    }
    public int createInventory(int type,String description,String status ) {
        return inventoryDao.createInventory(type,description,status );
    }

    public int createinventoryInDetail(int idProduct,int idInventory ,int quantityImported) {
        return inventoryDetailDao.createInventoryInDetail(idProduct, idInventory,quantityImported);
    }
    public int createinventoryDetail(int idProduct,int idInventory ,
                                       int quantityBefore,int quantityLoss ) {
        return inventoryDetailDao.createInventoryDetail(idProduct, idInventory,quantityBefore,quantityLoss);
    }
    public boolean createinventoryInStyleDetail(int idInventoryDetail,int idStyle ,
                                       int quantityImported) {
        return inventoryStyleDetailDao.createInventoryInStyleDetail(idInventoryDetail, idStyle,quantityImported);
    }
    public boolean createinventoryStyleDetail(int idProduct,int idInventory ,
                                     int quantityBefore,int quantityLoss ) {
        return inventoryStyleDetailDao.createInventoryStyleDetail(idProduct, idInventory,quantityBefore,quantityLoss);
    }

    public static void main(String[] args) {
        InventoryService inventoryService = new InventoryService();
        System.out.println(inventoryService.createInventory(1,"hai","444"));
    }

}
