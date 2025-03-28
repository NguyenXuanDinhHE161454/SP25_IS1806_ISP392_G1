package dto;

import enums.InvoiceStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import model.Debt; // Thêm import cho Debt
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InvoiceDetailDTO {

    private int id;
    private InvoiceStatus status;
    private LocalDateTime createDate;
    private Integer userId;
    private String userName;
    private Integer customerId;
    private Integer amountPerKg; // Có vẻ không cần thiết trong DTO này, nhưng giữ lại theo code gốc
    private String customerName;
    private Integer totalQuantity;
    private BigDecimal totalAmount;
    private BigDecimal paidAmount;
    private BigDecimal debtAmount;
    private List<ProductItemDTO> products;
    private Debt debt; // Thêm thuộc tính Debt để lưu thông tin nợ

    public boolean isCompleted() {
        return debtAmount != null && debtAmount.compareTo(BigDecimal.ZERO) <= 0;
    }
}