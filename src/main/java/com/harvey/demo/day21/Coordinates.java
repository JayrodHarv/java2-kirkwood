package com.harvey.demo.day21;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Coordinates {
    @JsonProperty("latitude")
    private String latitude;

    @JsonProperty("longitude")
    private String longitude;

    public String getLatitude() {
        return latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    @Override
    public String toString() {
        return "{" +
                "\n\t\tlatitude='" + latitude + '\'' +
                "\n\t\tlongitude='" + longitude + '\'' +
                '}';
    }
}
