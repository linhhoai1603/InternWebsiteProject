package services;

import dao.CartDAO;
import models.Cart;
import models.CartItem;
import models.Voucher;

import java.time.LocalDate;
import java.util.List;

public class CartService {
    private CartDAO cartDAO;
    public CartService() {
        cartDAO = new CartDAO();
    }
    // method get id cart
    public Cart getCart(int idUser) {
         Cart cart = cartDAO.getCartByUserId(idUser);
         if(cart == null) {
             // tạo mới cart trong csdl
             cartDAO.createCart(idUser);
             cart = cartDAO.getCartByUserId(idUser);
         }else{
             cart.setCartItems(cartDAO.getCartItemsByCartId(cart.getId()));
         }
         cart.setTotalItems(cart.getCartItems().size());
         cart.setTotalQuantity(cart.getCartItems().stream().mapToInt(CartItem::getQuantity).sum());
         cart.setTotalPrice(cart.getCartItems().stream().mapToDouble(CartItem::getUnitPrice).sum());
        if (cart.getVoucher() == null) {
            cart.setLastPrice(cart.getTotalPrice());
        }else{
            cart.setLastPrice(cart.getTotalPrice() - cart.getVoucher().getDiscountAmount());
        }
         return cart;
    }
    // method get all Cart items by cart id
    public List<CartItem> getCartItems(int cartId) {
        return cartDAO.getCartItemsByCartId(cartId);
    }
    // method add to cart
    public void addToCartItem(int idUser, CartItem newItem) {
        // 1. Get cart items to check
        Cart cart = this.getCart(idUser);
        // 2. Check
        for(CartItem cartItem : cart.getCartItems()) {
            // 2.1 If containing then increment quantity
            if (cartItem.getStyle().getId() == newItem.getStyle().getId()) {
                cartItem.setQuantity(cartItem.getQuantity() + newItem.getQuantity());
                cartItem.setUnitPrice(newItem.getUnitPrice());
                cartItem.setAddedDate(newItem.getAddedDate());
                // update in database
                cartDAO.updateCartItem(cartItem.getId(), cartItem.getQuantity(), cartItem.getAddedDate());
                return;
            }
        }
                // 2.2 If don't contain then add to cart
                cartDAO.addToCart(newItem);
    }
    // method to update of quantity of cart item
    public void updateQuantity(int idItem, int quantity) {
        cartDAO.updateCartItem(idItem, quantity, LocalDate.now());
    }
    // method to remove cart item in cart where id cart and id item
    public void deleteCartItem(int idCart, int cartItemId) {
        cartDAO.removeCartItem(idCart, cartItemId);
    }
    // method to apply voucher in cart
    public void applyVoucherToCart(Cart cart, String voucherCode, double totalPrice) {
        // execute apply
        Voucher voucher = cartDAO.applyVoucherToCart(cart.getId(), voucherCode, totalPrice);
        // discount price
        if(voucher != null) cart.setTotalPrice(cart.getTotalPrice() - voucher.getDiscountAmount());
    }
}
