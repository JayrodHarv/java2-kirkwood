package com.harvey.data_access;

import com.harvey.data_access.Quote;
import com.harvey.demo.day25.User;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class QuoteDAO extends Database {
    public static void main(String[] args) throws SQLException {
        getAll().forEach(System.out::println);
    }

    public static List<Quote> getAll() {
        List<Quote> quotes = new ArrayList<>();

        try(Connection connection = getConnection()) {
            if(connection != null) {
                try(
                    CallableStatement statement = connection.prepareCall("{CALL sp_select_all_quotes()}");
                    ResultSet resultSet = statement.executeQuery();
                ) {
                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String content = resultSet.getString("content");
                        String author = resultSet.getString("author");
                        Date date_added = resultSet.getDate("date_added");
                        Quote quote = new Quote(id, content, author, date_added);
                        quotes.add(quote);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return quotes;
    }
}
