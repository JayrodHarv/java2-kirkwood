package com.harvey.demo.day21;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name="userJsonServlet", value="/user-json")
public class UserJsonServlet extends HttpServlet {
    private static List<User> users;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        String q = query != null ? query : "";
        List<User> copy = new ArrayList<>(users);
        copy.removeIf(user -> !user.getName().getFullname().toLowerCase().contains(q.toLowerCase()));
        req.setAttribute("users", copy);
        req.setAttribute("q", q);
        req.getRequestDispatcher("WEB-INF/day21/user-json.jsp").forward(req, resp);
    }

    @Override
    public void init() throws ServletException {
        try {
            JSONObject json = JsonReader.readJsonFromUrl("https://randomuser.me/api/?format=json&seed=abc&results=12&nat=us&noinfo");
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            UserFromJson userFromJson = mapper.readValue(json.toString(), UserFromJson.class);
            this.users = userFromJson.getUsers();
        } catch (IOException e) {

        }

    }
}
