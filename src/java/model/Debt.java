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
public class Debt {
    private int debtId;
    private int customerId;
    private int debtType;
    private BigDecimal amount;
    private String note;
    private LocalDateTime debtDate;
    private String description;
    private String evident;
    private String payload;
    private Integer createdBy;
    private LocalDateTime createdAt;
    private Boolean isDeleted;
    private LocalDateTime deletedAt;
    private Integer deletedBy;
}