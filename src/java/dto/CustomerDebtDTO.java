package dto;

import lombok.Data;

@Data
public class CustomerDebtDTO {
    private int customerId;
    private String customerName;
    private double totalDebt;

    public CustomerDebtDTO(int customerId, String customerName, double totalDebt) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.totalDebt = totalDebt;
    }
}