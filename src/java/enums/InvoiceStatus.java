package enums;

public enum InvoiceStatus {
    PENDING(0),  
    COMPLETED(1), 
    NA(-1); // Giá trị mặc định nếu không khớp

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
        return NA; // Trả về N/A nếu không tìm thấy giá trị
    }
}
