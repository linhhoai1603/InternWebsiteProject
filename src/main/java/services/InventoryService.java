package services;

import constant.HashCode;
import dao.InventoryDao;
import dao.InventoryDetailDao;
import dao.InventoryStyleDetailDao;
import models.Inventory;
import models.InventoryDetail;
import models.InventoryStyleDetail;

import java.util.List;

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
        return inventoryDetailDao.createInventoryInDetail(idInventory,idProduct,quantityImported);
    }
    public int createinventoryDetail(int idProduct,int idInventory ,
                                       int quantityBefore,int quantityLoss ) {
        return inventoryDetailDao.createInventoryDetail(idProduct, idInventory,quantityBefore,quantityLoss);
    }
    public boolean createinventoryInStyleDetail(int idInventoryDetail,int idStyle ,
                                       int quantityImported) {
        return inventoryStyleDetailDao.createInventoryInStyleDetail(idInventoryDetail, idStyle,quantityImported);
    }
    public boolean createinventoryStyleDetail(int idInventoryDetail, int idStyle, int stockQuantity, int actualQuantity) {
        return inventoryStyleDetailDao.createInventoryStyleDetail(idInventoryDetail, idStyle, stockQuantity, actualQuantity);
    }

    public List<Inventory> getInventoryByType(int i) {
        return inventoryDao.getInventoryByType(i);
    }

    public Inventory getInventoryById(int id) {
        return inventoryDao.getById(id);
    }

    public InventoryDetail getInventorDetailyById(int id) {
        return inventoryDetailDao.getById(id);
    }
    public InventoryStyleDetail getInventorStyleDetailyById(int id) {
        return inventoryStyleDetailDao.getById(id);
    }

    public List<InventoryDetail> getByIdInventory(int id) {
        return inventoryDetailDao.getByIdInventory( id);
    }

    public List<InventoryStyleDetail> getByIdInventoryDetail(int id) {
        return inventoryStyleDetailDao.getByIdInventoryDetail(id);
    }

    public boolean updateStatus(int id) {
        return inventoryDao.updateStatus( id);
    }

}
