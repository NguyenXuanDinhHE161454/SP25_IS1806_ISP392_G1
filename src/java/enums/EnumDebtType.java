/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package enums;

public enum EnumDebtType {
    CUSTOMER_BORROW(1, "Customer Borrow"),
    CUSTOMER_PAY(2, "Customer Pay"),
    STORE_OWE(3, "Store Owe"),
    STORE_PAY(4, "Store Pay");

    private final int code;
    private final String description;

    EnumDebtType(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public int getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    public static String getDescriptionByCode(int code) {
        for (EnumDebtType type : EnumDebtType.values()) {
            if (type.getCode() == code) {
                return type.getDescription();
            }
        }
        return "Unknown"; 
    }
}
