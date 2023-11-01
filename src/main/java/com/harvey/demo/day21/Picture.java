package com.harvey.demo.day21;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Picture {
    @JsonProperty("large")
    private String large;

    @JsonProperty("medium")
    private String medium;

    @JsonProperty("thumbnail")
    private String thumbnail;

    public String getLarge() {
        return large;
    }

    public String getMedium() {
        return medium;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    @Override
    public String toString() {
        return "{" +
                "\n\t\tlarge='" + large + '\'' +
                "\n\t\tmedium='" + medium + '\'' +
                "\n\t\tthumbnail='" + thumbnail + '\'' +
                '}';
    }
}
