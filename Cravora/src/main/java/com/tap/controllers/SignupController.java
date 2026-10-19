package com.tap.controllers;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.DaoImple.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignupController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get signup details from the form.
        String username = req.getParameter("username");
//        String password = req.getParameter("password");
        String password = BCrypt.hashpw(
                req.getParameter("password"),
                BCrypt.gensalt()
        );
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        // Create a User object.
        User user = new User();

        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole("customer");

        // Add the user to the database.
        UserDaoImpl userDaoImpl = new UserDaoImpl();
        userDaoImpl.addUser(user);

        // Confirm successful signup.
//        resp.getWriter().println("Signup successful.");
        resp.sendRedirect(req.getContextPath() + "/signup.jsp");
    }
}