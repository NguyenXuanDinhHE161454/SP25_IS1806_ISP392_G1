package dto;

import lombok.Data;
import java.util.Date;

@Data
public class DebtDTO {
    private int debtId;
    private int customerId;
    private String customerName;
    private String phoneNumber;
    private String debtType;
    private double amount;
    private String note;
    private Date debtDate;
}
