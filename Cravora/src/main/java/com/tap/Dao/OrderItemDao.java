package com.tap.Dao;

import java.util.List;

import com.tap.model.OrderItem;

public interface OrderItemDao {

    void addOrderItem(OrderItem orderItem);

    OrderItem getOrderItem(int orderItemId);

    List<OrderItem> getAllOrderItems();

    void updateOrderItem(OrderItem orderItem);

    void deleteOrderItem(int orderItemId);

    List<OrderItem> getOrderItemsByOrder(int orderId);

    List<OrderItem> getOrderItemsByMenu(int menuId);
}