package com.tap.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    // Stores the restaurant to which this cart currently belongs.
    // 0 means the cart is initially empty and has no restaurant.
    private int restaurantId;

    // Stores menuId as the key and CartItem as the value.
    // LinkedHashMap preserves the order in which items were added.
    private Map<Integer, CartItem> items;

    // Default constructor
    public Cart() {
        items = new LinkedHashMap<>();
        restaurantId=0;
    }

    // Constructor to create a cart for a specific restaurant.
    public Cart(int restaurantId) {
        this.restaurantId = restaurantId;
        items = new LinkedHashMap<>();
    }

    // Adds a menu item to the cart.
    // Returns true if the item is added successfully.
    // Returns false if the item belongs to a different restaurant.
    public boolean addItem(Menu menu) {

        // If the cart is empty, the first menu item decides the restaurant.
        if (items.isEmpty()) {
            restaurantId = menu.getRestaurantId();
        }

        // Do not allow items from a different restaurant.
        if (restaurantId != menu.getRestaurantId()) {
            return false;
        }

        // Get the unique ID of the menu item.
        int menuId = menu.getMenuId();

        // Check whether this menu item already exists in the cart.
        if (items.containsKey(menuId)) {

            // Get the existing CartItem.
            CartItem existingItem = items.get(menuId);

            // Increase its quantity by one.
            existingItem.setQuantity(existingItem.getQuantity() + 1);

        } else {

            // Create a new CartItem with quantity 1.
            CartItem cartItem = new CartItem(menu, 1);

            // Add the new CartItem using menuId as the key.
            items.put(menuId, cartItem);
        }

        // Item was successfully added.
        return true;
    }

    // Updates the quantity of an existing menu item.
    public void updateQuantity(int menuId, int quantity) {

        // Check whether the menu item exists in the cart.
        if (items.containsKey(menuId)) {

            // If quantity is greater than zero, update it.
            if (quantity > 0) {
                items.get(menuId).setQuantity(quantity);

            // If quantity becomes zero, remove the item.
            } else {
                items.remove(menuId);
            }
        }

        // If the cart becomes empty, reset the restaurant.
        if (items.isEmpty()) {
            restaurantId = 0;
        }
    }

    // Removes a menu item completely from the cart.
    public void removeItem(int menuId) {

        items.remove(menuId);

        // If no items remain, the cart no longer belongs to a restaurant.
        if (items.isEmpty()) {
            restaurantId = 0;
        }
    }

    // Returns all cart items.
    public Map<Integer, CartItem> getItems() {
        return items;
    }

    // Returns the restaurant ID of the current cart.
    public int getRestaurantId() {
        return restaurantId;
    }

    // Updates the restaurant ID.
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    // Calculates the total price of all items in the cart.
    public double getTotal() {

        double total = 0;

        // Calculate subtotal of every CartItem.
        for (CartItem cartItem : items.values()) {
            total += cartItem.getSubtotal();
        }

        return total;
    }

    // Calculates the total quantity of items in the cart.
    public int getItemCount() {

        int count = 0;

        // Add the quantity of every CartItem.
        for (CartItem cartItem : items.values()) {
            count += cartItem.getQuantity();
        }

        return count;
    }

    // Checks whether the cart is empty.
    public boolean isEmpty() {
        return items.isEmpty();
    }

    // Clears all items from the cart.
    public void clearCart() {

        // Remove all CartItems.
        items.clear();

        // Reset restaurant because the cart is completely empty.
        restaurantId = 0;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "restaurantId=" + restaurantId +
                ", items=" + items +
                ", total=" + getTotal() +
                ", itemCount=" + getItemCount() +
                '}';
    }
}