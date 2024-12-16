package com.cl.cruella.util;

public class StringUtil {
    public static String convertNewlinesToBreaks(String input) {
        if (input == null || input.isEmpty()) {
            return "";
        }
        return input.replaceAll("\n", "<br>");
    }
}
