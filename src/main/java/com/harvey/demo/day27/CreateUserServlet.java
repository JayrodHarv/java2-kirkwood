package com.harvey.demo.day27;

import com.harvey.data_access.UserDAO;
import com.harvey.demo.day25.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;

@WebServlet(name="createUserServlet", value="/signup")
public class CreateUserServlet extends HttpServlet {

    private static HashMap<String, String> results = new HashMap<>();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/day27/create-user.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("inputEmail1");
        String password1 = req.getParameter("inputPassword1");
        String password2 = req.getParameter("inputPassword2");
        String[] termsOfService = req.getParameterValues("termsOfService");

        results.clear();
        results.put("email", email);
        results.put("password1", password1);
        results.put("password2", password2);

        if(termsOfService != null && termsOfService[0].equals("agree")) {
//            The user clicked the 'agree' box
            results.put("termsOfService", "agree");
        } else {
//            The user did not click the 'agree' box
            results.put("termsOfService", "");
        }

//        Validate form data
        User user = new User();
        try {
            user.setEmail(email);
        } catch(IllegalArgumentException e) {
            results.put("emailError", e.getMessage());
        }
        try {
            user.setPassword(password1.toCharArray());
        } catch(IllegalArgumentException e) {
            results.put("password1Error", e.getMessage());
        }
        if(!password1.equals(password2)) {
            results.put("password2Error", "Passwords don't match");
        }
        if(termsOfService != null && termsOfService[0].equals("agree")) {
//            The user clicked the 'agree' box
            results.put("termsOfService", "agree");
        } else {
//            The user did not click the 'agree' box
            results.put("termsOfService", "");
            results.put("termsOfServiceError", "You must agree to our terms of service.");
        }

//        Create a new user if no errors occurs
        if (!results.containsKey("emailError") && !results.containsKey("password1Error")
                && !results.containsKey("password2Error") && !results.containsKey("termsOfServiceError")
        ) {
            try {
                UserDAO.add(user);
                results.put("userAddSuccess", "User added");
            } catch (RuntimeException e) {
                results.put("userAddFail", "User not added");
            }
        }

        req.setAttribute("results", results);
        req.getRequestDispatcher("WEB-INF/day27/create-user.jsp").forward(req, resp);
    }
}
