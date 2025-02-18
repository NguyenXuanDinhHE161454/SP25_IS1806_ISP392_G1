/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author trung
 */
public class TransactionDetail {
    private int id;
    private Transaction transaction;
    private Rice rice;
    private int quantity;
    private int price;
    private RiceRegion riceRegion;

    public TransactionDetail(int id, Transaction transaction, Rice rice, int quantity, int price, RiceRegion riceRegion) {
        this.id = id;
        this.transaction = transaction;
        this.rice = rice;
        this.quantity = quantity;
        this.price = price;
        this.riceRegion = riceRegion;
    }
    
    

    public TransactionDetail(int id, Transaction transaction, Rice rice, int quantity, int price) {
        this.id = id;
        this.transaction = transaction;
        this.rice = rice;
        this.quantity = quantity;
        this.price = price;
    }

    public RiceRegion getRiceRegion() {
        return riceRegion;
    }

    public void setRiceRegion(RiceRegion riceRegion) {
        this.riceRegion = riceRegion;
    }
    
    public TransactionDetail() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }

    public Rice getRice() {
        return rice;
    }

    public void setRice(Rice rice) {
        this.rice = rice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
    
    
}
