package com.harvey.final_stuff;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.harvey.demo.day2.Greeter;
import com.harvey.demo.day21.Quote;
import org.jetbrains.annotations.NotNull;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Crayon implements Comparable<Crayon> {
    private String color;
    private Double percentRemaining;

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Double getPercentRemaining() {
        return percentRemaining;
    }

    public void setPercentRemaining(Double percentRemaining) {
        if(percentRemaining < 0.0 || percentRemaining > 1.0) {
            throw new IllegalArgumentException("The percent remaining must be between 0 and 1.");
        }
        this.percentRemaining = percentRemaining;
    }

    public Crayon(String color, Double percentRemaining) {
        setColor(color);
        setPercentRemaining(percentRemaining);
    }

    public Crayon() {
        this.color = "black";
        this.percentRemaining = 1.0;
    }

    @Override
    public int compareTo(@NotNull Crayon o) {
        int result = this.getColor().compareTo(o.getColor());
        if(result == 0) {
            result = (this.getPercentRemaining().compareTo(o.getPercentRemaining()) > 0) ? 1 : 0;
        }
        return result;
    }

    @Override
    public String toString() {
        return color + " / " + percentRemaining;
    }

    public static void main(String[] args) {
        List<Crayon> crayons = new ArrayList<>();
        crayons.add(new Crayon("C", 1.0));
        crayons.add(new Crayon("B", 0.75));
        crayons.add(new Crayon("D", 0.5));
        crayons.add(new Crayon("C", 0.25));
        crayons.add(new Crayon("A", 0.0));

        System.out.println(crayons);
        crayons.sort(Crayon::compareTo);
        System.out.println(crayons);

        List<Crayon> copy = new ArrayList<>(crayons);
        copy.removeIf(crayon -> crayon.percentRemaining < 0.5);
        System.out.println(copy);

        Collections.sort(crayons, Collections.reverseOrder());
        System.out.println(crayons);
    }
}
