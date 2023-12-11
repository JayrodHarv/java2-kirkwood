package com.harvey.final_stuff;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.harvey.demo.day21.User;

import java.util.List;

public class ArtistFromJson {
    @JsonProperty("data")
    private List<Artist> artists;

    public List<Artist> getArtists() {
        return artists;
    }
}
