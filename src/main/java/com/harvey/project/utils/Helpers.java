package com.harvey.project.utils;

import java.math.RoundingMode;
import java.text.DecimalFormat;

public class Helpers {
    public static String round(double d) {
        DecimalFormat df = new DecimalFormat("#.##########");
        df.setRoundingMode(RoundingMode.HALF_UP);
        return df.format(d);
    }

    public static boolean isANumber(String num) {
        try {
            Double.parseDouble(num);
            return true;
        } catch(NumberFormatException ex) {
            return false;
        }
    }
}
