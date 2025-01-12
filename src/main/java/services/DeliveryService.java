package services;

import dao.DeliveryDAO;
import models.Delivery;

import java.util.List;

public class DeliveryService {
    DeliveryDAO dao;
    public DeliveryService() {
        dao = new DeliveryDAO();
    }
    public boolean insertDelivery(Delivery delivery) {
        return dao.insertDelivery(delivery);
    }
    public List<Delivery> getAllDeliveries() {
        AddressService addressService = new AddressService();
        List<Delivery> deliveries = dao.getAllDeliveries();
        for(Delivery delivery : deliveries){
            delivery.setAddress(addressService.getAddressByID(delivery.getIdAddress()));
        }
        return deliveries;
    }
    public List<Delivery> getDeliveryByIdOrder(int id) {
        AddressService addressService = new AddressService();
        List<Delivery> deliveries = dao.getDeliveriesByOrderId(id);
        for(Delivery delivery : deliveries){
            delivery.setAddress(addressService.getAddressByID(delivery.getIdAddress()));
        }
        return deliveries;
    }
}
