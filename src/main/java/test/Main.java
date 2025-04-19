package test;

import models.Cart;
import models.CartItem;
import services.CartService;

public class Main {
    public static void main(String[] args) {
        CartService cartService = new CartService();
        Cart cart = cartService.getCart(23);
        System.out.println(cart);
//        cartService.addToCartItem(23, new CartItem(cart.getId(), 639, 3));
        System.out.println(cart.getTotalItems());
        System.out.println(cart.getTotalPrice());
        System.out.println(cart.getTotalQuantity());
    }
}
