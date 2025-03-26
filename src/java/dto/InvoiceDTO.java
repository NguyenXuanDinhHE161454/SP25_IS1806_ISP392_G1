package dto;

import enums.InvoiceStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InvoiceDTO {

    private int id;
    private InvoiceStatus status;
    private LocalDateTime createDate;
    private Integer userId;
    private String userName;
    private BigDecimal payment;
    private Integer customerId;
    private String customerName;
    private Integer totalQuantity;
    private BigDecimal totalAmount;
    private BigDecimal paidAmount;
    private BigDecimal debtAmount;
    private String description;
    private int type;
    private int createById;
    private List<ProductItemDTO> products;

    public boolean isCompleted() {
        return debtAmount != null && debtAmount.compareTo(BigDecimal.ZERO) <= 0;
    }
}
