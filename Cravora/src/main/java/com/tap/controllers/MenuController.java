package com.tap.controllers;

import java.io.IOException;
import java.util.List;

import com.tap.DaoImple.MenuDaoImpl;
import com.tap.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/menu")
public class MenuController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int restaurantId=Integer.parseInt(req.getParameter("restaurantId"));
		
		
		MenuDaoImpl menuDaoImpl=new MenuDaoImpl();
		List<Menu> allmenus=menuDaoImpl.getMenusByRestaurant(restaurantId);
		
		req.setAttribute("menu", allmenus);
		RequestDispatcher rd=req.getRequestDispatcher("menus.jsp");
		rd.forward(req, resp);
		
	}
}
