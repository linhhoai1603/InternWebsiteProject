package services;

import dao.DeliveryDAO;
import models.Delivery;

public class DeliveryService {
    DeliveryDAO dao;
    public DeliveryService() {
        dao = new DeliveryDAO();
    }
    public boolean insertDelivery(Delivery delivery) {
        return dao.insertDelivery(delivery);
    }
}
