package com.penske.CEM.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import core.CustomLogger;

public class JavaHelper {
    private static CustomLogger log = new CustomLogger();
    // function to generate a random string
    public static String getStringOfLength(int n, String type) {
        String stringType = null;
        switch (type) {
            case "AlphaNumeric":
                stringType = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz";
                break;
            case "Numeric":
                stringType = "0123456789";
                break;
            case "SpecialCharacter":
                stringType = "!@#$%^&*()~";
                break;
            case "String":
                stringType = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "abcdefghijklmnopqrstuvxyz";
                break;
            case "AlphaNumericSpecialCharacter":
                stringType = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz" + "!@#$%^&*()~";
                break;
            default:
                log.error("Looks invalid input please check.");
        }

        StringBuilder sb = new StringBuilder(n);
        for (int i = 0; i < n; i++) {
            assert stringType != null;
            int index = (int) (stringType.length() * Math.random());
            sb.append(stringType.charAt(index));
        }

        return sb.toString();
    }

    public static int getRandomDigitsOfLength(int max) {
        int min = 1;
        return (int) Math.floor(Math.random() * (max - min + 1) + min);
    }

    public static String getDate(int n, String format) {
        Calendar c = Calendar.getInstance();
        c.add(Calendar.DATE, n);
        Date date = c.getTime();
        SimpleDateFormat formatter = new SimpleDateFormat(format);
        return formatter.format(date);
    }

    public static String weekendFullDate() {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
        SimpleDateFormat sdf = new SimpleDateFormat("MMMM-d-YYYY");
        String weekendDate = sdf.format(c.getTime());
        return weekendDate;
    }

    public static boolean verifyDateFormat(String date) {

        // Create a regular expression to match the date format.
        Pattern pattern = Pattern.compile("^\\d{2}/\\d{2}/\\d{4} \\s \\d{2}:\\d{2} [AP]M$");

        // Match the date against the regular expression.
        Matcher matcher = pattern.matcher(date);

        // Return true if the date matches the format, false otherwise.
        return matcher.matches();
    }

    public static String addDaysSkippingWeekends(int days) {
        LocalDate result = LocalDate.now();
        int addedDays = 0;
        while (addedDays < days) {
            result = result.plusDays(1);
            if (!(result.getDayOfWeek() == DayOfWeek.SATURDAY || result.getDayOfWeek() == DayOfWeek.SUNDAY)) {
                ++addedDays;
            }
        }
        return result.format(DateTimeFormatter.ofPattern("MMMM-YYYY-d"));
    }

    public static String currentFullDate(String format) {
        Calendar cal = GregorianCalendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat(format);
        Date currentMonth = new Date();
        cal.setTime(currentMonth);
        cal.set(Calendar.MONTH, cal.get(Calendar.MONTH));
        return df.format(cal.getTime());
    }

    public static String estTimeAndDate(String dateFormat) {
        SimpleDateFormat etDf = new SimpleDateFormat(dateFormat);
        TimeZone etTimeZone = TimeZone.getTimeZone("America/New_York");
        etDf.setTimeZone(etTimeZone);
        Date currentDate = new Date();
        Calendar currentTime = Calendar.getInstance();
        return etDf.format(currentDate.getTime());
    }

    public static String convertUTCTimeToEST(String dt, String dateFormat) throws ParseException {
        SimpleDateFormat sdfOriginal = new SimpleDateFormat(dateFormat);
        sdfOriginal.setTimeZone(TimeZone.getTimeZone("UTC"));
        Date date1 = sdfOriginal.parse(dt);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date1);
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
        sdf.setTimeZone(TimeZone.getTimeZone("America/New_York"));
        return sdf.format(calendar.getTime());
    }

    public static String currentUTCDate() {
        Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm a");
        df.setTimeZone(cal.getTimeZone());
        return df.format(cal.getTime());
    }

    public static String nextMonday(String dateFormat) {
        Calendar now = Calendar.getInstance();
        int weekday = now.get(Calendar.DAY_OF_WEEK);
        if (weekday != Calendar.MONDAY) {
            int days = (Calendar.SATURDAY - weekday + 2) % 7;
            now.add(Calendar.DAY_OF_YEAR, days);
        }
        Date date = now.getTime();
        return new SimpleDateFormat(dateFormat).format(date);
    }

    public static void test(){
        System.out.println("*********************");
    }
}