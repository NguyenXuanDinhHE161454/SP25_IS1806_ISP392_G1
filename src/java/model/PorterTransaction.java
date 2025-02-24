package model;

import lombok.Data;

@Data
public class PorterTransaction {
    private int porterTransactionId;
    private int transactionId;
    private double porterFee;
}
