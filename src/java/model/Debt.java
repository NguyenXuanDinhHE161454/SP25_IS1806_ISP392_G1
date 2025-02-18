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
public class Debt {
    private int id;
    private Customer customer;
    private String detail;
    private int amount;
    private int type;
    private java.sql.Date date;
    private boolean status;
    public Debt() {
    }

    public Debt(int id, Customer customer, String transaction, int amount, int type, Date date) {
        this.id = id;
        this.customer = customer;
        this.detail = transaction;
        this.amount = amount;
        this.type = type;
        this.date = date;
    }

    public Debt(int id, Customer customer, String transaction, int amount, int type, Date date, boolean status) {
        this.id = id;
        this.customer = customer;
        this.detail = transaction;
        this.amount = amount;
        this.type = type;
        this.date = date;
        this.status = status;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }
    
    
    
}
