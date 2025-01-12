package services;

import dao.MessageDAO;
import models.Message;

import java.util.List;

public class MessageService {
   private MessageDAO contactDAO;
    public MessageService() {
         contactDAO = new MessageDAO();
    }
    public void insertContact(int idUser, String title, String content) {
        contactDAO.insertContact(idUser, title, content);
    }
    public List<Message> getAllMessages() {
        return contactDAO.getAllMessages();
    }
    public List<Message> getAllMessages(String name) {
        return contactDAO.getAllMessages(name);
    }
}
