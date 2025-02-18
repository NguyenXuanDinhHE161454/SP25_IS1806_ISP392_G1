/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author trung
 */
public class RiceRegion {
    private int id;
    private Rice rice;
    private Region region;
    private int quantity;   

    public RiceRegion() {
    }

    public RiceRegion(int id, Rice rice, Region region, int quantity) {
        this.id = id;
        this.rice = rice;
        this.region = region;
        this.quantity = quantity;
    }
    
    public RiceRegion(Rice rice, Region region, int quantity) {
        this.rice = rice;
        this.region = region;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    

    public Rice getRice() {
        return rice;
    }

    public void setRice(Rice rice) {
        this.rice = rice;
    }

    public Region getRegion() {
        return region;
    }

    public void setRegion(Region region) {
        this.region = region;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
}
