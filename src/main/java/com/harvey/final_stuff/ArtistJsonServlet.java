package com.harvey.final_stuff;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.harvey.demo.day21.JsonReader;
import com.harvey.demo.day21.User;
import jakarta.servlet.ServletConfig;
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

@WebServlet(name="artistServlet", value="/artist-page")
public class ArtistJsonServlet extends HttpServlet {
    private static List<Artist> artists;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        String q = query != null ? query : "";


        List<Artist> copy = new ArrayList<>(artists);

        if(!q.isBlank()) {
            copy.removeIf(artist -> !artist.getName().toLowerCase().contains(q.toLowerCase()));
        }

        req.setAttribute("artists", copy);
        req.setAttribute("q", q);
        req.getRequestDispatcher("WEB-INF/day21/artist-page.jsp").forward(req, resp);
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        try {
            JSONObject json = JsonReader.readJsonFromUrl("https://api.deezer.com/search/artist?results=10");
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            ArtistFromJson artistFromJson = mapper.readValue(json.toString(), ArtistFromJson.class);
            this.artists = artistFromJson.getArtists();
        } catch (IOException e) {

        }
    }
}
