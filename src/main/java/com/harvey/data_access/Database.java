package com.harvey.data_access;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    public static Connection getConnection() throws SQLException {
        Dotenv dotenv = Dotenv.load();
        String db_full_driver = dotenv.get("DB_FULL_DRIVER");
        String connectionString = dotenv.get("DB_CONNECTION_STRING");
        String user = dotenv.get("DB_USER");
        String password = dotenv.get("DB_PASSWORD");
        try {
            Class.forName(db_full_driver);
        } catch (ClassNotFoundException e) {
            // what to do if the driver is not found
        }
        Connection connection = DriverManager.getConnection(connectionString, user, password);
        if (connection.isValid(2)) {
            System.out.println("Connection successful");
            return connection;
        } else {
            return null;
        }
    }

    public static void showError(SQLException e) {

    }
}
