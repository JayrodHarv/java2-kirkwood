package com.harvey.demo.day16;

import java.math.BigInteger;

public class Fraction {
    private int numerator;
    private int denominator;

    public Fraction() {
        this.numerator = 1;
        this.denominator = 1;
    }

    public Fraction(int num, int den) {
        this.numerator = num;
        this.denominator = den;
    }

    @Override
    public String toString() {
        return this.numerator + "/" + this.denominator;
    }

    public int getNumerator() {
        return numerator;
    }

    public void setNumerator(int numerator) {
        this.numerator = numerator;
    }

    public int getDenominator() {
        return denominator;
    }

    public void setDenominator(int denominator) {
        if(denominator == 0) {
            throw new IllegalArgumentException();
        }
        this.denominator = denominator;
    }

    public static int greatestCommonDivisor(int num1, int num2){
        BigInteger i = BigInteger.valueOf(num1).gcd(BigInteger.valueOf(num2));
        int gcd = Integer.parseInt(i.toString());
        return gcd;
    }

    public Fraction simplify() {
        int gcd = greatestCommonDivisor(this.numerator, this.denominator);
        Fraction simplifiedFraction = new Fraction(this.numerator / gcd, this.denominator / gcd);
        if(simplifiedFraction.numerator >= 0 && simplifiedFraction.denominator < 0
                || simplifiedFraction.numerator < 0 && simplifiedFraction.denominator < 0) {
            simplifiedFraction.numerator *= -1;
            simplifiedFraction.denominator *= -1;
        }
        return simplifiedFraction;
    }

    public String mixedNumber(Fraction fraction) {
        Fraction simplified = fraction.simplify();
        if(simplified.denominator == 1) {
            return Integer.toString(simplified.numerator);
        } else if(simplified.denominator == 0) {
            return "0";
        } else if(simplified.numerator > simplified.denominator) {
            String mixedNum;
            int wholeNum;
            wholeNum = Math.floorDiv(simplified.numerator,simplified.denominator);
            mixedNum = wholeNum + " " + (simplified.numerator - wholeNum*simplified.denominator) + "/" + simplified.denominator;
            return mixedNum;
        } else if(simplified.numerator < 0 && Math.abs(simplified.numerator) > simplified.denominator) {
            String mixedNum;
            int wholeNum;
            int numerator = -simplified.numerator;
            wholeNum = Math.floorDiv(numerator,simplified.denominator);
            mixedNum = "-" + wholeNum + " " + (numerator - wholeNum*simplified.denominator) + "/" + simplified.denominator;
            return mixedNum;
        }

        return simplified.toString();



    }
}
