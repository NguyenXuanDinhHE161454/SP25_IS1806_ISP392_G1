package dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InvoiceDTO {
    private int id;  // Will default to 0 naturally
    
    @Builder.Default
    private LocalDateTime createDate = LocalDateTime.now();  // Only field with explicit default
    
    private Integer type;  // Will default to null
    
    private BigDecimal payment;  // Will default to null
    
    private Integer customerId;  // Will default to null
    
    private String customerName;  // Will default to null
    
    private Integer userId;  // Will default to null
    
    private String userName;  // Will default to null
}