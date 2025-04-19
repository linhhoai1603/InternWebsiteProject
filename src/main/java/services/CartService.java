package services;

import dao.CartDAO;
import models.Cart;
import models.CartItem;

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
                cartDAO.updateCartItem(cartItem.getId(), cartItem.getQuantity(), cartItem.getUnitPrice(), cartItem.getAddedDate());
                return;
            }
        }
                // 2.2 If don't contain then add to cart
                cartDAO.addToCart(newItem);
    }
}
