package services;

import dao.AddressDao;
import models.Address;

public class AddressService {
    AddressDao dao;

    public AddressService() {
        dao = new AddressDao();
    }

    public int getLastId() {
        return dao.getLastId();
    }

    public int insertAddress(Address address) {
        return dao.addAddress(address);
    }

    public Address getAddressById(int id) {
        return dao.getAddressByID(id);
    }

    public boolean deleteAddress(int id) {
        return dao.deleteAddress(id);
    }

    public Address getAddressByID(int id) {
        return dao.getAddressByID(id);
    }

    public Address findAddress(String province, String district, String ward, String detail) {
        return dao.findAddress(province, district, ward, detail);
    }
}
