/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author trung
 */
public class Transaction {
    private int id;
    private int type;
    private User user;
    private java.sql.Timestamp date;
    private boolean porterInvolved;
    private int porterBags;
    private int porterFee; 
    private int amount;
    private Customer customer;
    private String suplier;

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getSuplier() {
        return suplier;
    }

    public void setSuplier(String suplier) {
        this.suplier = suplier;
    }
    
    public Transaction(int id, int type, User user, java.sql.Timestamp date, boolean porterInvolved, int porterBags, int porterFee) {
        this.id = id;
        this.type = type;
        this.user = user;
        this.date = date;
        this.porterInvolved = porterInvolved;
        this.porterBags = porterBags;
        this.porterFee = porterFee;
    }

    public Transaction(int id, int type, User user, java.sql.Timestamp date, boolean porterInvolved, int porterBags, int porterFee, int amount) {
        this.id = id;
        this.type = type;
        this.user = user;
        this.date = date;
        this.porterInvolved = porterInvolved;
        this.porterBags = porterBags;
        this.porterFee = porterFee;
        this.amount = amount;
    }
    
    public Transaction() {
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public java.sql.Timestamp getDate() {
        return date;
    }

    public void setDate(java.sql.Timestamp date) {
        this.date = date;
    }

    public boolean isPorterInvolved() {
        return porterInvolved;
    }

    public void setPorterInvolved(boolean porterInvolved) {
        this.porterInvolved = porterInvolved;
    }

    public int getPorterBags() {
        return porterBags;
    }

    public void setPorterBags(int porterBags) {
        this.porterBags = porterBags;
    }

    public int getPorterFee() {
        return porterFee;
    }

    public void setPorterFee(int porterFee) {
        this.porterFee = porterFee;
    }
    
    
}
