package utils;

import enums.InvoiceStatus;
import java.util.HashMap;
import java.util.Map;

public class EnumHelper {

    // Map chứa mô tả cho từng InvoiceStatus
    private static final Map<InvoiceStatus, String> invoiceStatusDescriptions = new HashMap<>();

    static {
        invoiceStatusDescriptions.put(InvoiceStatus.PENDING, "Đang chờ xử lý");
        invoiceStatusDescriptions.put(InvoiceStatus.COMPLETED, "Hoàn thành");
    }

    /**
     * Lấy mô tả từ giá trị int của Enum.
     * @param value giá trị int từ DB hoặc logic ứng dụng
     * @return mô tả tương ứng hoặc "Không xác định" nếu không hợp lệ
     */
    public static String getInvoiceStatusDescription(int value) {
        try {
            InvoiceStatus status = InvoiceStatus.fromValue(value);
            return getInvoiceStatusDescription(status);
        } catch (IllegalArgumentException e) {
            return "-------";
        }
    }

    /**
     * Lấy mô tả từ Enum trực tiếp.
     * @param status Enum InvoiceStatus
     * @return mô tả tương ứng hoặc "Không xác định" nếu null
     */
    public static String getInvoiceStatusDescription(InvoiceStatus status) {
        return invoiceStatusDescriptions.getOrDefault(status, "-------");
    }

}
