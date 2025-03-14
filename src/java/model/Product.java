package model;

import java.math.BigDecimal;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {
    private int id;
    private String name;
    private String image;
    private Integer quantity;
    private Integer zoneId;
    private String description;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private Short status;
    private Integer createdBy;
    private LocalDateTime createdAt;
    private Boolean isDeleted;
    private LocalDateTime deletedAt;
    private Integer deletedBy;
    private BigDecimal amount;
}