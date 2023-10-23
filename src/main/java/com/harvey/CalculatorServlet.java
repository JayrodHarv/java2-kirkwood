package com.harvey;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "calculatorServlet", value = "/calculator")
public class CalculatorServlet extends HttpServlet {

    private static Map<String, String> results = new HashMap<>();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("You made a GET request");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String num1 = req.getParameter("num1");
        String num2 = req.getParameter("num2");
        results.put("num1", num1);
        results.put("num2", num2);
        req.setAttribute("results", results);
        req.getRequestDispatcher("calculator.jsp").forward(req, resp);

    }
}
