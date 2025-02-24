package model;

import lombok.Data;
import java.util.Date;

@Data
public class TransactionHistory {
    private int historyId;
    private int transactionId;
    private Integer customerId; // Có thể null nếu khách bị xóa
    private Date transactionDate;
}
