package com.harvey.project;

import com.harvey.data_access.QuoteDAO;
import com.harvey.data_access.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "quoteServlet", value = "/quote-db")
public class QuoteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("quotes", QuoteDAO.getAll());
        req.getRequestDispatcher("WEB-INF/quote_project/quote-db.jsp").forward(req, resp);
    }
}
