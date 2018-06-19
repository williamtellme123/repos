package main.java.timedateutils;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
public class Test {

    public static void getCurrentTimeUsingDate() {
        Date date = new Date();
        String strDateFormat = "hh:mm:ss a";
        DateFormat dateFormat = new SimpleDateFormat(strDateFormat);
        String formattedDate = dateFormat.format(date);
        System.out.println("Current time of the day using Date - 12 hour format: " + formattedDate);

    }

    public static void getCurrentTimeUsingCalendar() {
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        String formattedDate = dateFormat.format(date);
        System.out.println("Current time of the day using Calendar - 24 hour format: " + formattedDate);
    }

    public static void testGetCurrentTimeUsingDate() throws Exception {
        getCurrentTimeUsingDate();

    }

    public static void testGetCurrentTimeUsingCalendar() throws Exception {
        getCurrentTimeUsingCalendar();
    }

    public static void main(String[] args) throws Exception {

        System.out.println("---------------");
        testGetCurrentTimeUsingCalendar();
        System.out.println("---------------");
        testGetCurrentTimeUsingDate();
        System.out.println("---------------");

    } // eom
} // eoc
