package model;

import lombok.Data;

@Data
public class Staff {
    private int staffId;
    private int ownerId;
    private String fullName;
    private String phoneNumber;
    private String address;
    private String username;
    private String passwordHash;
}
