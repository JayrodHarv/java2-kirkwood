package com.harvey.demo.day21;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.List;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class JsonReader {

    private static String readAll(Reader rd) throws IOException {
        StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
            sb.append((char) cp);
        }
        return sb.toString();
    }

    public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
        InputStream is = new URL(url).openStream();
        try {
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            String jsonText = readAll(rd);
            JSONObject json = new JSONObject(jsonText);
            return json;
        } finally {
            is.close();
        }
    }

    public static String readJsonTextFromUrl(String url) throws IOException, JSONException {
        InputStream is = new URL(url).openStream();
        try {
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            String jsonText = readAll(rd);
            return jsonText;
        } finally {
            is.close();
        }
    }


    public static void main(String[] args) throws IOException, JSONException {
        JSONObject json = readJsonFromUrl("https://randomuser.me/api/?format=json&seed=abc&results=5&nat=us&inc=login,dob,name,location,email,phone,gender,cell,nat&noinfo");
        String quoteListJsonText = readJsonTextFromUrl("https://api.quotable.io/quotes/random?format=json&limit=5");
//        System.out.println(quoteListJsonText);
        ObjectMapper mapper = new ObjectMapper();
        List<Quote> quoteList = mapper.readValue(quoteListJsonText, new TypeReference<List<Quote>>() {});
//        UserFromJson userFromJson = mapper.readValue(json.toString(), UserFromJson.class);
//        QuoteFromJson quoteFromJson = mapper.readValue(quoteListJson.toString(), QuoteFromJson.class);
//        userFromJson.getUsers().forEach(System.out::println);
        quoteList.forEach(System.out::println);
    }
}
