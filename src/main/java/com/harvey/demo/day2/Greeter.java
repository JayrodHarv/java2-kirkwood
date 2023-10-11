package com.harvey.demo.day2;

import java.time.*;
public class Greeter {

    // The following code displays "Good Morning", "Good Afternoon", or "Good Evening"
    // based on the current time of day.
    // Re-write the if-else chain as a ternary operator on a single line.
    public static String greet(ZonedDateTime currentDateTime) {
        int hourOfDay = currentDateTime.getHour(); // returns the hour-of-day, from 0 to 23
//        if(hourOfDay < 12){
//            return "Good Morning";
//        } else if(hourOfDay < 17){
//            return "Good Afternoon";
//        } else {
//            return "Good Evening";
//        }
        return (hourOfDay < 12) ? "Good Morning" : (hourOfDay < 17) ? "Good Afternoon" : "Good Evening";
    }
    public static void main(String args[]) {
        ZonedDateTime now = ZonedDateTime.now(ZoneOffset.UTC);
        ZonedDateTime zonedDateTime = now.withZoneSameInstant(ZoneId.of("America/Chicago"));
        System.out.println(greet(zonedDateTime));
    }
}
