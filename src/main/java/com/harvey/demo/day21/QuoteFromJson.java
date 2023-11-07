package com.harvey.demo.day21;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class QuoteFromJson {
    @JsonProperty("results")
    private List<Quote> quotes;

    public List<Quote> getQuotes() {
        return quotes;
    }
}
