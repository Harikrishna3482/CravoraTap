package com.tap.controllers;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.DaoImple.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {

	    // Get login details from the form.
	    String email = req.getParameter("email");
	    String password = req.getParameter("password");

	    // Get the user from the database using email.
	    UserDaoImpl userDaoImpl = new UserDaoImpl();
	    User user = userDaoImpl.getUserByEmail(email);

	    // Check whether the user exists and the password is correct.
	    if (user != null && BCrypt.checkpw(password, user.getPassword())) {

	        // Create or get the current session.
	        HttpSession session = req.getSession();

	        // Store the logged-in user in the session.
	        session.setAttribute("loggedInUser", user);

	        // Check whether the user came to login because of checkout.
	        Boolean checkoutRequired =
	                (Boolean) session.getAttribute("checkoutRequired");

	        if (Boolean.TRUE.equals(checkoutRequired)) {

	            // Remove the temporary checkout flag.
	            session.removeAttribute("checkoutRequired");

	            // Continue to checkout.
	            resp.sendRedirect(req.getContextPath() + "/checkout");

	        } else {

	            // Normal login.
	            resp.sendRedirect(req.getContextPath() + "/restaurant");
	
	        }

	    } else {

	        // Login failed.
	        req.setAttribute(
	                "loginError",
	                "Invalid email or password"
	        );

	        RequestDispatcher rd =
	                req.getRequestDispatcher("login.jsp");

	        rd.forward(req, resp);
	    }
	}
}
