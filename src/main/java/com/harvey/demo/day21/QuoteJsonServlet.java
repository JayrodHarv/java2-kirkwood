package com.harvey.demo.day21;

import com.fasterxml.jackson.core.type.TypeReference;
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

@WebServlet(name="quoteJsonServlet", value="/typing-test-json")
public class QuoteJsonServlet extends HttpServlet {
    private static List<Quote> quotes;
    private static List<String> authors;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        String sort = req.getParameter("sort");
        String author = req.getParameter("author");
        String q = query != null ? query : "";
        String s = sort != null ? sort : "";
        String ar = author != null ? author : "";


        List<Quote> copy = new ArrayList<>(quotes);

        if(!q.isBlank()) {
            copy.removeIf(quote -> !quote.getAuthor().toLowerCase().contains(q.toLowerCase()));
        }
        if(!ar.isBlank()) {
            copy.removeIf(quote -> !quote.getAuthor().equals(ar));
        }

        if(s.equals("az")) {
            Collections.sort(copy);
        } else {
            copy.sort(Comparator.reverseOrder());
        }


        req.setAttribute("quotes", copy);
        req.setAttribute("authors", authors);
        req.setAttribute("q", q);
        req.setAttribute("s", s);
        req.getRequestDispatcher("WEB-INF/day21/typing-test-json.jsp").forward(req, resp);
    }

    @Override
    public void init() throws ServletException {
        try {
            String json = JsonReader.readJsonTextFromUrl("https://api.quotable.io/quotes/random?format=json&limit=50");
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            List<Quote> quoteList = mapper.readValue(json, new TypeReference<List<Quote>>() {});
            this.quotes = quoteList;
            authors = new ArrayList<>();
            for(Quote quote : quotes) {
                String author = quote.getAuthor();
                if(!authors.contains(author)) {
                    authors.add(author);
                }
            }
            Collections.sort(authors);
        } catch (IOException e) {

        }

    }
}
