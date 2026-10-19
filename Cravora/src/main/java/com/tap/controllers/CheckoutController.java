package com.tap.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get the current user's session.
        HttpSession session = req.getSession();

        // Check whether a user is already logged in.
        Object loggedInUser = session.getAttribute("loggedInUser");

        if (loggedInUser != null) {

            // User is already logged in.
            // For now, send the user to the checkout page.
            resp.sendRedirect("checkout.jsp");

        } else {

            // User is not logged in.
            // Remember that the user is trying to checkout.
            session.setAttribute("checkoutRequired", true);

            // Send the user to the login page.
            resp.sendRedirect("login.jsp");
        }
    }
}