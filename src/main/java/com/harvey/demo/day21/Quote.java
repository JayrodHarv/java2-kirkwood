package com.harvey.demo.day21;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class Quote {
    @JsonProperty("_id")
    private String _id;

    @JsonProperty("content")
    private String content;

    @JsonProperty("author")
    private String author;

    @JsonProperty("tags")
    private List<String> tags;

    @JsonProperty("authorSlug")
    private String authorSlug;

    @JsonProperty("length")
    private String length;

    @JsonProperty("dateAdded")
    private String dateAdded;

    @JsonProperty("dateModified")
    private String dateModified;

    @Override
    public String toString() {
        return "Quote{" +
                "_id='" + _id + '\'' +
                ", content='" + content + '\'' +
                ", author='" + author + '\'' +
                ", tags=" + tags +
                ", authorSlug='" + authorSlug + '\'' +
                ", length='" + length + '\'' +
                ", dateAdded='" + dateAdded + '\'' +
                ", dateModified='" + dateModified + '\'' +
                '}';
    }
}
