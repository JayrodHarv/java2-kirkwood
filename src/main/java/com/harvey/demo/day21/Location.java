package com.harvey.demo.day21;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Location {
    @JsonProperty("street")
    private Street street;

    @JsonProperty("city")
    private String city;

    @JsonProperty("state")
    private String state;

    @JsonProperty("country")
    private String country;

    @JsonProperty("postcode")
    private String postcode;

    @JsonProperty("coordinates")
    private Coordinates coordinates;

    @JsonProperty("timezone")
    private Timezone timezone;

    public Street getStreet() {
        return street;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getCountry() {
        return country;
    }

    public String getPostcode() {
        return postcode;
    }

    public Coordinates getCoordinates() {
        return coordinates;
    }

    public Timezone getTimezone() {
        return timezone;
    }

    @Override
    public String toString() {
        return "{" +
                "\n\t\tstreet=" + street +
                "\n\t\tcity='" + city + '\'' +
                "\n\t\tstate='" + state + '\'' +
                "\n\t\tcountry='" + country + '\'' +
                "\n\t\tpostcode='" + postcode + '\'' +
                "\n\t\tcoordinates=" + coordinates +
                "\n\t\ttimezone=" + timezone +
                '}';
    }
}
