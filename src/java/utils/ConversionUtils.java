/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.math.BigDecimal;

/**
 *
 * @author Admin
 */
public class ConversionUtils {

    public static int toInt(String value, int defaultValue) {
        if (value == null || value.isEmpty()) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    public static BigDecimal toBigDecimal(String value, BigDecimal defaultValue) {
        if (value == null || value.isEmpty()) {
            return defaultValue;
        }
        try {
            return new BigDecimal(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private BigDecimal parseBigDecimal(String value, String errorMessage) {
        if (value == null || value.isEmpty()) {
            throw new IllegalArgumentException(errorMessage);
        }
        try {
            return new BigDecimal(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(errorMessage, e);
        }
    }

    private int parseInteger(String value, String errorMessage) {
        if (value == null || value.isEmpty()) {
            throw new IllegalArgumentException(errorMessage);
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(errorMessage, e);
        }
    }
}
