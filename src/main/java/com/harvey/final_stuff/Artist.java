package com.harvey.final_stuff;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Artist {
    @JsonProperty("name")
    private String name;
    @JsonProperty("picture")
    private String picture;

    public String getName() {
        return name;
    }

    public String getPicture() {
        return picture;
    }
}
