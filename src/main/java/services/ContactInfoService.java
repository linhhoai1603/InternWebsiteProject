package services;

import dao.AddressDao;
import dao.CategoryDao;
import dao.ContactDao;
import models.Address;
import models.ContactInfo;

public class ContactInfoService {
    private ContactDao contactDao;
    private AddressDao addressDao;
    public ContactInfoService() {
        contactDao= new ContactDao();
        addressDao= new AddressDao();
    }
    public ContactInfo getContactInfo(int contactId) {
        int idAddress = contactDao.getIdAddress(contactId);
        Address address = addressDao.getAddressByID(idAddress);
        ContactInfo rs = contactDao.getContactById(contactId);
        rs.setAddress(address);
        return rs ;
    }
    public boolean updateInfContact(int idContact, String email, String website, String hotline) {
        return contactDao.updateInfContact(idContact, email, website, hotline);
    }
    public boolean updateAddressContact(int idContact, String province , String district , String ward , String detail) {
        int idAddress = contactDao.getIdAddress(idContact);
        return addressDao.updateAddress(idAddress, province, district, ward, detail);
    }

}
