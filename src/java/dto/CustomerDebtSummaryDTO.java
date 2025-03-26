package dto;

import enums.EnumDebtType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CustomerDebtSummaryDTO {
    private int customerId;           // ID tên khách
    private String fullName;          // Tên khách (derived from customer)
    private String phoneNumber;       // Số điện thoại
    private String address;           // Địa chỉ
    private BigDecimal debtAmount;    // Nợ phải thu khách
    private BigDecimal amountPaid;    // Nợ đã trả trước
    private BigDecimal balance;       // Hạn mức (calculated: debtAmount - amountPaid)
    private String debtType;          // Description of the debt type (e.g., "Customer Borrow")

    // Constructor to calculate balance and set debt type
    public CustomerDebtSummaryDTO(int customerId, String fullName, String phoneNumber, String address,
                                  BigDecimal debtAmount, BigDecimal amountPaid, int debtTypeCode) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.debtAmount = debtAmount != null ? debtAmount : BigDecimal.ZERO;
        this.amountPaid = amountPaid != null ? amountPaid : BigDecimal.ZERO;
        this.balance = this.debtAmount.subtract(this.amountPaid).max(BigDecimal.ZERO); // Ensure non-negative balance
        this.debtType = EnumDebtType.getDescriptionByCode(debtTypeCode); // Map code to description
    }
}