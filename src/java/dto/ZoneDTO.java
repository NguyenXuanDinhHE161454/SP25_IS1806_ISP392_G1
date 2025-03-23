/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import lombok.Data;

@Data
public class ZoneDTO {

    private int zoneId;
    private String zoneName;
    private int productId;
    private String productName;
    private int stock; 
}