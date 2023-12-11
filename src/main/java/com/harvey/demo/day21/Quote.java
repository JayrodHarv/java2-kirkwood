package com.harvey.demo.day21;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.harvey.project.utils.Helpers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Quote implements Comparable<Quote> {
    @JsonProperty("_id")
    private String _id;

    @JsonProperty("content")
    private String content;

    @JsonProperty("author")
    private String author;

    @JsonProperty("tags")
    private List<String> tags;

    @JsonProperty("authorSlug")
    private String authorSlug;

    @JsonProperty("length")
    private String length;

    @JsonProperty("dateAdded")
    private String dateAdded;

    @JsonProperty("dateModified")
    private String dateModified;

    @Override
    public String toString() {
        return "Quote{" +
                "_id='" + _id + '\'' +
                ", content='" + content + '\'' +
                ", author='" + author + '\'' +
                ", tags=" + tags +
                ", authorSlug='" + authorSlug + '\'' +
                ", length='" + length + '\'' +
                ", dateAdded='" + dateAdded + '\'' +
                ", dateModified='" + dateModified + '\'' +
                '}';
    }

    public String get_id() {
        return _id;
    }

    public String getContent() {
        return content;
    }

    public String getAuthor() {
        return author;
    }

    public List<String> getTags() {
        return tags;
    }

    public String getAuthorSlug() {
        return authorSlug;
    }

    public String getLength() {
        return length;
    }

    public String getDateAdded() {
        return dateAdded;
    }

    public String getDateModified() {
        return dateModified;
    }

    @Override
    public int compareTo(@NotNull Quote o) {
        int result = this.getAuthor().compareTo(o.getAuthor());
        if(result == 0) {
            result = this.getAuthor().compareTo(o.getAuthor());
        }
        return result;
    }

    @WebServlet(name = "tempConverter", urlPatterns = {"/convert-temp", "/convert-temps"})
    public static class TempConverter extends HttpServlet {

        Map<String, String> results = new HashMap<>();

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("WEB-INF/day20/convert-temp.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String conversion = req.getParameter("conversion");
            String temperature = req.getParameter("temperature");
            results.clear();
            results.put("conversion", conversion);
            results.put("temperature", temperature);
            convertTemp(conversion, temperature);
            req.setAttribute("results", results);
            req.getRequestDispatcher("WEB-INF/day20/convert-temp.jsp").forward(req, resp);
        }

        private void convertTemp(String conversion, String temperature) {
            if(conversion == null || !conversion.equals("FtoC") && !conversion.equals("CtoF")) {
                results.put("conversionError", "Select a conversion type");
            }
            if(!Helpers.isANumber(temperature)) {
                results.put("temperatureError", "Please input a valid temperature");
            }
            if(!results.containsKey("conversionError") && !results.containsKey("temperatureError")) {
                double tempDouble = Double.parseDouble(temperature);
                if(conversion.equals("FtoC")) {
                    double tempConverted = (tempDouble - 32) * 5 / 9.0;
                    results.put("tempConverted", String.format("%s°F = %s°C", temperature, Helpers.round(tempConverted)));
                }
                if(conversion.equals("CtoF")) {
                    double tempConverted = tempDouble * 9/5.0 + 32;
                    results.put("tempConverted", String.format("%s°C = %s°F", temperature, Helpers.round(tempConverted)));
                }
            }
        }
    }
}
