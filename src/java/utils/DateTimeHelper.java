package utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeHelper {
    private static final String DEFAULT_PATTERN = "dd/MM/yyyy HH:mm";

    public static String formatDate(Date date) {
        return formatDate(date, DEFAULT_PATTERN);
    }

    public static String formatDate(Date date, String pattern) {
        if (date == null) {
            return "N/A";
        }
        SimpleDateFormat formatter = new SimpleDateFormat(pattern);
        return formatter.format(date);
    }
}
