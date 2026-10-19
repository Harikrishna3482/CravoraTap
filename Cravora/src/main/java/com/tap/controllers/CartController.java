package com.tap.controllers;

import java.io.IOException;

import com.tap.DaoImple.MenuDaoImpl;
import com.tap.model.Cart;
import com.tap.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get the current user's session.
        HttpSession session = req.getSession();

        // Get the action sent by the requesting page.
        String action = req.getParameter("action");

        // Get the existing Cart from the session.
        Cart cart = (Cart) session.getAttribute("cart");


        // ---------------------------------------------------------
        // UPDATE QUANTITY
        // ---------------------------------------------------------

        if ("update".equals(action)) {

            // Get the menu ID of the item being updated.
            int menuId = Integer.parseInt(req.getParameter("menuId"));

            // Get the new quantity.
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            if (cart != null) {

                // Update the quantity of the selected item.
                cart.updateQuantity(menuId, quantity);

                // Store the updated Cart in the session.
                session.setAttribute("cart", cart);

                // Recalculate and update the Cart count.
                int cartCount = cart.getItemCount();
                session.setAttribute("cartCount", cartCount);
            }

            // Check where the update request came from.
            String source = req.getParameter("source");

            if ("menu".equals(source)) {

                // Get the Menu object to find its restaurant ID.
                MenuDaoImpl menuDaoImpl = new MenuDaoImpl();
                Menu menu = menuDaoImpl.getMenu(menuId);

                // Return to the same restaurant's Menu page.
                resp.sendRedirect(
                        "menu?restaurantId=" + menu.getRestaurantId()
                );

            } else {

                // Return to the Cart page.
                resp.sendRedirect("cart");
            }

            // Stop execution.
            return;
        }


        // ---------------------------------------------------------
        // REMOVE ITEM
        // ---------------------------------------------------------

        else if ("remove".equals(action)) {

            // Get the menu ID of the item to be removed.
            int menuId = Integer.parseInt(req.getParameter("menuId"));

            // Check whether a Cart exists in the session.
            if (cart != null) {

                // Remove the selected item completely from the Cart.
                cart.removeItem(menuId);

                // Store the updated Cart in the session.
                session.setAttribute("cart", cart);

                // Recalculate the Cart count.
                int cartCount = cart.getItemCount();

                // Store the updated Cart count.
                session.setAttribute("cartCount", cartCount);
            }

            // Return to the Cart page.
            RequestDispatcher re = req.getRequestDispatcher("cart.jsp");
            re.forward(req, resp);

            // Stop execution.
            return;
        }


        // ---------------------------------------------------------
        // CLEAR CART
        // ---------------------------------------------------------

        else if ("clear".equals(action)) {

            // Check whether a Cart exists in the session.
            if (cart != null) {

                // Remove all items from the Cart.
                cart.clearCart();

                // Store the updated Cart in the session.
                session.setAttribute("cart", cart);

                // Recalculate the Cart count.
                int cartCount = cart.getItemCount();

                // Store the updated Cart count.
                session.setAttribute("cartCount", cartCount);

            } else {

                // No Cart exists, so the Cart count is zero.
                session.setAttribute("cartCount", 0);
            }

            // Return to the Cart page.
            RequestDispatcher re = req.getRequestDispatcher("cart.jsp");
            re.forward(req, resp);

            // Stop execution.
            return;
        }
        else if ("keep".equals(action)) {

            int restaurantId =
                    (Integer) session.getAttribute("pendingRestaurantId");

            session.removeAttribute("pendingMenuId");
            session.removeAttribute("pendingRestaurantId");
            session.removeAttribute("showReplaceCart");

            resp.sendRedirect(
                    "menu?restaurantId=" + restaurantId
            );

            return;
        }

        else if ("replace".equals(action)) {

            int menuId =
                    (Integer) session.getAttribute("pendingMenuId");

            int restaurantId =
                    (Integer) session.getAttribute("pendingRestaurantId");

            cart.clearCart();

            MenuDaoImpl menuDaoImpl = new MenuDaoImpl();

            Menu menu = menuDaoImpl.getMenu(menuId);

            cart.addItem(menu);

            session.setAttribute("cart", cart);

            int cartCount = cart.getItemCount();

            session.setAttribute("cartCount", cartCount);

            session.removeAttribute("pendingMenuId");
            session.removeAttribute("pendingRestaurantId");
            session.removeAttribute("showReplaceCart");

            resp.sendRedirect(
                    "menu?restaurantId=" + restaurantId
            );

            return;
        }

        // ---------------------------------------------------------
        // ADD TO CART
        // ---------------------------------------------------------

        // Get the menu ID sent from menus.jsp.
        int menuId = Integer.parseInt(req.getParameter("menuId"));

        // Retrieve the selected Menu object from the database.
        MenuDaoImpl menuDaoImpl = new MenuDaoImpl();
        Menu menu = menuDaoImpl.getMenu(menuId);

        // Create a new Cart if one does not exist.
        if (cart == null) {

            cart = new Cart();

            // Store the newly created Cart in the session.
            session.setAttribute("cart", cart);
        }

        // Try to add the selected Menu to the Cart.
        boolean added = cart.addItem(menu);

        if (added) {

            // Store the updated Cart in the session.
            session.setAttribute("cart", cart);

            // Calculate the total quantity of items in the Cart.
            int cartCount = cart.getItemCount();

            // Store the updated Cart count in the session.
            session.setAttribute("cartCount", cartCount);

            // Return to the Menu page.
            resp.sendRedirect(
                    "menu?restaurantId=" + menu.getRestaurantId()
            );

        } else {

            // Item belongs to a different restaurant.

            // Store the selected item temporarily in the session.
            session.setAttribute("pendingMenuId", menuId);

            // Store the restaurant ID of the pending item.
            session.setAttribute(
                    "pendingRestaurantId",
                    menu.getRestaurantId()
            );

            // Tell menus.jsp to show the replacement confirmation box.
            session.setAttribute("showReplaceCart", true);

            // Return through MenuController so the menu items are loaded again.
            resp.sendRedirect(
                    "menu?restaurantId=" + menu.getRestaurantId()
            );
        }
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        RequestDispatcher re = req.getRequestDispatcher("cart.jsp");
        re.forward(req, resp);
    }
}