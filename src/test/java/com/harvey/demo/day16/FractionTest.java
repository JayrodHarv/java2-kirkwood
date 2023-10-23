package com.harvey.demo.day16;

import com.harvey.demo.day16.Fraction;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class FractionTest {
    @Test
    public void defaultConstructor() {
        String expected = "1/1";
        String actual = new Fraction().toString();
        assertEquals(expected, actual);
    }

    @Test
    public void parameterizedConstructor() {
        Fraction fraction = new Fraction(27, 6);
        String expected = "27/6";
        String actual = fraction.toString();
        assertEquals(expected, actual);
    }

    @Test
    public void getNumerator() {
        int expected = 1;
        int actual = new Fraction().getNumerator();
        assertEquals(expected, actual);
    }

    @Test
    public void getDenominator() {
        int expected = 1;
        int actual = new Fraction().getDenominator();
        assertEquals(expected, actual);
    }

    @Test
    public void setDenominator() {
        int expected = 30;
        Fraction fraction = new Fraction();
        fraction.setDenominator(30);
        int actual = fraction.getDenominator();
        assertEquals(expected, actual);
        assertThrows(IllegalArgumentException.class, () -> fraction.setDenominator(0));
    }

    @Test
    public void setNumerator() {
        int expected = 30;
        Fraction fraction = new Fraction();
        fraction.setNumerator(30);
        int actual = fraction.getNumerator();
        assertEquals(expected, actual);
    }

    @Test
    public void greatestCommonFactor() {
        int actual = Fraction.greatestCommonDivisor(75, 45);
        int expected = 15;
        assertTrue(expected == actual);
        assertEquals(2, Fraction.greatestCommonDivisor(2, 4));
    }

    @Test
    public void testDoubles() {
        double expected = 3.3;
        double actual = 1.1 + 2.2;
        assertEquals(expected, actual, 0.001);
    }

    @Test
    public void simplify() {
        Fraction fraction1 = new Fraction(75, 45);
        String simplified1 = fraction1.simplify().toString();
        assertEquals(simplified1, "5/3");

        Fraction fraction2 = new Fraction(2, 4);
        String simplified2 = fraction2.simplify().toString();
        assertEquals(simplified2, "1/2");

        Fraction fraction3 = new Fraction(5, 7);
        String simplified3 = fraction3.simplify().toString();
        assertTrue(simplified3.equals("5/7"));

        Fraction fraction4 = new Fraction(-2, 4);
        String simplified4 = fraction4.simplify().toString();
        assertTrue(simplified4.equals("-1/2"));

        Fraction fraction5 = new Fraction(2, -4);
        Fraction simplifiedFraction5 = fraction5.simplify();
        assertEquals(simplifiedFraction5.getNumerator(), -1);
        assertTrue(simplifiedFraction5.getDenominator() == 2);

        Fraction fraction6 = new Fraction(-2,-4);
        Fraction simplifiedFraction6 = fraction6.simplify();
        assertEquals(simplifiedFraction6.getNumerator(), 1);
        assertTrue(simplifiedFraction6.getDenominator() == 2);
    }

    @Test
    public void mixedNumber() {
        Fraction fraction = new Fraction(4, 1);
        assertEquals("4", fraction.mixedNumber(fraction));

        fraction = new Fraction(0, 4);
        assertEquals("0", fraction.mixedNumber(fraction));

        fraction = new Fraction(4, 4);
        assertEquals("1", fraction.mixedNumber(fraction));

        fraction = new Fraction(8, 4);
        assertEquals("2", fraction.mixedNumber(fraction));

        fraction = new Fraction(4, 8);
        assertEquals("1/2", fraction.mixedNumber(fraction));

        fraction = new Fraction(13, 5);
        assertEquals("2 3/5", fraction.mixedNumber(fraction));

        fraction = new Fraction(-13, 5);
        assertEquals("-2 3/5", fraction.mixedNumber(fraction));

        fraction = new Fraction(13, -5);
        assertEquals("-2 3/5", fraction.mixedNumber(fraction));

        fraction = new Fraction(-13, -5);
        assertEquals("2 3/5", fraction.mixedNumber(fraction));

        fraction = new Fraction(-4, -5);
        assertEquals("4/5", fraction.mixedNumber(fraction));
    }
}
