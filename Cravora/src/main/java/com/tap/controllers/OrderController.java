package com.tap.controllers;

import java.io.IOException;
import java.util.Map;

import com.tap.DaoImple.OrderDaoImpl;
import com.tap.DaoImple.OrderItemDaoImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get the current session.
        HttpSession session = req.getSession();

        // Get the logged-in user from the session.
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Get the cart from the session.
        Cart cart = (Cart) session.getAttribute("cart");

        // Check whether the user is logged in.
        if (loggedInUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Check whether the cart exists and contains items.
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("restaurant.jsp");
            return;
        }

        // Get the selected payment mode from checkout.jsp.
        String paymentMode = req.getParameter("paymentMode");

        // Create the Order object.
        Order order = new Order();

        order.setUserId(loggedInUser.getUserId());
        order.setRestaurantId(cart.getRestaurantId());
        order.setTotalAmount(cart.getTotal());
        order.setStatus("PLACED");
        order.setPaymentMode(paymentMode);

        // Create OrderDaoImpl.
        OrderDaoImpl orderDaoImpl = new OrderDaoImpl();

        // Save the order and get the generated orderId.
        int orderId = orderDaoImpl.addOrder(order);

        // Create OrderItemDaoImpl.
        OrderItemDaoImpl orderItemDaoImpl = new OrderItemDaoImpl();

        // Go through every item in the cart.
        for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {

            CartItem cartItem = entry.getValue();

            // Create OrderItem.
            OrderItem orderItem = new OrderItem();

            orderItem.setOrderId(orderId);
            orderItem.setMenuId(cartItem.getMenu().getMenuId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setTotalAmount(cartItem.getSubtotal());

            // Save the OrderItem.
            orderItemDaoImpl.addOrderItem(orderItem);
        }

        // Clear the cart after successfully placing the order.
        cart.clearCart();
       

        // Redirect to the order success page.
        resp.sendRedirect("order-success.jsp");
    }
}