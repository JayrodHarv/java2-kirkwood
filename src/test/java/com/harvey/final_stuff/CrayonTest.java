package com.harvey.final_stuff;

import com.harvey.demo.day16.Fraction;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class CrayonTest {

    @Test
    public void getColor() {
        String expected = "black";
        String actual = new Crayon().getColor();
        assertEquals(expected, actual);
    }

    @Test
    public void setColor() {
        String expected = "blue";
        Crayon crayon = new Crayon();
        crayon.setColor("blue");
        String actual = crayon.getColor();
        assertEquals(expected, actual);
    }

    @Test
    public void getPercentRemaining() {
        Double expected = 1.0;
        Double actual = new Crayon().getPercentRemaining();
        assertEquals(expected, actual);
    }

    @Test
    public void setPercentRemaining() {
        Double expected = 0.5;
        Crayon crayon = new Crayon();
        crayon.setPercentRemaining(0.5);
        Double actual = crayon.getPercentRemaining();
        assertEquals(expected, actual);
    }
}