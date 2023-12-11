package com.harvey.data_access;

import com.harvey.demo.day25.User;
import com.harvey.project.utils.PasswordUtil;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.*;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends Database {
    public static void main(String[] args) throws SQLException {
        getAll().forEach(System.out::println);
    }

    public static List<User> getAll() {
        List<User> users = new ArrayList<>();

        try (Connection connection = getConnection()) {
            if (connection != null) {
                try (
//                        Statement statement = connection.createStatement();
//                        ResultSet resultSet = statement.executeQuery("SELECT * FROM user;");
                        CallableStatement statement = connection.prepareCall("{CALL sp_get_all_users()}");
                        ResultSet resultSet = statement.executeQuery();
                ) {
                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String firstName = resultSet.getString("first_name");
                        String lastName = resultSet.getString("last_name");
                        String email = resultSet.getString("email");
                        String phone = resultSet.getString("phone");
                        char[] password = resultSet.getString("password").toCharArray();
                        String language = resultSet.getString("language");
                        String status = resultSet.getString("status");
                        String privileges = resultSet.getString("privileges");
                        Instant created_at = resultSet.getTimestamp("created_at").toInstant();
                        Instant last_logged_in = resultSet.getTimestamp("last_logged_in").toInstant();
                        Instant updated_at = resultSet.getTimestamp("updated_at").toInstant();
                        User user = new User(id, firstName, lastName, email, phone, password, language, status, privileges, created_at, last_logged_in, updated_at);
                        users.add(user);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return users;
    }

    public static void add(User user) {
        try (Connection connection = getConnection()) {
            if (connection != null) {
                try (CallableStatement statement = connection.prepareCall("{CALL sp_add_user(?, ?)}")) {
                    statement.setString(1, user.getEmail());
                    String encryptedPassword = PasswordUtil.hashpw(new String(user.getPassword()));
                    statement.setString(2, encryptedPassword);
                    int numRowsAffected = statement.executeUpdate();
                    if (numRowsAffected == 0) {
                        throw new RuntimeException("Could not create user. Try again later");
                    }
                } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
                    throw new RuntimeException("Could not create user. Try again later");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Could not create user. Try again later");
        }
    }

    public static User get(String email) {
        User user = null;
        try (Connection connection = getConnection()) {
            if (connection != null) {
                try (CallableStatement statement = connection.prepareCall("{CALL sp_get_user(?)}")) {
                    statement.setString(1, email);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            int id = resultSet.getInt("id");
                            String firstName = resultSet.getString("first_name");
                            String lastName = resultSet.getString("last_name");
                            String phone = resultSet.getString("phone");
                            char[] password = resultSet.getString("password").toCharArray();
                            String language = resultSet.getString("language");
                            String status = resultSet.getString("status");
                            String privileges = resultSet.getString("privileges");
                            Instant created_at = resultSet.getTimestamp("created_at").toInstant();
                            Instant last_logged_in = resultSet.getTimestamp("last_logged_in").toInstant();
                            Instant updated_at = resultSet.getTimestamp("updated_at").toInstant();
                            user = new User(id, firstName, lastName, email, phone, password, language, status, privileges, created_at, last_logged_in, updated_at);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            System.out.println("Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
        }
        return user;
    }

    public static User update(User user) {
        try (Connection connection = getConnection()) {
            if (connection != null) {
                try (CallableStatement statement = connection.prepareCall("{CALL sp_update_user(?,?,?,?,?,?,?,?,?)}")) {
                    statement.setInt(1, user.getId());
                    statement.setString(2, user.getFirstName());
                    statement.setString(3, user.getLastName());
                    statement.setString(4, user.getEmail());
                    statement.setString(5, user.getPhone());
                    statement.setString(6, String.valueOf(user.getPassword()));
                    statement.setString(7, user.getLanguage());
                    statement.setString(8, user.getStatus());
                    statement.setString(9, user.getPrivileges());
                    int numRowsAffected = statement.executeUpdate();
                    if (numRowsAffected == 0) {
                        throw new RuntimeException("Could not update user. Try again later");
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            System.out.println("Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
        }
        return user;
    }
}
