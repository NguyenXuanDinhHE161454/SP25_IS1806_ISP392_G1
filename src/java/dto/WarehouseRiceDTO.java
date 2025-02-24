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
public class WarehouseRiceDTO {
    private int sectionId;
    private String sectionName;
    private String riceName;
    private String description;
    private int quantity;
    private double price;
    private String loadCapacity; 
    private int riceId;

    public WarehouseRiceDTO(int sectionId, String sectionName, String riceName, String description, int quantity, int sectionCapacity, double price, int riceId) {
        this.sectionId = sectionId;
        this.sectionName = sectionName;
        this.riceName = riceName;
        this.description = description;
        this.quantity = quantity;
        this.loadCapacity = quantity + " kg"; 
        this.price = price;
        this.riceId = riceId;
    }
}
