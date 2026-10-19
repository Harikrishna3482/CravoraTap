package com.tap.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get the current user's session.
        HttpSession session = req.getSession(false);

        // Remove the logged-in user from the session.
        if (session != null) {
            session.removeAttribute("loggedInUser");
        }

        // Return to the login page.
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}