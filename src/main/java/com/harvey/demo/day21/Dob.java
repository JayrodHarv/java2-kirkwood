package com.harvey.demo.day21;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Dob {
    @JsonProperty("date")
    private String date;

    @JsonProperty("age")
    private String age;

    public String getDate() {
        return date;
    }

    public String getAge() {
        return age;
    }

    @Override
    public String toString() {
        return "{" +
                "\n\t\tdate='" + date + '\'' +
                "\n\t\tage='" + age + '\'' +
                '}';
    }
}
