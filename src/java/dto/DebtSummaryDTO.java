/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import lombok.Data;

/**
 *
 * @author Admin
 */
@Data
public class DebtSummaryDTO {
    private int customerId;
    private String customerName;
    private String phoneNumber;
    private double totalDebt;
}
