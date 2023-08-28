package com.harvey.day2;

import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class BankAccount {
    // Assume a class BankAccount exists with an instance variable called "balance" (a double).
    //
    //Write a toString method that could print "Your balance on May X, 20XX is $1,234.56". Substitute "May X, 20XX" with today's date. Substitute "1,234.56" with the balance.
    //
    //You must apply date and number formatting to earn full credit.
    private double balance;

    public BankAccount(double balance) {
        this.balance = balance;
    }

    @Override
    public String toString() {
        LocalDate today = LocalDate.now();
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("MMMM d, yyyy");
        // Source: https://stackoverflow.com/questions/2379221/how-to-format-decimals-in-a-currency-format
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
        return "Your balance on "  + today.format(dateFormat) + " is " + currencyFormat.format(balance);
    }

    // Describe how you call a static method.
    // You call static methods by typing a class name, a period, then the method name.
    // you call non-static methods by typing  an object name, a period, then the method name.
}
