package com.tap.DaoImple;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.RestaurantDao;
import com.tap.model.Restaurant;
import com.tap.util.DBConnection;

public class RestaurantDaoImpl implements RestaurantDao {

    @Override
    public void addRestaurant(Restaurant restaurant) {

        String sql = "INSERT INTO restaurants "
                   + "(name, cuisineType, deliveryTime, address, adminUserId, "
                   + "rating, isActive, imagePath) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, restaurant.getName());
            statement.setString(2, restaurant.getCuisineType());
            statement.setInt(3, restaurant.getDeliveryTime());
            statement.setString(4, restaurant.getAddress());
            statement.setInt(5, restaurant.getAdminUserId());
            statement.setFloat(6, restaurant.getRating());
            statement.setBoolean(7, restaurant.isActive());
            statement.setString(8, restaurant.getImagePath());

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {

        String sql = "SELECT * FROM restaurants WHERE restaurantId = ?";
        Restaurant restaurant = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, restaurantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    restaurant = new Restaurant();

                    restaurant.setRestaurantId(resultSet.getInt("restaurantId"));
                    restaurant.setName(resultSet.getString("name"));
                    restaurant.setCuisineType(resultSet.getString("cuisineType"));
                    restaurant.setDeliveryTime(resultSet.getInt("deliveryTime"));
                    restaurant.setAddress(resultSet.getString("address"));
                    restaurant.setAdminUserId(resultSet.getInt("adminUserId"));
                    restaurant.setRating(resultSet.getFloat("rating"));
                    restaurant.setActive(resultSet.getBoolean("isActive"));
                    restaurant.setImagePath(resultSet.getString("imagePath"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return restaurant;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {

        String sql = "SELECT * FROM restaurants";
        List<Restaurant> restaurants = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Restaurant restaurant = new Restaurant();

                restaurant.setRestaurantId(resultSet.getInt("restaurantId"));
                restaurant.setName(resultSet.getString("name"));
                restaurant.setCuisineType(resultSet.getString("cuisineType"));
                restaurant.setDeliveryTime(resultSet.getInt("deliveryTime"));
                restaurant.setAddress(resultSet.getString("address"));
                restaurant.setAdminUserId(resultSet.getInt("adminUserId"));
                restaurant.setRating(resultSet.getFloat("rating"));
                restaurant.setActive(resultSet.getBoolean("isActive"));
                restaurant.setImagePath(resultSet.getString("imagePath"));

                restaurants.add(restaurant);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return restaurants;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {

        String sql = "UPDATE restaurants SET name = ?, cuisineType = ?, "
                   + "deliveryTime = ?, address = ?, adminUserId = ?, "
                   + "rating = ?, isActive = ?, imagePath = ? "
                   + "WHERE restaurantId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, restaurant.getName());
            statement.setString(2, restaurant.getCuisineType());
            statement.setInt(3, restaurant.getDeliveryTime());
            statement.setString(4, restaurant.getAddress());
            statement.setInt(5, restaurant.getAdminUserId());
            statement.setFloat(6, restaurant.getRating());
            statement.setBoolean(7, restaurant.isActive());
            statement.setString(8, restaurant.getImagePath());
            statement.setInt(9, restaurant.getRestaurantId());

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {

        String sql = "DELETE FROM restaurants WHERE restaurantId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, restaurantId);

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Restaurant> getRestaurantsByAdmin(int adminUserId) {

        String sql = "SELECT * FROM restaurants WHERE adminUserId = ?";
        List<Restaurant> restaurants = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, adminUserId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Restaurant restaurant = new Restaurant();

                    restaurant.setRestaurantId(resultSet.getInt("restaurantId"));
                    restaurant.setName(resultSet.getString("name"));
                    restaurant.setCuisineType(resultSet.getString("cuisineType"));
                    restaurant.setDeliveryTime(resultSet.getInt("deliveryTime"));
                    restaurant.setAddress(resultSet.getString("address"));
                    restaurant.setAdminUserId(resultSet.getInt("adminUserId"));
                    restaurant.setRating(resultSet.getFloat("rating"));
                    restaurant.setActive(resultSet.getBoolean("isActive"));
                    restaurant.setImagePath(resultSet.getString("imagePath"));

                    restaurants.add(restaurant);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return restaurants;
    }
}