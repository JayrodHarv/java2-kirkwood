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
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@WebServlet(name="userJsonServlet", value="/user-json")
public class UserJsonServlet extends HttpServlet {
    private static List<User> users;
    private static List<String> states;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        String sort = req.getParameter("sort");
        String state = req.getParameter("state");
        String q = query != null ? query : "";
        String s = sort != null ? sort : "";
        String st = state != null ? state : "";


        List<User> copy = new ArrayList<>(users);

        if(!q.isBlank()) {
            copy.removeIf(user -> !user.getName().getFullname().toLowerCase().contains(q.toLowerCase()));
        }
        if(!st.isBlank()) {
            copy.removeIf(user -> !user.getLocation().getState().equals(st));
        }

        if(s.equals("az")) {
            Collections.sort(copy);
        } else {
            copy.sort(Comparator.reverseOrder());
        }


        req.setAttribute("users", copy);
        req.setAttribute("states", states);
        req.setAttribute("q", q);
        req.setAttribute("s", s);
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
            states = new ArrayList<>();
            for(User user : users) {
                String state = user.getLocation().getState();
                if(!states.contains(state)) {
                    states.add(state);
                }
            }
            Collections.sort(states);
        } catch (IOException e) {

        }

    }
}
