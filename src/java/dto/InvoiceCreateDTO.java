package dto;

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
public class InvoiceCreateDTO {
    private Integer customerId;
    private String customerName;
    private String phoneNumber;
    private List<ProductItemDTO> productList;
    private BigDecimal totalAmount;
    private BigDecimal debtAmount;
    private LocalDateTime createdAt;
    private Integer createdBy;

}
