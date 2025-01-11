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
    public boolean updateInfo(int idUser, int idAddress, String email, String name, String phone,
                              String province, String city, String commune, String street) {
        try {
            // Cập nhật thông tin user
            boolean userUpdated = userDao.updateInfo(idUser, email, name, phone);
            if (!userUpdated) {
                return false; // Dừng nếu cập nhật thông tin user thất bại
            }

            // Cập nhật thông tin địa chỉ
            boolean addressUpdated = addressDao.updateAddress(idAddress, province, city, commune, street);
            if (!addressUpdated) {
                return false; // Dừng nếu cập nhật địa chỉ thất bại
            }

            // Trả về true nếu tất cả cập nhật thành công
            return true;

        } catch (Exception e) {
            e.printStackTrace(); // Ghi log lỗi
            return false; // Trả về false nếu xảy ra lỗi
        }
    }

    public boolean updateAvatar(int idUser, String path) {
        return userDao.updateAvatar(idUser,path);
    }

}
