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
            // Bắt đầu giao dịch
            userDao.beginTransaction();


            // Cập nhật thông tin user
            boolean userUpdated = userDao.updateInfo(idUser, email, name, phone);
            if (!userUpdated) {
                userDao.rollbackTransaction();
                return false;
            }

            // Cập nhật thông tin địa chỉ
            boolean addressUpdated = addressDao.updateAddress(idAddress, province, city, commune, street);
            if (!addressUpdated) {
                userDao.rollbackTransaction();
                return false;
            }

            // Commit giao dịch nếu tất cả cập nhật thành công
            userDao.commitTransaction();
            return true;

        } catch (Exception e) {
            // Rollback nếu xảy ra lỗi
            userDao.rollbackTransaction();
            e.printStackTrace();
            return false;

        } finally {
            // Đóng giao dịch (tự động đóng Handle)
            userDao.closeTransaction();
        }
    }
    

    public static void main(String[] args) {
        UserInForServies user = new UserInForServies();
        System.out.println(user.updateInfo(1,1,"hung1@gmail.com","Lê Đình Hưng", "0337057878", "Đồng Nai","Long Bình","Yết Kiêu","Biên Hòa"));
    }

}
