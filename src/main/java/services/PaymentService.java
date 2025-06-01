package services;

import dao.PaymentDAO;
import models.Payment;

public class PaymentService {
    private PaymentDAO paymentDao;

    public PaymentService() {
        paymentDao = new PaymentDAO();
    }


    public int insertPayment(Payment payment) {
        return paymentDao.insertPayment(payment);
    }
}
