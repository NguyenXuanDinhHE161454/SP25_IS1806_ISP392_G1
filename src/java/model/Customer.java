package model;

import lombok.Data;

@Data
public class Customer {
    private int customerId;
    private String fullName;
    private String gender;
    private int age;
    private String address;
    private String phoneNumber;
}
