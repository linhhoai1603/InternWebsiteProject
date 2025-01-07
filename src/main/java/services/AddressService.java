package services;

import dao.AddressDao;
import models.Address;

public class AddressService {
    AddressDao dao;
    public AddressService(){
        dao = new AddressDao();
    }
    public int getLastId(){
        return dao.getLastId();
    }
    public boolean insertAddress(Address address){
        return dao.addAddress(address);
    }
    public Address getAddressById(int id){
        return dao.getAddressByID(id);
    }
}
