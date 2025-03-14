package dto;

import lombok.Data;

@Data
public class WarehouseRiceDTO {
    private int sectionId;        
    private String riceName;     
    private int capacity;          
    private int currentWeight;     
    private int remainingCapacity; 
}
