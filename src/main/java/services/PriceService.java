package services;

import dao.PriceDAO;
import models.Price;

public class PriceService {
    private PriceDAO priceDAO;
    public PriceService() {
        priceDAO = new PriceDAO();
    }

    public int addPrice(Price priceObj) {
        return priceDAO.addPrice(priceObj);
    }
}
