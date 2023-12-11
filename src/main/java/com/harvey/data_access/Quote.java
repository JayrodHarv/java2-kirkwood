package com.harvey.data_access;

import java.util.Date;

public class Quote {
    private int id;
    private String content;
    private String author;
    private Date date_added;

    public int getId() {
        return id;
    }

    public String getContent() {
        return content;
    }

    public String getAuthor() {
        return author;
    }

    public Date getDate_added() {
        return date_added;
    }

    public Quote(int id, String content, String author, Date date_added) {
        this.id = id;
        this.content = content;
        this.author = author;
        this.date_added = date_added;
    }
}
