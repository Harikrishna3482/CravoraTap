package com.tap.DaoImple;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.OrderItemDao;
import com.tap.model.OrderItem;
import com.tap.util.DBConnection;

public class OrderItemDaoImpl implements OrderItemDao {

    @Override
    public void addOrderItem(OrderItem orderItem) {

        String sql = "INSERT INTO order_items "
                   + "(orderId, menuId, quantity, totalAmount) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderItem.getOrderId());
            statement.setInt(2, orderItem.getMenuId());
            statement.setInt(3, orderItem.getQuantity());
            statement.setDouble(4, orderItem.getTotalAmount());

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {

        String sql = "SELECT * FROM order_items WHERE orderItemId = ?";
        OrderItem orderItem = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderItemId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    orderItem = new OrderItem();

                    orderItem.setOrderItemId(resultSet.getInt("orderItemId"));
                    orderItem.setOrderId(resultSet.getInt("orderId"));
                    orderItem.setMenuId(resultSet.getInt("menuId"));
                    orderItem.setQuantity(resultSet.getInt("quantity"));
                    orderItem.setTotalAmount(resultSet.getDouble("totalAmount"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderItem;
    }

    @Override
    public List<OrderItem> getAllOrderItems() {

        String sql = "SELECT * FROM order_items";
        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                OrderItem orderItem = new OrderItem();

                orderItem.setOrderItemId(resultSet.getInt("orderItemId"));
                orderItem.setOrderId(resultSet.getInt("orderId"));
                orderItem.setMenuId(resultSet.getInt("menuId"));
                orderItem.setQuantity(resultSet.getInt("quantity"));
                orderItem.setTotalAmount(resultSet.getDouble("totalAmount"));

                orderItems.add(orderItem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public void updateOrderItem(OrderItem orderItem) {

        String sql = "UPDATE order_items SET orderId = ?, menuId = ?, "
                   + "quantity = ?, totalAmount = ? "
                   + "WHERE orderItemId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderItem.getOrderId());
            statement.setInt(2, orderItem.getMenuId());
            statement.setInt(3, orderItem.getQuantity());
            statement.setDouble(4, orderItem.getTotalAmount());
            statement.setInt(5, orderItem.getOrderItemId());

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {

        String sql = "DELETE FROM order_items WHERE orderItemId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderItemId);

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {

        String sql = "SELECT * FROM order_items WHERE orderId = ?";
        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    OrderItem orderItem = new OrderItem();

                    orderItem.setOrderItemId(resultSet.getInt("orderItemId"));
                    orderItem.setOrderId(resultSet.getInt("orderId"));
                    orderItem.setMenuId(resultSet.getInt("menuId"));
                    orderItem.setQuantity(resultSet.getInt("quantity"));
                    orderItem.setTotalAmount(resultSet.getDouble("totalAmount"));

                    orderItems.add(orderItem);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public List<OrderItem> getOrderItemsByMenu(int menuId) {

        String sql = "SELECT * FROM order_items WHERE menuId = ?";
        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, menuId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    OrderItem orderItem = new OrderItem();

                    orderItem.setOrderItemId(resultSet.getInt("orderItemId"));
                    orderItem.setOrderId(resultSet.getInt("orderId"));
                    orderItem.setMenuId(resultSet.getInt("menuId"));
                    orderItem.setQuantity(resultSet.getInt("quantity"));
                    orderItem.setTotalAmount(resultSet.getDouble("totalAmount"));

                    orderItems.add(orderItem);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderItems;
    }
}