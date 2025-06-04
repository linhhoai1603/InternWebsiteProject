package services;

import dao.AddressDao;
import dao.UserDao;
import models.Address;
import models.User;

public class UserInForServies {
    UserDao userDao;
    AddressDao addressDao;

    public UserInForServies() {
        userDao = new UserDao();
        addressDao = new AddressDao();
    }

    public boolean updateInfo(int idUser, int idAddress, String email, String firstname, String lastname, String phone,
                            String province, String district, String ward, String detail) {
        try {
            // Begin transaction
            userDao.beginTransaction();

            // Update user information
            boolean userUpdated = userDao.updateInfo(idUser, email, firstname, lastname, phone);
            if (!userUpdated) {
                userDao.rollbackTransaction();
                return false;
            }

            // Update address information
            boolean addressUpdated = addressDao.updateAddress(idAddress, province, district, ward, detail);
            if (!addressUpdated) {
                userDao.rollbackTransaction();
                return false;
            }

            // If both updates succeed, commit the transaction
            userDao.commitTransaction();
            return true;

        } catch (Exception e) {
            userDao.rollbackTransaction();
            e.printStackTrace();
            return false;
        } finally {
            userDao.closeTransaction();
        }
    }

    public boolean updateAvatar(int idUser, String path) {
        return userDao.updateAvatar(idUser, path);
    }

//    public boolean updateUserAndAddress(User userToUpdate) {
//        boolean userUpdateSuccess = false;
//        boolean addressOperationSuccess = true;
//
//        try {
//            // 1. Cập nhật thông tin cơ bản của User (không bao gồm idAddress)
//            userUpdateSuccess = userDao.updateInfo(
//                    userToUpdate.getId(),
//                    userToUpdate.getFirstname(),
//                    userToUpdate.getLastname(),
//                    userToUpdate.getNumberPhone()
//            );
//
//            if (!userUpdateSuccess) {
//                return false;
//            }
//
//            Address address = userToUpdate.getAddress();
//
//            if (address != null) {
//                boolean hasAddressInfo = address.getProvince() != null && !address.getProvince().trim().isEmpty();
//
//                if (address.getId() > 0) {
//                    if (hasAddressInfo) {
//                        addressOperationSuccess = addressDao.updateAddress( // sửa method này
//                                address.getId(),
//                                address.getProvince(),
//                                address.getDistrict(),
//                                address.getWard(),
//                                address.getDetail()
//                        );
//                    }
//                } else if (hasAddressInfo) {
//                    int newAddressId = addressDao.createAddress(
//                            address.getProvince(),
//                            address.getDistrict(),
//                            address.getWard(),
//                            address.getDetail()
//                    );
//
//                    if (newAddressId > 0) {
//                        address.setId(newAddressId);
//                        addressOperationSuccess = userDao.updateUserAddressId(
//                                userToUpdate.getId(),
//                                newAddressId
//                        );
//                    } else {
//                        addressOperationSuccess = false;
//                    }
//                }
//            }
//
//            if (userUpdateSuccess && addressOperationSuccess) {
//                return true;
//            } else {
//                return false;
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
}
