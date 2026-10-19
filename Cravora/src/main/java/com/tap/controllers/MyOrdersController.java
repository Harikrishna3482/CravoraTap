package com.tap.controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.DaoImple.MenuDaoImpl;
import com.tap.DaoImple.OrderDaoImpl;
import com.tap.DaoImple.OrderItemDaoImpl;
import com.tap.DaoImple.RestaurantDaoImpl;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/myOrders")
public class MyOrdersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        User loggedInUser =
                (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId = loggedInUser.getUserId();

        /* =====================================================
           GET USER ORDERS
           ===================================================== */

        OrderDaoImpl orderDaoImpl = new OrderDaoImpl();

        List<Order> orders =
                orderDaoImpl.getOrdersByUser(userId);


        /* =====================================================
           GET ORDER ITEMS
           ===================================================== */

        OrderItemDaoImpl orderItemDaoImpl =
                new OrderItemDaoImpl();

        Map<Integer, List<OrderItem>> orderItemsMap =
                new HashMap<>();

        for (Order order : orders) {

            List<OrderItem> orderItems =
                    orderItemDaoImpl.getOrderItemsByOrder(
                            order.getOrderId()
                    );

            orderItemsMap.put(
                    order.getOrderId(),
                    orderItems
            );
        }


        /* =====================================================
           GET MENU DETAILS
           ===================================================== */

        MenuDaoImpl menuDaoImpl =
                new MenuDaoImpl();

        Map<Integer, Menu> menuMap =
                new HashMap<>();

        for (List<OrderItem> orderItems
                : orderItemsMap.values()) {

            for (OrderItem orderItem : orderItems) {

                int menuId =
                        orderItem.getMenuId();

                if (!menuMap.containsKey(menuId)) {

                    Menu menu =
                            menuDaoImpl.getMenu(menuId);

                    menuMap.put(
                            menuId,
                            menu
                    );
                }
            }
        }


        /* =====================================================
           GET RESTAURANT DETAILS
           ===================================================== */

        RestaurantDaoImpl restaurantDaoImpl =
                new RestaurantDaoImpl();

        Map<Integer, Restaurant> restaurantMap =
                new HashMap<>();

        for (Order order : orders) {

            int restaurantId =
                    order.getRestaurantId();

            if (!restaurantMap.containsKey(restaurantId)) {

                Restaurant restaurant =
                        restaurantDaoImpl.getRestaurant(
                                restaurantId
                        );

                restaurantMap.put(
                        restaurantId,
                        restaurant
                );
            }
        }


        /* =====================================================
           SEND DATA TO JSP
           ===================================================== */

        req.setAttribute(
                "orders",
                orders
        );

        req.setAttribute(
                "orderItemsMap",
                orderItemsMap
        );

        req.setAttribute(
                "menuMap",
                menuMap
        );

        req.setAttribute(
                "restaurantMap",
                restaurantMap
        );


        /* =====================================================
           FORWARD TO MY ORDERS JSP
           ===================================================== */

        RequestDispatcher rd =
                req.getRequestDispatcher(
                        "myOrders.jsp"
                );

        rd.forward(req, resp);
    }
}