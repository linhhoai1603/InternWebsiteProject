package services;

import dao.AddressDao;
import dao.UserDao;
import models.User;

public class UserInForServies {
    UserDao userDao ;
    AddressDao addressDao ;
    public UserInForServies() {
        userDao = new UserDao();
        addressDao = new AddressDao();
    }
    public boolean updateInF(User user, String email, String name, String phone, String province, String city, String commune, String street) {
        int idUser = user.getId();
        int idAdress = user.getAddress().getId();

        boolean u = userDao.updateInfo(idUser,email,name,phone);
        boolean a = addressDao.updateAddress(idAdress,province,city,commune,street);
        if (u && a) return true;
        
        return false;
    }
}
