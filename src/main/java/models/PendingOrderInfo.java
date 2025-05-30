package models;

public class PendingOrderInfo {
    private User user;
    private Cart cart;
    private Address deliveryAddressDetails;
    private String deliveryPersonName;
    private String deliveryPhone;
    private String deliveryNotes;
    private String paymentMethod;
    private String vnp_TxnRef;

    public PendingOrderInfo(User user, Cart cart, Address deliveryAddressDetails, String deliveryPersonName, String deliveryPhone, String deliveryNotes, String paymentMethod, String vnp_TxnRef) {
        this.user = user;
        this.cart = cart;
        this.deliveryAddressDetails = deliveryAddressDetails;
        this.deliveryPersonName = deliveryPersonName;
        this.deliveryPhone = deliveryPhone;
        this.deliveryNotes = deliveryNotes;
        this.paymentMethod = paymentMethod;
        this.vnp_TxnRef = vnp_TxnRef;
    }

    public User getUser() { return user; }
    public Cart getCart() { return cart; }
    public Address getDeliveryAddressDetails() { return deliveryAddressDetails; }
    public String getDeliveryPersonName() { return deliveryPersonName; }
    public String getDeliveryPhone() { return deliveryPhone; }
    public String getDeliveryNotes() { return deliveryNotes; }
    public String getPaymentMethod() { return paymentMethod; }
}
