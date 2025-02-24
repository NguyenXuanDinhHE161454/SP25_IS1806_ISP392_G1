package dto;

import lombok.Data;
import java.util.Date;

@Data
public class TransactionDTO {
    private int transactionId;
    private String transactionType;
    private String riceName;
    private String customerName;
    private String phoneNumber;
    private int quantity;
    private Date transactionDate;
    private boolean porterService;
    private double totalAmount;
}
