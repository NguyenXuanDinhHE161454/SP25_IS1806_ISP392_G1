package dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CustomerDebtDTO {
    private String customerId;
    private String fullName;      
    private String phoneNumber;   
    private String address;       
    private BigDecimal debtAmount; 
}