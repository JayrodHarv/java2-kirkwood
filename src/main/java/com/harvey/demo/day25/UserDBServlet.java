package com.harvey.demo.day25;

import com.harvey.data_access.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "userDBServlet", value = "/users-db")
public class UserDBServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", UserDAO.getAll());
        req.getRequestDispatcher("WEB-INF/day25/users-db.jsp").forward(req, resp);
    }
}
