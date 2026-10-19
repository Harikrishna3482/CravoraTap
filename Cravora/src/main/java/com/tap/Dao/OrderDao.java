package com.tap.Dao;

import java.util.List;

import com.tap.model.Order;

public interface OrderDao {

    int addOrder(Order order);

    Order getOrder(int orderId);

    List<Order> getAllOrders();

    void updateOrder(Order order);

    void deleteOrder(int orderId);

    List<Order> getOrdersByUser(int userId);

    List<Order> getOrdersByRestaurant(int restaurantId);
}