package test;

import models.Cart;
import models.CartItem;
import services.CartService;

public class Main {
    public static void main(String[] args) {
        CartService cartService = new CartService();
//        cartService.updateQuantity(7, 1);
//        cartService.addToCartItem(23, new CartItem(1, 640, 3));
//        cartService.deleteCartItem(1,1);
        Cart cart = cartService.getCart(23);
        cartService.applyVoucherToCart(cart, "VOUCHER01", cart.getTotalPrice());
        System.out.println(cart);
        System.out.println(cart.getTotalItems());
        System.out.println(cart.getTotalPrice());
        System.out.println(cart.getTotalQuantity());
    }
}
