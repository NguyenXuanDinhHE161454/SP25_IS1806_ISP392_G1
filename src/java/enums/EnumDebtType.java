/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package enums;

public enum EnumDebtType {
    CUSTOMER_BORROW(1, "Khách vay nợ"),
    CUSTOMER_PAY(2, "Khách trả nợ"),
    STORE_PAY(3, "Cửa hàng trả nợ"),
    STORE_OWE(4, "Cửa hàng vay nợ");

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
