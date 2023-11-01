package com.harvey.demo.day21;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Timezone {
    @JsonProperty("offset")
    private String offset;

    @JsonProperty("description")
    private String description;

    public String getOffset() {
        return offset;
    }

    public String getDescription() {
        return description;
    }

    @Override
    public String toString() {
        return "{" +
                "\n\t\toffset='" + offset + '\'' +
                "\n\t\tdescription='" + description + '\'' +
                '}';
    }
}
