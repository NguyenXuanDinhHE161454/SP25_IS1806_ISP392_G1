/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package enums;

/**
 *
 * @author Admin
 */
public enum InvoiceStatus {
    PENDING(0),  // Maps to 0 in the database
    COMPLETED(1); // Maps to 1 in the database

    private final int value;

    InvoiceStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static InvoiceStatus fromValue(int value) {
        for (InvoiceStatus status : values()) {
            if (status.value == value) {
                return status;
            }
        }
        throw new IllegalArgumentException("Invalid InvoiceStatus value: " + value);
    }
}