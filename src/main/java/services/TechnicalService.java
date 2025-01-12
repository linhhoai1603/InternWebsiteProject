package services;

import dao.TechnicalDAO;
import models.TechnicalInfo;

public class TechnicalService {
    private TechnicalDAO technicalDAO;
    public TechnicalService() {
        technicalDAO = new TechnicalDAO();
    }
    public int addTechnical(TechnicalInfo technicalInfo) {
        return technicalDAO.addTechnical(technicalInfo);
    }
}
