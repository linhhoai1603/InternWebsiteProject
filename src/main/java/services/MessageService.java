package services;

import dao.ContactDAO;

public class MessageService {
   private ContactDAO contactDAO;
    public MessageService() {
         contactDAO = new ContactDAO();
    }
    public void insertContact(int idUser, String title, String content) {
        contactDAO.insertContact(idUser, title, content);
    }
}
