package com.harvey.demo.day20;

import com.harvey.project.utils.Helpers;
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
        req.getRequestDispatcher("WEB-INF/day20/calculator.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String num1 = req.getParameter("num1");
        String num2 = req.getParameter("num2");
        results.clear();
        add(num1, num2);
        results.put("num1", num1);
        results.put("num2", num2);
        req.setAttribute("results", results);
        req.getRequestDispatcher("WEB-INF/day20/calculator.jsp").forward(req, resp);
    }

    public void add(String num1, String num2) {
        if(Helpers.isANumber(num1) && Helpers.isANumber(num2)) {
            double n1 = Double.parseDouble(num1);
            double n2 = Double.parseDouble(num2);
            results.put("sum", num1 + " + " + num2 + " = " + Helpers.round(n1 + n2));
        } else {
            results.put("invalidNumber", "Please input a valid number");
        }
    }
}
