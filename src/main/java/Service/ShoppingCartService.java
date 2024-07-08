package Service;

import Model.CartItems;
import Model.Product;

import java.util.ArrayList;
import java.util.List;

public class ShoppingCartService {
    private List<CartItems> cartItems = new ArrayList<>();

    private static ShoppingCartService instance;

    public static ShoppingCartService getInstance() {
        if (instance == null) {
            instance = new ShoppingCartService();
        }
        return instance;
    }

    public List<CartItems> getCartItems() {
        return cartItems;
    }

    public void addToCart(Product product, int quantity) {
        for (CartItems item : cartItems) {
            if (item.getProduct().getId().equals(product.getId())) {
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        cartItems.add(new CartItems(product, quantity));
    }

    public List<CartItems> updateCart(String action, String productId) {
        for (CartItems item : cartItems) {
            if (item.getProduct().getId().equals(productId)) {
                if (action.equals("tang")) {
                    item.setQuantity(item.getQuantity() + 1);
                } else if (action.equals("giam")) {
                    item.setQuantity(item.getQuantity() - 1);
                    if (item.getQuantity() <= 0) {
                        cartItems.remove(item);
                    }
                }
                break;
            }
        }
        return cartItems;
    }

    public List<CartItems> deleteFromCart(String productId) {
        cartItems.removeIf(item -> item.getProduct().getId().equals(productId));
        return cartItems;
    }
}
