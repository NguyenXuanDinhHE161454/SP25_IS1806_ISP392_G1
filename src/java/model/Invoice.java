package model;

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
public class Invoice {
    private int id;
    private LocalDateTime createDate;
    private BigDecimal payment;
    private BigDecimal paidAmount;
    private Integer customerId;
    private Integer userId;
    private Integer type;
    private Integer createdBy;
    private LocalDateTime createdAt;
    private Boolean isDeleted;
    private LocalDateTime deletedAt;
    private Integer deletedBy;
    private String description;
}