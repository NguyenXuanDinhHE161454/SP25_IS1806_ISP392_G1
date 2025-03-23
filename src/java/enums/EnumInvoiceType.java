package enums;

import java.util.Arrays;
import java.util.List;

/**
 * Enum for Invoice Types: Import (Nhập hàng) and Export (Xuất hàng)
 */
public enum EnumInvoiceType {
    IMPORT(1, "Nhập hàng"),
    EXPORT(2, "Xuất hàng");

    private final int code;
    private final String description;

    EnumInvoiceType(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public int getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    // Lấy enum theo mã code
    public static EnumInvoiceType getByCode(int code) {
        for (EnumInvoiceType type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid invoice type code: " + code);
    }

    // Lấy danh sách tất cả các loại hóa đơn
    public static List<EnumInvoiceType> getAll() {
        return Arrays.asList(EnumInvoiceType.values());
    }
}
