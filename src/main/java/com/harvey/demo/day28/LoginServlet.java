package com.harvey.demo.day28;

import com.harvey.data_access.UserDAO;
import com.harvey.demo.day25.User;
import com.harvey.project.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Objects;

@WebServlet(name="loginServlet", value="/login")
public class LoginServlet extends HttpServlet {

    private static Map<String, String> results = new HashMap<>();
    private static int maxLoginAttempts = 5;
    private int loginAttemptCount = 0;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/day28/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("inputEmail1");
        String password = req.getParameter("inputPassword1");
        String[] rememberMe = req.getParameterValues("rememberMe");

        results.clear();
        results.put("email", email);
        results.put("password", password);
        // if user doesn't check the box the value is null and the code after the and would crash the server
        // so the first check is necessary
        if(rememberMe!= null && rememberMe[0].equals("true")) {
            results.put("rememberMe", rememberMe[0]);
        }  else {
            results.put("rememberMe", "");
        }
        try {
            User userFromDatabase = UserDAO.get(email);
            if(userFromDatabase == null) {
                results.put("loginFail", "No user found with that email and password combination.");
            } else {
                // user is locked
                if(userFromDatabase.getStatus().equals("locked")) {
                    results.put("loginFail", "You are locked out of your account, please reset your password to access your account.");
                } else {
                    // No user found that matches the password
                    if (!PasswordUtil.checkpw(password, String.valueOf(userFromDatabase.getPassword()))) {
                        loginAttemptCount++;
                        if(loginAttemptCount == maxLoginAttempts) {
                            // change user status to locked and add loginFail message saying
                            // that the user needs to reset their password
                            userFromDatabase.setStatus("locked");
                            UserDAO.update(userFromDatabase);
                            results.put("loginFail", "You are now locked out of your account, please reset your password to access your account.");
                        } else {
                            int attemptsLeft = Math.max((maxLoginAttempts - loginAttemptCount), 0);
                            results.put("loginFail", "Incorrect password. You have " + attemptsLeft +
                                    " attempts left before you get locked out.");
                        }
                    } else {
                        // Successful login
                        loginAttemptCount = 0;
                        String firstName = userFromDatabase.getFirstName() != null ? " " + userFromDatabase.getFirstName() : "";
                        results.put("loginSuccess", String.format("Welcome back%s!", firstName));
                    }
                }
            }
        } catch(Exception e) {
            results.put("loginFail", "Cannot log you in. Try again later.");
        }

        req.setAttribute("results", results);
        req.getRequestDispatcher("WEB-INF/day28/login.jsp").forward(req, resp);
    }
}
