package com.harvey.demo.day21;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.jetbrains.annotations.NotNull;

import java.util.List;

public class Quote implements Comparable<Quote> {
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

    public String get_id() {
        return _id;
    }

    public String getContent() {
        return content;
    }

    public String getAuthor() {
        return author;
    }

    public List<String> getTags() {
        return tags;
    }

    public String getAuthorSlug() {
        return authorSlug;
    }

    public String getLength() {
        return length;
    }

    public String getDateAdded() {
        return dateAdded;
    }

    public String getDateModified() {
        return dateModified;
    }

    @Override
    public int compareTo(@NotNull Quote o) {
        int result = this.getAuthor().compareTo(o.getAuthor());
        if(result == 0) {
            result = this.getAuthor().compareTo(o.getAuthor());
        }
        return result;
    }
}
