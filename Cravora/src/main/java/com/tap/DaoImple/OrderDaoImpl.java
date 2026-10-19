package com.tap.DaoImple;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.OrderDao;
import com.tap.model.Order;
import com.tap.util.DBConnection;

public class OrderDaoImpl implements OrderDao {

	@Override
	public int addOrder(Order order) {

	    String sql = "INSERT INTO orders "
	               + "(userId, restaurantId, totalAmount, status, paymentMode) "
	               + "VALUES (?, ?, ?, ?, ?)";

	    int orderId = 0;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(
	                 sql,
	                 java.sql.Statement.RETURN_GENERATED_KEYS)) {

	        statement.setInt(1, order.getUserId());
	        statement.setInt(2, order.getRestaurantId());
	        statement.setDouble(3, order.getTotalAmount());
	        statement.setString(4, order.getStatus());
	        statement.setString(5, order.getPaymentMode());

	        statement.executeUpdate();

	        try (ResultSet resultSet = statement.getGeneratedKeys()) {

	            if (resultSet.next()) {
	                orderId = resultSet.getInt(1);
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return orderId;
	}

    @Override
    public Order getOrder(int orderId) {

        String sql = "SELECT * FROM orders WHERE orderId = ?";
        Order order = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    order = new Order();

                    order.setOrderId(resultSet.getInt("orderId"));
                    order.setUserId(resultSet.getInt("userId"));
                    order.setRestaurantId(resultSet.getInt("restaurantId"));
                    order.setOrderDate(resultSet.getTimestamp("orderDate"));
                    order.setTotalAmount(resultSet.getDouble("totalAmount"));
                    order.setStatus(resultSet.getString("status"));
                    order.setPaymentMode(resultSet.getString("paymentMode"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return order;
    }

    @Override
    public List<Order> getAllOrders() {

        String sql = "SELECT * FROM orders";
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Order order = new Order();

                order.setOrderId(resultSet.getInt("orderId"));
                order.setUserId(resultSet.getInt("userId"));
                order.setRestaurantId(resultSet.getInt("restaurantId"));
                order.setOrderDate(resultSet.getTimestamp("orderDate"));
                order.setTotalAmount(resultSet.getDouble("totalAmount"));
                order.setStatus(resultSet.getString("status"));
                order.setPaymentMode(resultSet.getString("paymentMode"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public void updateOrder(Order order) {

        String sql = "UPDATE orders SET userId = ?, restaurantId = ?, "
                   + "orderDate = ?, totalAmount = ?, status = ?, paymentMode = ? "
                   + "WHERE orderId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, order.getUserId());
            statement.setInt(2, order.getRestaurantId());
            statement.setTimestamp(3, order.getOrderDate());
            statement.setDouble(4, order.getTotalAmount());
            statement.setString(5, order.getStatus());
            statement.setString(6, order.getPaymentMode());
            statement.setInt(7, order.getOrderId());

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderId) {

        String sql = "DELETE FROM orders WHERE orderId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {

        String sql = "SELECT * FROM orders WHERE userId = ?";
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Order order = new Order();

                    order.setOrderId(resultSet.getInt("orderId"));
                    order.setUserId(resultSet.getInt("userId"));
                    order.setRestaurantId(resultSet.getInt("restaurantId"));
                    order.setOrderDate(resultSet.getTimestamp("orderDate"));
                    order.setTotalAmount(resultSet.getDouble("totalAmount"));
                    order.setStatus(resultSet.getString("status"));
                    order.setPaymentMode(resultSet.getString("paymentMode"));

                    orders.add(order);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public List<Order> getOrdersByRestaurant(int restaurantId) {

        String sql = "SELECT * FROM orders WHERE restaurantId = ?";
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, restaurantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Order order = new Order();

                    order.setOrderId(resultSet.getInt("orderId"));
                    order.setUserId(resultSet.getInt("userId"));
                    order.setRestaurantId(resultSet.getInt("restaurantId"));
                    order.setOrderDate(resultSet.getTimestamp("orderDate"));
                    order.setTotalAmount(resultSet.getDouble("totalAmount"));
                    order.setStatus(resultSet.getString("status"));
                    order.setPaymentMode(resultSet.getString("paymentMode"));

                    orders.add(order);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
}