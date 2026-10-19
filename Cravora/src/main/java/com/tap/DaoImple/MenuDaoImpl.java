package com.tap.DaoImple;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.MenuDao;
import com.tap.model.Menu;
import com.tap.util.DBConnection;

public class MenuDaoImpl implements MenuDao {

    @Override
    public void addMenu(Menu menu) {

        String sql = "INSERT INTO menus "
                   + "(restaurantId, itemName, description, price, isAvailable, imagePath) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, menu.getRestaurantId());
            statement.setString(2, menu.getItemName());
            statement.setString(3, menu.getDescription());
            statement.setDouble(4, menu.getPrice());
            statement.setBoolean(5, menu.isAvailable());
            statement.setString(6, menu.getImagePath());

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int menuId) {

        String sql = "SELECT * FROM menus WHERE menuId = ?";
        Menu menu = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, menuId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    menu = new Menu();

                    menu.setMenuId(resultSet.getInt("menuId"));
                    menu.setRestaurantId(resultSet.getInt("restaurantId"));
                    menu.setItemName(resultSet.getString("itemName"));
                    menu.setDescription(resultSet.getString("description"));
                    menu.setPrice(resultSet.getDouble("price"));
                    menu.setAvailable(resultSet.getBoolean("isAvailable"));
                    menu.setImagePath(resultSet.getString("imagePath"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menu;
    }

    @Override
    public List<Menu> getAllMenus() {

        String sql = "SELECT * FROM menus";
        List<Menu> menus = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Menu menu = new Menu();

                menu.setMenuId(resultSet.getInt("menuId"));
                menu.setRestaurantId(resultSet.getInt("restaurantId"));
                menu.setItemName(resultSet.getString("itemName"));
                menu.setDescription(resultSet.getString("description"));
                menu.setPrice(resultSet.getDouble("price"));
                menu.setAvailable(resultSet.getBoolean("isAvailable"));
                menu.setImagePath(resultSet.getString("imagePath"));

                menus.add(menu);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menus;
    }

    @Override
    public void updateMenu(Menu menu) {

        String sql = "UPDATE menus SET restaurantId = ?, itemName = ?, "
                   + "description = ?, price = ?, isAvailable = ?, imagePath = ? "
                   + "WHERE menuId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, menu.getRestaurantId());
            statement.setString(2, menu.getItemName());
            statement.setString(3, menu.getDescription());
            statement.setDouble(4, menu.getPrice());
            statement.setBoolean(5, menu.isAvailable());
            statement.setString(6, menu.getImagePath());
            statement.setInt(7, menu.getMenuId());

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuId) {

        String sql = "DELETE FROM menus WHERE menuId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, menuId);

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Menu> getMenusByRestaurant(int restaurantId) {

        String sql = "SELECT * FROM menus WHERE restaurantId = ?";
        List<Menu> menus = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, restaurantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Menu menu = new Menu();

                    menu.setMenuId(resultSet.getInt("menuId"));
                    menu.setRestaurantId(resultSet.getInt("restaurantId"));
                    menu.setItemName(resultSet.getString("itemName"));
                    menu.setDescription(resultSet.getString("description"));
                    menu.setPrice(resultSet.getDouble("price"));
                    menu.setAvailable(resultSet.getBoolean("isAvailable"));
                    menu.setImagePath(resultSet.getString("imagePath"));

                    menus.add(menu);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menus;
    }
}