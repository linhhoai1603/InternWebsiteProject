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
    public boolean updateInfo(User user, String email, String name, String phone, String province, String city, String commune, String street) {
        // Kiểm tra đầu vào
        if (user == null || email.isBlank() || name.isBlank() || phone.isBlank() || province.isBlank() || city.isBlank()) {
            return false;
        }

        int idUser = user.getId();
        int idAddress = user.getAddress() != null ? user.getAddress().getId() : -1;

        // Bắt đầu giao dịch
        try {
            userDao.beginTransaction();
            addressDao.beginTransaction();

            // Cập nhật thông tin user
            boolean userUpdated = userDao.updateInfo(idUser, email, name, phone);

            // Nếu cập nhật user không thành công, rollback và trả về false
            if (!userUpdated) {
                userDao.rollbackTransaction();
                return false;
            }

            // Cập nhật thông tin địa chỉ
            boolean addressUpdated = addressDao.updateAddress(idAddress, province, city, commune, street);

            // Nếu cập nhật địa chỉ không thành công, rollback và trả về false
            if (!addressUpdated) {
                userDao.rollbackTransaction();
                return false;
            }

            userDao.commitTransaction();
            addressDao.commitTransaction();
            return true;

        } catch (Exception e) {
            // Rollback trong trường hợp xảy ra lỗi
            userDao.rollbackTransaction();
            e.printStackTrace();
            return false;

        } finally {
            // Đóng transaction nếu cần
            userDao.closeTransaction();
        }
    }

}
